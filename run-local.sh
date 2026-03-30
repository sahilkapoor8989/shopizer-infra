#!/bin/bash
set -e

GHCR_USER="sahilkapoor8989"

# Start Colima if not running
if ! colima status &>/dev/null; then
  echo "Starting Colima..."
  colima start
fi

# Login to GHCR
echo "Logging in to GHCR..."
echo "Enter your GitHub Personal Access Token (with read:packages scope):"
read -s GHCR_TOKEN
echo "${GHCR_TOKEN}" | docker login ghcr.io -u "${GHCR_USER}" --password-stdin

# Pull latest images
echo "Pulling images from GHCR..."
docker pull ghcr.io/${GHCR_USER}/shopizer:latest
docker pull ghcr.io/${GHCR_USER}/shopizer-admin:latest
docker pull ghcr.io/${GHCR_USER}/shopizer-shop-reactjs:latest

# Start all services
echo "Starting all services..."
docker compose up -d

echo ""
echo "Services running:"
echo "  Shopizer API  -> http://localhost:30080"
echo "  Admin UI      -> http://localhost:30200"
echo "  Shop UI       -> http://localhost:30300"
