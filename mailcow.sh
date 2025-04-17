#!/bin/bash

set -e

# Colors
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"


echo -e "${CYAN}🔧 Starting mailcow Installation...${RESET}"

# Clone Mailcow repository if not already cloned
if [ ! -d "mailcow-dockerized" ]; then
  echo -e "${GREEN}📥 Cloning Mailcow Dockerized...${RESET}"

  # Clone the Mailcow repository
  git clone https://github.com/mailcow/mailcow-dockerized.git
  cd mailcow-dockerized
else
  echo -e "${GREEN}✅ Mailcow repository already cloned.${RESET}"
  cd mailcow-dockerized
fi

# Copy the example configuration file
echo -e "${GREEN}🔧 Setting up configuration file...${RESET}"
cp mailcow.conf.example mailcow.conf

# Set your Mailcow domain and check if already set
MAILCOW_DOMAIN=${1:-""}

if [ -z "$MAILCOW_DOMAIN" ]; then
  read -p "Enter your Mailcow domain (e.g., mail.example.com): " MAILCOW_DOMAIN
fi

if [ -z "$MAILCOW_DOMAIN" ]; then
  echo -e "${RED}Error: Domain name is required.${RESET}"
  read -p "Enter your Mailcow domain (e.g., mail.example.com): " MAILCOW_DOMAIN
fi

if [ -z "$MAILCOW_DOMAIN" ]; then
  echo -e "${RED}Error: Domain name is required.${RESET}"
  exit 1
fi

# Update the MAILCOW_HOSTNAME in mailcow.conf
echo -e "${GREEN}🔧 Setting domain to $MAILCOW_DOMAIN...${RESET}"
sed -i "s/^MAILCOW_HOSTNAME=.*/MAILCOW_HOSTNAME=$MAILCOW_DOMAIN/" mailcow.conf

# Pull Docker images and start Mailcow services
echo -e "${GREEN}📡 Pulling Docker images and starting Mailcow...${RESET}"
docker-compose pull
docker-compose up -d

# Allow necessary ports in firewall
echo -e "${GREEN}🔓 Configuring firewall...${RESET}"
sudo ufw allow 80,443/tcp
sudo ufw enable

# Optional: Allow SMTP ports if needed (for email traffic)
sudo ufw allow 25,465,587/tcp

# Provide Mailcow status and URL
echo -e "${GREEN}🚀 Mailcow is now running at: https://$MAILCOW_DOMAIN${RESET}"

# Final completion message
echo -e "${GREEN}Mailcow installation and setup completed successfully!${RESET}"

# Return to the original directory
cd ..
