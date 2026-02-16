#!/bin/bash

set -e

echo "🗑️  Resetting Church App Backend..."
echo "⚠️  This will delete all data. Press Ctrl+C to cancel."
sleep 3

# Stop all services
echo "Stopping services..."
docker compose -f docker-compose.yml down -v

# Remove node_modules and dist
echo "Removing build artifacts..."
rm -rf node_modules dist

# Remove Prisma artifacts
# echo "Removing Prisma artifacts..."
# rm -rf prisma/migrations node_modules/.prisma

echo "✅ Reset complete! Run ./start.sh to set up again."