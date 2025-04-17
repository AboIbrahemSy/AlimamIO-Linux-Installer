#!/bin/bash

set -e

GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN}🔧 Starting n8n Installation...${RESET}"

# Create project folder
mkdir -p n8n-docker && cd n8n-docker

# Prompt for basic config
read -p "Enter domain name (or leave blank to use localhost): " DOMAIN
DOMAIN=${DOMAIN:-localhost}

read -p "Enter a username for n8n (or leave blank to skip basic auth): " N8N_USER
read -s -p "Enter a password for n8n (leave blank to skip): " N8N_PASSWORD
echo ""

# Generate Docker Compose file
cat > docker-compose.yml <<EOF
version: "3.1"

services:
  n8n:
    image: n8nio/n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - TZ=Europe/Berlin
      - GENERIC_TIMEZONE=Europe/Berlin
      - WEBHOOK_TUNNEL_URL=https://${DOMAIN}
EOF

if [[ -n "$N8N_USER" && -n "$N8N_PASSWORD" ]]; then
cat >> docker-compose.yml <<EOF
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=${N8N_USER}
      - N8N_BASIC_AUTH_PASSWORD=${N8N_PASSWORD}
EOF
fi

echo -e "${CYAN}📦 Pulling n8n Docker image and starting...${RESET}"
docker-compose pull
docker-compose up -d

echo -e "${GREEN}✅ n8n is now running!${RESET}"
echo -e "${GREEN}🌐 Access it at: http://${DOMAIN}:5678${RESET}"
if [[ -n "$N8N_USER" ]]; then
  echo -e "${GREEN}🔐 Login with username: $N8N_USER${RESET}"
fi

exit 0
