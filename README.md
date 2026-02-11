# Church App Backend

A robust backend application for church management built with modern technologies and clean architecture principles.

## Tech Stack

| Layer      | Technology                    |
|------------|-------------------------------|
| Language   | TypeScript                    |
| Runtime    | Node.js 18+                   |
| Framework  | NestJS                        |
| API        | REST                          |
| Database   | PostgreSQL                    |
| ORM        | Prisma                        |
| Auth       | JWT + argon2 + TOTP          |
| Events     | Outbox + Postgres NOTIFY      |
| Cache      | Redis (optional)              |
| Logging    | pino                          |
| Deployment | Docker                        |

## Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

- **Domain Layer**: Pure business logic, no framework dependencies
- **Application Layer**: Use cases, commands, queries, and handlers
- **Infrastructure Layer**: Database implementations, external services
- **Presentation Layer**: HTTP controllers and DTOs

## Prerequisites

- Node.js 18 or higher
- PostgreSQL 14+
- Redis (optional)
- Docker & Docker Compose

## Project Structure
```
church-app-backend/
│
├── src/
│   ├── main.ts                      # Application entry point
│   ├── app.module.ts                # Root module
│   │
│   ├── config/                      # Configuration management
│   │   ├── configuration.ts
│   │   ├── env.schema.ts
│   │   └── config.module.ts
│   │
│   ├── shared/                      # Shared infrastructure
│   │   ├── database/                # Prisma setup
│   │   ├── outbox/                  # Outbox pattern for events
│   │   ├── auth/                    # JWT strategy & guards
│   │   ├── feature-flags/           # Feature flag service
│   │   ├── crypto/                  # Encryption service
│   │   └── logging/                 # Pino logger
│   │
│   ├── modules/                     # Business modules
│   │   └── identity/                # Identity & Access Management
│   │       ├── presentation/        # Controllers & DTOs
│   │       ├── application/         # Commands, queries, handlers
│   │       ├── domain/              # Entities, events, repositories
│   │       └── infrastructure/      # Prisma implementations
│   │
│   └── prisma/
│       └── schema.prisma            # Database schema
│
├── test/                            # Tests
│   ├── identity/                    # Unit tests
│   └── integration/                 # E2E tests
│
├── docker-compose.yml
├── Dockerfile
└── package.json
```

## Installation
```bash
# Install dependencies
npm install

# Setup environment variables
cp .env.example .env

# Start infrastructure (PostgreSQL, Redis)
docker-compose up -d postgres redis

# Run database migrations
npx prisma migrate dev

# Generate Prisma Client
npx prisma generate
```

## Configuration

Create a `.env` file based on `.env.example`:
```env
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/church_app"

# JWT
JWT_SECRET="your-secret-key"
JWT_EXPIRATION="15m"
JWT_REFRESH_EXPIRATION="7d"

# Redis (optional)
REDIS_URL="redis://localhost:6379"
REDIS_TTL=3600

# Application
NODE_ENV="development"
PORT=3000
API_PREFIX="api"

# TOTP
TOTP_ISSUER="ChurchApp"
TOTP_WINDOW=1

# Logging
LOG_LEVEL="info"
```

## Running the Application

### Development
```bash
npm run start:dev
```

### Production
```bash
npm run build
npm run start:prod
```

### Docker
```bash
# Build and run everything
docker-compose up -d

# View logs
docker-compose logs -f app

# Stop all services
docker-compose down
```

## Database

### Migrations
```bash
# Create a new migration
npx prisma migrate dev --name migration_name

# Apply migrations in production
npx prisma migrate deploy

# Reset database (DESTRUCTIVE)
npx prisma migrate reset
```

### Prisma Studio
```bash
npx prisma studio
```

## Testing
```bash
# Unit tests
npm run test

# Watch mode
npm run test:watch

# E2E tests
npm run test:e2e

# Test coverage
npm run test:cov
```

## API Documentation

Once running, access the API documentation at:
- Swagger UI: `http://localhost:3000/api/docs`

## Key Features

### Identity Module

#### Authentication
- User registration with email verification
- Login with JWT tokens
- Refresh token rotation
- Two-factor authentication (TOTP)
- Password hashing with argon2

#### Authorization
- JWT-based authentication
- Role-based access control
- Protected routes with guards

### Event System
- Outbox pattern for reliable event publishing
- PostgreSQL NOTIFY for event subscriptions
- Domain events for business logic decoupling

### Shared Services
- Feature flags for gradual rollouts
- Encryption service for sensitive data
- Structured logging with pino
- Centralized configuration management

## Development Guidelines

### Domain Layer Rules
- No NestJS imports in domain layer
- Pure TypeScript classes and interfaces
- Business logic only
- Repository interfaces defined here

### Application Layer
- Command/Query handlers
- Use case orchestration
- Service layer for complex operations
- DTOs for data transfer

### Infrastructure Layer
- Prisma repository implementations
- External service integrations
- Framework-specific code

### Presentation Layer
- HTTP controllers only
- Input validation with class-validator
- Response transformation
- Error handling

## Security

- Passwords hashed with argon2
- JWT tokens with short expiration
- Refresh token rotation
- Two-factor authentication (TOTP)
- Environment variable validation
- SQL injection prevention via Prisma

## Performance

- Database connection pooling
- Optional Redis caching
- Efficient query design with Prisma
- Outbox pattern for async processing

## Monitoring & Logging

- Structured logging with pino
- Request/response logging
- Error tracking
- Performance metrics

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Support

For issues and questions, please open an issue in the GitHub repository.