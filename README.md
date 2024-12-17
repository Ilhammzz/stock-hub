
# Stock Hub

[![License](https://img.shields.io/github/license/irsyadkimi/stock-hub)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Compatible-blue)](https://www.docker.com/)

**Stock Hub** is a simple stock management application built with Laravel, designed for efficient product management and stock reporting. It utilizes modern DevOps tools like **GitHub Actions** for CI/CD pipeline automation and **Docker** for containerization. The application is deployed on a VPS running Ubuntu with NGINX.

---

## Features

- **Stock Management**: Simple CRUD operations for managing product stock.
- **CI/CD Pipeline**: Automated deployments using **GitHub Actions**.
- **Containerization**: Application packaged and deployed with **Docker Compose**.
- **Database Management**: Database migration using Laravel’s migration system.
- **VPS Deployment**: Hosted on an Ubuntu VPS with NGINX as the web server.
- **Monitoring**: Integrated with Grafana for server monitoring.
- **Backup & Recovery**: Built-in backup system to secure application data.

---

## Project Structure

```
stock-hub/
├── .github/workflows/          # CI/CD pipeline configuration
├── app/                        # Laravel application files
├── config/                     # Laravel configuration files
├── database/                   # Migrations and seeders
├── public/                     # Public assets
├── routes/                     # Application routes
├── tests/                      # Testing (Unit and Browser tests)
├── docker-compose.yml          # Docker Compose configuration
├── nginx.conf                  # NGINX configuration
├── Dockerfile                  # Docker image setup
└── README.md                   # Project documentation
```

---

## Prerequisites

Before setting up the project, ensure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/)
- A VPS with **Ubuntu Server** and SSH access.

---

## Installation and Setup

Follow these steps to set up **Stock Hub** on your machine or server:

### 1. Clone the Repository

```bash
git clone https://github.com/irsyadkimi/stock-hub.git
cd stock-hub
```

### 2. Copy the Environment File

```bash
cp .env.example .env
```

Edit the `.env` file to set up your database, application key, and server settings.

### 3. Build and Run the Application (Docker)

Run the following command to build and start the Docker containers:

```bash
docker-compose up -d
```

---

## CI/CD Pipeline

The project uses **GitHub Actions** for its CI/CD pipeline. Every push to the `master` branch triggers the pipeline to:

1. Checkout the code.
2. Deploy the application to the VPS using **rsync**.
3. Install dependencies and run database migrations.
4. Reload the NGINX web server.

### GitHub Actions Workflow (`.github/workflows/pipeline.yml`)

```yaml
name: CI/CD Pipeline

on:
  push:
    branches:
      - master

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Extract SSH Key
        run: |
          mkdir -p ~/.ssh
          tar -xvf key.tar.gz -C ~/.ssh
          chmod 600 ~/.ssh/id_rsa
          echo -e "Host *
   StrictHostKeyChecking no
" > ~/.ssh/config

      - name: Install Dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y rsync

      - name: Deploy to VPS
        env:
          DEPLOY_PATH: /pso/stock-hub
        run: |
          rsync -avz --exclude '.git' --exclude 'key.tar.gz' ./ root@217.15.160.69:${{ env.DEPLOY_PATH }}
          ssh root@217.15.160.69 "cd ${{ env.DEPLOY_PATH }} && composer install && php artisan migrate --force"

      - name: Reload Web Server
        run: |
          ssh root@217.15.160.69 "systemctl reload nginx"
```

---

## Monitoring

Grafana is configured for server monitoring and can be accessed at:  
**[http://217.15.160.69:3000/](http://217.15.160.69:3000/)**  
**Password**: `RELOW123`

---

## Deployment

The application is deployed on a VPS with the following credentials:

- **SSH Access**:  
  - Username: `root`  
  - Password: `RELOW123`  
  - IP Address: `217.15.160.69`

- **Web Application**:  
  Accessible at `http://217.15.160.69`.

---

## Testing

The project includes unit tests and browser tests configured with **PHPUnit** and **Laravel Dusk**. To run the tests:

```bash
docker-compose exec app php artisan test
```

---

## Services

| Service      | Description             | URL                   |
|--------------|-------------------------|-----------------------|
| Laravel App  | Main application        | [http://localhost](http://localhost) |
| phpMyAdmin   | Database management UI  | [http://localhost:8080](http://localhost:8080) |

---

## Contributors

- **Talitha Firyal Ghina Nuha** - 5026221031
- **Isaura Qinthara Heriswan** - 5026221146
- **Fausta Irsyad Ramadhan** - 5026211150
- **Ilham Abdul Aziz** - 5026211105

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments
We would like to extend our heartfelt gratitude to all contributors, teaching assistants, and the lecturer of the System Development and Operations course in the Information Systems department. Your guidance and support have been invaluable throughout this project. We sincerely hope for your kind consideration and generosity in assessing our work, as we strive to achieve a grade above average.
