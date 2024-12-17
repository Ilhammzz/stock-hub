<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h3 align="center">Stock Hub</h3>

  <p align="center">
    A stock management application deployed using GitHub Actions and Contabo VPS.
    <br />
    <a href="https://github.com/irsyadkimi/stock-hub"><strong>Explore the repo »</strong></a>
    <br />
    <br />
    <a href="https://github.com/irsyadkimi/stock-hub/issues/new?labels=bug&template=bug-report.md">Report Bug</a>
    ·
    <a href="https://github.com/irsyadkimi/stock-hub/issues/new?labels=enhancement&template=feature-request.md">Request Feature</a>
  </p>
</div>

<!-- Menu -->
<details>
  <summary>Menu</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#built-with">Built With</a></li>
    <li><a href="#setup-and-installation">Setup and Installation</a></li>
    <li><a href="#ci-cd-pipeline-with-github-actions">CI/CD Pipeline with GitHub Actions</a></li>
    <li><a href="#deployment-on-contabo-vps">Deployment on Contabo VPS</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project
Stock Hub is a stock management system designed for small to medium businesses. The application leverages modern tools like **GitHub Actions** for CI/CD automation and is deployed on a **Contabo VPS** to ensure reliability and scalability.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With
- ![Laravel](https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white)
- ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
- ![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
- ![Contabo](https://img.shields.io/badge/Contabo-0A192F?style=for-the-badge)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Setup and Installation
To set up the project locally, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/irsyadkimi/stock-hub.git
   cd stock-hub
   ```

2. **Copy environment variables:**
   ```bash
   cp .env.example .env
   ```

3. **Build Docker containers:**
   ```bash
   docker-compose up -d --build
   ```

4. **Install dependencies:**
   ```bash
   docker exec -it stockhub_app composer install
   ```

5. **Generate app key and run migrations:**
   ```bash
   docker exec -it stockhub_app php artisan key:generate
   docker exec -it stockhub_app php artisan migrate
   ```

6. **Access the application:**
   - Web: `http://localhost`
   - phpMyAdmin: `http://localhost:8080`

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## CI/CD Pipeline with GitHub Actions
The CI/CD workflow automates testing, building, and deployment to Contabo VPS.

1. **Workflow File**:
   - Located in `.github/workflows/main.yml`.

2. **Pipeline Stages:**
   - **Code Linting and Testing:** Ensures the application passes quality standards.
   - **Build:** Docker images are built and pushed to a registry (e.g., Docker Hub).
   - **Deployment:** Automatically deploys to Contabo VPS via SSH.

3. **Secrets Configuration:**
   Add the following secrets to your GitHub repository:
   - `SSH_USER` - VPS SSH username
   - `SSH_HOST` - Contabo server IP
   - `SSH_KEY` - Private SSH key for authentication
   - `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` - For pushing Docker images.

Example Deployment Step:
```yaml
- name: Deploy to Contabo VPS
  uses: appleboy/scp-action@v0.1.4
  with:
    host: ${{ secrets.SSH_HOST }}
    username: ${{ secrets.SSH_USER }}
    key: ${{ secrets.SSH_KEY }}
    source: "docker-compose.yml"
    target: "/var/www/stockhub"
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Deployment on Contabo VPS
1. **Initial Setup on VPS:**
   - Install Docker and Docker Compose:
     ```bash
     sudo apt update && sudo apt install -y docker.io docker-compose
     ```

2. **Pull the latest changes from GitHub:**
   ```bash
   cd /var/www/stockhub
   git pull origin main
   ```

3. **Deploy the application:**
   ```bash
   docker-compose up -d --build
   ```

4. **Check logs:**
   ```bash
   docker-compose logs -f
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usage
- **Application URL**: Visit the application via your server's IP or domain.
- **Admin Dashboard**: (Setup guide coming soon)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contributing
Contributions are welcome! Follow these steps:
1. Fork the project.
2. Create your feature branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m 'Add YourFeature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a Pull Request.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License
Distributed under the MIT License.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contact
- **Author**: Irsyad Kimi
- **Email**: irsyad@example.com
- **Project Link**: [Stock Hub](https://github.com/irsyadkimi/stock-hub)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
