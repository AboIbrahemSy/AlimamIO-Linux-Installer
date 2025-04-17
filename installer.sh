#!/bin/bash

set -e

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

clear

# ASCII Art Header
echo -e "${CYAN}"
echo "    █████╗ ██╗     ██╗███╗   ███╗ █████╗ ███╗   ███╗ ██╗ ██████╗  ██████╗ "
echo "   ██╔══██╗██║     ██║████╗ ████║██╔══██╗████╗ ████║██╔╝██╔═══██╗██╔════╝ "
echo "   ███████║██║     ██║██╔████╔██║███████║██╔████╔██║██║ ██║   ██║██║  ███╗"
echo "   ██╔══██║██║     ██║██║╚██╔╝██║██╔══██║██║╚██╔╝██║██║ ██║   ██║██║   ██║"
echo "   ██║  ██║███████╗██║██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║╚██╗╚██████╔╝╚██████╔╝"
echo "   ╚═╝  ╚═╝╚══════╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═╝ ╚═════╝  ╚═════╝ "
echo -e "${RESET}"

echo -e "${CYAN}============================================="
echo "                 🧠 AlimamIO"
echo "          Developed by AboIbrahemSy"
echo "               TG: @AboIbrahemSy"
echo -e "=============================================${RESET}"

echo -e "${YELLOW}Please select one of the following options:${RESET}"
echo "1) 🐳 Install Docker and Docker Compose only"
echo "2) 📦 Install Docker + Containers (with project selection)"
echo "3) 📧 Install Mailcow (Full Setup)"
echo "4) 🧑‍💻 Install n8n Workflow Automation"
echo "0) ❌ Exit"
echo

read -p "Please enter the option number: " user_choice

if [[ "$user_choice" == "1" ]]; then
  echo -e "${GREEN}🚀 Running docker-script.sh...${RESET}"
  chmod +x docker-script.sh
  sudo ./docker-script.sh
  exit 0

elif [[ "$user_choice" == "2" ]]; then
  echo -e "${GREEN}🚀 Running full container installation...${RESET}"
  chmod +x container-setup.sh
  sudo ./container-setup.sh
  exit 0

elif [[ "$user_choice" == "3" ]]; then
  echo -e "${GREEN}🚀 Running Mailcow full setup...${RESET}"
  chmod +x mailcow.sh
  sudo ./mailcow.sh
  exit 0

elif [[ "$user_choice" == "4" ]]; then
  echo -e "${GREEN}🚀 Running n8n setup...${RESET}"
  chmod +x n8n.sh
  sudo ./n8n.sh
  exit 0

elif [[ "$user_choice" == "0" ]]; then
  echo -e "${RED}Exited.${RESET}"
  exit 0

else
  echo -e "${RED}Invalid choice. Please try again.${RESET}"
  exit 1
fi
