import { envSchema, EnvConfig } from './env.schema';

export const configuration = (): EnvConfig => {
    const parsed = envSchema.safeParse(process.env);

    if (!parsed.success) {
        console.error('❌ Invalid environment variables:');
        console.error(JSON.stringify(parsed.error.format(), null, 2));
        throw new Error('Invalid environment variables');
    }

    return parsed.data;
};

export default configuration;
