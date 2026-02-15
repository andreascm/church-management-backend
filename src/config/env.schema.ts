import { z } from 'zod';

export const envSchema = z.object({
    // Application
    NODE_ENV: z.enum(['development', 'production', 'test']).default('development'),
    PORT: z.coerce.number().int().positive().default(3000),
    API_PREFIX: z.string().default('api'),

    // Logging
    LOG_LEVEL: z.enum(['error', 'warn', 'info', 'debug', 'verbose']).default('info'),
    LOG_PRETTY: z.coerce.boolean().default(false),
});

export type EnvConfig = z.infer<typeof envSchema>;
