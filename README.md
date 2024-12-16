
# Stock Hub

[![License](https://img.shields.io/github/license/irsyadkimi/stock-hub)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Compatible-blue)](https://www.docker.com/)

Stock Hub is a Dockerized Laravel application designed to provide a seamless environment for managing stock data with a clean and scalable infrastructure. This repository contains the DevOps setup, including Docker and Docker Compose configurations.

## Features
- **Dockerized Laravel**: Efficient containerization using PHP 8.1 FPM and MySQL 5.7.
- **Database Management**: Integrated phpMyAdmin for managing MySQL databases.
- **Custom Networking**: Uses `stockhub-network` for isolated container communication.
- **Port Exposure**: Exposes Laravel app on port `80` and phpMyAdmin on port `8080`.
- **Volume Mounts**: Persistent data storage for MySQL and application files.
- **Optimized for Development**: Includes Composer dependency management and proper file permissions for Laravel storage and cache.

---

## Prerequisites
- [Docker](https://www.docker.com/) (version 20.10+)
- [Docker Compose](https://docs.docker.com/compose/) (version 2.0+)

---

## Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/irsyadkimi/stock-hub.git
   cd stock-hub
   ```

2. **Set Up Environment Variables**
   Copy the `.env.example` file to `.env` and configure it according to your requirements:
   ```bash
   cp .env.example .env
   ```

3. **Start Containers**
   Use Docker Compose to build and start the containers:
   ```bash
   docker-compose up -d --build
   ```

4. **Install Laravel Dependencies**
   Access the app container and install Composer dependencies:
   ```bash
   docker exec -it stockhub-app composer install
   ```

5. **Run Laravel Migrations**
   Set up the database structure:
   ```bash
   docker exec -it stockhub-app php artisan migrate
   ```

6. **Access the Application**
   - Laravel App: [http://localhost](http://localhost:8081)
   - phpMyAdmin: [http://localhost:8080](http://localhost:8080)

---

## Project Structure
- **`app/`**: Laravel application files.
- **`docker/`**: Docker configurations for the app and database.
- **`docker-compose.yml`**: Docker Compose file for orchestrating the containers.

---

## Services

| Service      | Description             | URL                   |
|--------------|-------------------------|-----------------------|
| Laravel App  | Main application        | [http://localhost](http://localhost) |
| phpMyAdmin   | Database management UI  | [http://localhost:8080](http://localhost:8080) |

---

## Development Commands

- **Rebuild Containers**
  ```bash
  docker-compose up -d --build
  ```

- **Stop Containers**
  ```bash
  docker-compose down
  ```

- **Access App Container**
  ```bash
  docker exec -it stockhub-app bash
  ```

- **Check Logs**
  ```bash
  docker-compose logs -f
  ```

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contributing
Contributions are welcome! Feel free to fork this repository, create a branch, and submit a pull request.

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/YourFeature`
3. Commit your changes: `git commit -m 'Add YourFeature'`
4. Push to the branch: `git push origin feature/YourFeature`
5. Open a pull request

---

## Acknowledgments
Special thanks to all contributors and the DevOps community for their support.
