# AlimamIO Installer

The **AlimamIO Installer** is a shell script designed to automate the installation and configuration of essential services such as **Docker**, **Docker Compose**, **Mailcow**, and **n8n**. This installer provides an easy-to-use interface that guides users through the process, allowing them to select which services they want to install and configure on their system.

Whether you are setting up **Docker** for the first time, deploying **Mailcow** for email hosting, or automating workflows with **n8n**, this script streamlines the process and handles the configurations for you.

## Features

- **Install Docker & Docker Compose**: Automatically install Docker and Docker Compose if not already installed.
- **Mailcow Full Setup**: Clone and set up **Mailcow**, a powerful mail server solution with Docker Compose configuration.
- **n8n Setup**: Install **n8n**, an open-source workflow automation tool that integrates with hundreds of apps.
- **Customizable Installations**: Choose between installing Docker alone or Docker along with specific containers such as Mailcow and n8n.
- **Firewall Configuration**: Automatically configure necessary firewall rules to allow the required ports.

## Requirements

To run the **AlimamIO Installer**, ensure that your system meets the following requirements:

- **Ubuntu** or **Debian** based system.
- **Git** installed on your system for cloning repositories.
- **sudo** privileges for installation.
- An internet connection to download necessary packages and Docker images.

## Installation

### 1. Clone the repository:

Start by cloning the repository to your system:

```bash
git clone https://github.com/AboIbrahemSy/AlimamIO-Linux-Installer.git
cd AlimamIO-Linux-Installer
