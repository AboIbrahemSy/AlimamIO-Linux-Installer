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
```

### 2. Make the script executable:

Give execute permissions to the installer script:

```bash
chmod +x installer.sh
```

### 3. Run the installer script:

Execute the installer script to start the installation:

```bash
./installer.sh
```

The script will prompt you with several options to choose from.

## Usage

Once the script is executed, you'll see a menu with the following options:

```
1) 🐳 Install Docker and Docker Compose only
2) 📦 Install Docker + Containers (with project selection)
3) 📧 Install Mailcow (Full Setup)
4) 🧑‍💻 Install n8n Workflow Automation
0) ❌ Exit
```

### Option 1: Install Docker and Docker Compose only

This option will install Docker and Docker Compose on your system if they are not already installed. This is ideal if you just need Docker setup.

### Option 2: Install Docker + Containers (with project selection)

This option installs Docker and allows you to choose from various container projects (such as **Mailcow** or **n8n**) to install and configure on your system. It will handle Docker Compose and project-specific setups.

### Option 3: Install Mailcow (Full Setup)

This option clones the **Mailcow** Dockerized repository and sets up **Mailcow** with all necessary configurations, including:

- Cloning the Mailcow repository.
- Copying the example configuration file.
- Allowing you to set the Mailcow domain (e.g., `mail.example.com`).
- Pulling Docker images for Mailcow and bringing the containers up.
- Configuring the firewall to allow HTTP (80) and HTTPS (443) traffic.

Once completed, you’ll have Mailcow up and running, accessible at your configured domain.

### Option 4: Install n8n Workflow Automation

This option installs **n8n** for workflow automation. **n8n** allows you to automate processes, integrate services, and create workflows without coding. It is set up as a Docker container, and once installed, you can access it at `http://localhost:5678`.

### Option 0: Exit

Exit the installer script without making any changes.

## Troubleshooting

- **Docker not found**: If Docker is not installed, select option 1 to install Docker and Docker Compose.
- **Permission issues**: Make sure to run the script with `sudo` to avoid any permission errors during installation.
- **Firewall issues**: If you face any connectivity issues (e.g., with Mailcow), make sure that the necessary firewall ports are open (80, 443).
- **n8n not accessible**: After installation, ensure that `http://localhost:5678` is accessible in your browser. If not, check the Docker logs for any issues.

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.

---

Feel free to open an issue or contact me if you have any questions or suggestions.

**Author**: AboIbrahemSy  
**Telegram**: [@AboIbrahemSy](https://t.me/AboIbrahemSy)
