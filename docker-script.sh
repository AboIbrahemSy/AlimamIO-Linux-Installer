#!/bin/bash

set -e

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

# Check root
if [[ $EUID -ne 0 ]]; then
  echo -e "${RED}Please run this script as root (use sudo).${RESET}"
  exit 1
fi

# Detect system info
if [ -f /etc/os-release ]; then
  . /etc/os-release
else
  echo -e "${RED}Cannot detect OS (missing /etc/os-release).${RESET}"
  exit 1
fi

# Set Docker repo settings
if [[ "$ID" == "ubuntu" ]]; then
  OS_REPO_URL="https://download.docker.com/linux/ubuntu"
  OS_KEY_URL="https://download.docker.com/linux/ubuntu/gpg"
  OS_CODENAME=$(lsb_release -cs)
  KEY_FILE="/etc/apt/keyrings/docker.gpg"
elif [[ "$ID" == "debian" || "$ID_LIKE" == *"debian"* ]]; then
  OS_REPO_URL="https://download.docker.com/linux/debian"
  OS_KEY_URL="https://download.docker.com/linux/debian/gpg"
  OS_CODENAME="$VERSION_CODENAME"
  KEY_FILE="/etc/apt/keyrings/docker.gpg"
else
  echo -e "${RED}Unsupported OS: $ID${RESET}"
  exit 1
fi

echo -e "${GREEN}✅ Detected OS: $ID ($OS_CODENAME)${RESET}"

# Install dependencies
echo -e "${GREEN}📦 Installing dependencies...${RESET}"
apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release git net-tools htop unzip

# Setup keyring
install -m 0755 -d /etc/apt/keyrings
curl -fsSL "$OS_KEY_URL" | gpg --dearmor -o "$KEY_FILE"
chmod a+r "$KEY_FILE"

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=$KEY_FILE] $OS_REPO_URL $OS_CODENAME stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Install Docker packages
echo -e "${GREEN}🐳 Installing Docker...${RESET}"
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Optional: Install Docker Compose manually
echo -e "${GREEN}⚙️ Installing Docker Compose...${RESET}"
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Fix symlink if needed
if [ ! -e /usr/bin/docker-compose ]; then
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

# GPU Support
if command -v nvidia-smi &> /dev/null; then
  echo -e "${GREEN}🚀 GPU detected - Installing NVIDIA Container Toolkit...${RESET}"
  curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
  curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
  apt-get update
  apt-get install -y nvidia-container-toolkit
else
  echo -e "${RED}⚠️ No GPU detected - Skipping NVIDIA Container Toolkit.${RESET}"
fi

# Restart Docker
echo -e "${GREEN}🔁 Restarting Docker service...${RESET}"
systemctl restart docker
# Ask for cleanup
read -p "Do you want to clean up the package cache? (y/n): " cleanup_choice
if [[ "$cleanup_choice" == "y" || "$cleanup_choice" == "Y" ]]; then
  echo -e "${GREEN}🧹 Cleaning up apt cache...${RESET}"
  apt-get clean
  rm -rf /var/lib/apt/lists/*
  echo -e "${GREEN}Cache cleaned.${RESET}"
else
  echo -e "${RED}Skipping cleanup.${RESET}"
fi

# Docker Hello-World test
echo -e "${GREEN}🚀 Testing Docker with hello-world...${RESET}"
docker run hello-world

echo -e "\n${GREEN}🎉 All tasks completed successfully!${RESET}"
