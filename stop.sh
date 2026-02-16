#!/bin/bash

echo "🛑 Stopping Church App Backend services..."
docker compose -f docker-compose.yml down

echo "✅ Services stopped!"