# shopizer-infra

Infrastructure and local development setup for the Shopizer e-commerce platform.

## Repos

| Repo | Description |
|---|---|
| [shopizer](https://github.com/sahilkapoor8989/shopizer) | Java/Spring Boot backend API |
| [shopizer-admin](https://github.com/sahilkapoor8989/shopizer-admin) | Angular admin panel |
| [shopizer-shop-reactjs](https://github.com/sahilkapoor8989/shopizer-shop-reactjs) | React storefront |

## Prerequisites

- [Colima](https://github.com/abiosoft/colima) installed
- GitHub PAT with `read:packages` scope

## Run Locally

```bash
./run-local.sh
```

This will:
1. Start Colima if not running
2. Remove any existing containers
3. Login to GHCR and pull latest images
4. Start all services via Docker Compose

## Services

| Service | URL |
|---|---|
| Shopizer API | http://localhost:30080 |
| Swagger UI | http://localhost:30080/swagger-ui.html |
| Admin Panel | http://localhost:30200 |
| Shop UI | http://localhost:30300 |

## Stop All Services

```bash
docker compose down
```
