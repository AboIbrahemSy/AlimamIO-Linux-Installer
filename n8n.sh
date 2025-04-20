#!/bin/bash

set -e

# Colors
GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN}🔧 Starting n8n Installation...${RESET}"

# Create project directory
mkdir -p n8n-docker && cd n8n-docker

# Prompt for domain name
read -p "🌐 Enter domain name (or leave blank for localhost): " DOMAIN
DOMAIN=${DOMAIN:-localhost}

# Prompt for timezone
read -p "🕒 Enter your timezone (default: Asia/Riyadh): " TIMEZONE
TIMEZONE=${TIMEZONE:-Asia/Riyadh}

# Prompt for authentication
read -p "👤 Enter username for n8n (leave blank to skip auth): " N8N_USER
read -s -p "🔒 Enter password for n8n (leave blank to skip): " N8N_PASSWORD
echo ""

# Confirm values
echo -e "${CYAN}\n🔍 Configuration Summary:${RESET}"
echo -e "${CYAN}Domain:${RESET} ${DOMAIN}"
echo -e "${CYAN}Timezone:${RESET} ${TIMEZONE}"
if [[ -n "$N8N_USER" ]]; then
  echo -e "${CYAN}Basic Auth:${RESET} Enabled (user: $N8N_USER)"
else
  echo -e "${CYAN}Basic Auth:${RESET} Disabled"
fi

# Create docker-compose.yml
echo -e "${CYAN}⚙️  Creating Docker Compose file...${RESET}"

cat > docker-compose.yml <<EOF
version: "3.8"

services:
  n8n:
    image: n8nio/n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - TZ=${TIMEZONE}
      - GENERIC_TIMEZONE=${TIMEZONE}
      - WEBHOOK_TUNNEL_URL=https://${DOMAIN}
EOF

if [[ -n "$N8N_USER" && -n "$N8N_PASSWORD" ]]; then
cat >> docker-compose.yml <<EOF
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=${N8N_USER}
      - N8N_BASIC_AUTH_PASSWORD=${N8N_PASSWORD}
EOF
fi

cat >> docker-compose.yml <<EOF
    volumes:
      - ./n8n_data:/home/node/.n8n
EOF

# Pull and start container
echo -e "${CYAN}📦 Pulling Docker image and starting n8n...${RESET}"
docker compose pull
docker compose up -d

# Output results
echo -e "\n${GREEN}✅ n8n is now running!${RESET}"
echo -e "${GREEN}🌐 Access it at: http://${DOMAIN}:5678${RESET}"
if [[ -n "$N8N_USER" ]]; then
  echo -e "${GREEN}🔐 Login with: ${N8N_USER}${RESET}"
fi

exit 0
