import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { EnvConfig } from './config/env.schema';

async function bootstrap() {
    const app = await NestFactory.create(AppModule);

    const configService = app.get(ConfigService<EnvConfig, true>);

    // Get configuration values
    const port = configService.get('PORT', { infer: true });
    const apiPrefix = configService.get('API_PREFIX', { infer: true });

    // Global prefix
    app.setGlobalPrefix(apiPrefix);

    // Global validation pipe
    app.useGlobalPipes(
        new ValidationPipe({
            whitelist: true,
            transform: true,
            forbidNonWhitelisted: true,
        }),
    );

    await app.listen(port);
    console.log(`🚀 Application is running on: http://localhost:${port}/${apiPrefix}`);
    console.log(`📝 Environment: ${configService.get('NODE_ENV', { infer: true })}`);
}

bootstrap();
