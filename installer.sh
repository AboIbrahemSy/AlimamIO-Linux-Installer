#!/bin/bash

set -e

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

function main_menu {
  clear
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
  show_options
}

function main_menu_no_logo {
  echo -e "${YELLOW}Please select one of the following options:${RESET}"
  show_options
}

function show_options {
  echo "1) 🐳 Install Docker and Docker Compose only"
  echo "2) 📦 Install Docker + Containers (with project selection)"
  echo "3) 📧 Install Mailcow (Full Setup)"
  echo "4) 🧑‍💻 Install n8n Workflow Automation"
  echo "0) ❌ Exit"
  echo

  read -p "Please enter the option number: " user_choice
  handle_choice "$user_choice"
}

function check_docker {
  if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed. Please install Docker first.${RESET}"
    sleep 2
    main_menu_no_logo
    exit 1
  fi

  if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not installed. Please install Docker Compose first.${RESET}"
    sleep 2
    main_menu_no_logo
    exit 1
  fi
}

function handle_choice {
  case "$1" in
    1)
      echo -e "${GREEN}🚀 Running docker-script.sh...${RESET}"
      chmod +x docker-script.sh
      sudo ./docker-script.sh
      ;;

    2)
      check_docker
      echo -e "${GREEN}🚀 Running full container installation...${RESET}"
      chmod +x container-setup.sh
      sudo ./container-setup.sh
      ;;

    3)
      check_docker
      echo -e "${GREEN}🚀 Running Mailcow full setup...${RESET}"
      chmod +x mailcow.sh
      sudo ./mailcow.sh
      ;;

    4)
      check_docker
      echo -e "${GREEN}🚀 Running n8n setup...${RESET}"
      chmod +x n8n.sh
      sudo ./n8n.sh
      ;;

    0)
      echo -e "${RED}Exited.${RESET}"
      exit 0
      ;;

    *)
      echo -e "${RED}Invalid choice. Please try again.${RESET}"
      sleep 1
      main_menu_no_logo
      ;;
  esac
}

main_menu
