# Shopizer Deployment

## Architecture

```
                        ┌─────────────────────────────────────────────┐
                        │               Local Machine (Colima)         │
                        │                                              │
  Browser               │  ┌─────────────────┐  ┌─────────────────┐  │
    │                   │  │  shopizer-shop   │  │  shopizer-admin  │  │
    ├── :30300 ─────────┼─▶│  React (nginx)  │  │  Angular (nginx) │  │
    │                   │  └────────┬────────┘  └────────┬────────┘  │
    └── :30200 ─────────┼───────────┘                    │           │
                        │           └────────────────────┘           │
                        │                      │ :30080               │
                        │             ┌────────▼────────┐            │
                        │             │  shopizer-app   │            │
                        │             │  Spring Boot    │            │
                        │             └────────┬────────┘            │
                        │                      │ :3306                │
                        │             ┌────────▼────────┐            │
                        │             │  shopizer-mysql  │            │
                        │             │  MySQL 8.0       │            │
                        │             └─────────────────┘            │
                        └─────────────────────────────────────────────┘
```

## Services

| Service | Image | Port |
|---|---|---|
| shopizer-app | `ghcr.io/sahilkapoor8989/shopizer:latest` | http://localhost:30080 |
| shopizer-admin | `ghcr.io/sahilkapoor8989/shopizer-admin:latest` | http://localhost:30200 |
| shopizer-shop | `ghcr.io/sahilkapoor8989/shopizer-shop-reactjs:latest` | http://localhost:30300 |
| shopizer-mysql | `mysql:8.0` | localhost:3306 |

## CI/CD Strategy

### CI (GitHub Actions)
Each app has its own pipeline triggered on push to `main`:

1. **shopizer** (Java/Spring Boot)
   - Runs unit + integration tests against a MySQL service container
   - Builds JAR via Maven
   - Builds & pushes Docker image to `ghcr.io/sahilkapoor8989/shopizer:latest`

2. **shopizer-admin** (Angular)
   - Installs dependencies, builds with Node 14
   - Builds & pushes Docker image to `ghcr.io/sahilkapoor8989/shopizer-admin:latest`

3. **shopizer-shop-reactjs** (React)
   - Builds & pushes Docker image to `ghcr.io/sahilkapoor8989/shopizer-shop-reactjs:latest`

### CD (shopizer-infra)
- Triggered by upstream app repos via `workflow_dispatch` after a successful CI build
- Pulls latest images and redeploys

## Running Locally

```bash
./run-local.sh
```

Requires:
- [Colima](https://github.com/abiosoft/colima) installed
- GitHub PAT with `read:packages` scope
