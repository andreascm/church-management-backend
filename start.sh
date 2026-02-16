#!/bin/bash

set -e

echo "🚀 Starting Church App Backend..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if .env exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}⚠️  .env file not found. Copying from .env.example...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✅ .env file created. Please update it with your configuration.${NC}"
    echo ""
fi

# Start infrastructure
echo "📦 Starting PostgreSQL..."
docker compose -f docker-compose.yml up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be ready..."
sleep 5

# Check if services are running
if docker compose -f docker-compose.yml ps | grep -q "Up"; then
    echo -e "${GREEN}✅ Services are running!${NC}"
    echo ""
else
    echo -e "${YELLOW}⚠️  Services might not be fully ready yet...${NC}"
    echo ""
fi

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "📥 Installing dependencies..."
    npm install
    echo ""
fi

# Generate Prisma Client
# echo "🔧 Generating Prisma Client..."
# npx prisma generate

# Run migrations
# echo "🗃️  Running database migrations..."
# npx prisma migrate dev

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo "📝 Next steps:"
echo "   1. Start the development server:"
echo "      npm run start:dev"
echo ""
echo "   2. Access the application:"
echo "      http://localhost:3000/api"
echo ""
# echo "   3. View database with Prisma Studio:"
# echo "      npx prisma studio"
echo ""e
echo "   4. Stop infrastructure:"
echo "      docker compose -f docker-compose.yml down"
echo ""