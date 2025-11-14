# withoutbg Web Application

Modern web interface for background removal with local AI processing.

**[📚 View Complete Documentation →](https://withoutbg.com/documentation/integrations/dockerized-web-app?utm_source=github&utm_medium=withoutbg-readme&utm_campaign=web-app-readme)**

## Architecture

- **Backend**: FastAPI + Uvicorn (Python 3.12)
- **Frontend**: React 18 + Vite + Tailwind CSS
- **Deployment**: Single Docker image (uvicorn serves both API and static files)
- **Models**: Focus v1.0.0 (local processing)
- **Multi-Platform**: Supports linux/amd64 (Intel/AMD) and linux/arm64 (Apple Silicon, ARM)

**Model Results:**
- **[See Focus Open Source Results →](https://withoutbg.com/resources/background-removal-results/model-focus-open-source?utm_source=github&utm_medium=withoutbg-readme&utm_campaign=web-app-readme)**
- **[See Pro API Results →](https://withoutbg.com/resources/background-removal-results/model-pro-api?utm_source=github&utm_medium=withoutbg-readme&utm_campaign=web-app-readme)**
- **[Compare Focus vs Pro →](https://withoutbg.com/resources/compare/focus-vs-pro?utm_source=github&utm_medium=withoutbg-readme&utm_campaign=web-app-readme)**

## Quick Start

**[📖 Detailed Setup Guide →](https://withoutbg.com/documentation/integrations/dockerized-web-app?utm_source=github&utm_medium=withoutbg-readme&utm_campaign=web-app-readme)**

### Development Mode (Docker Compose)

From the **repository root**:

```bash
# Start development servers with hot-reload
docker compose -f apps/web/docker-compose.yml up

# Access the application
# Frontend: http://localhost:3000
# Backend API: http://localhost:8000
# API Docs: http://localhost:8000/docs
```

### Production Mode (Single Docker Image)

From the **repository root**:

```bash
# Build production image
docker build -f apps/web/Dockerfile -t withoutbg:latest .

# Run production container
docker run -p 80:80 withoutbg:latest

# Access the application
open http://localhost
```

Or use Make commands from `apps/web/`:

```bash
cd apps/web

# Build, run, and manage production image
make docker-prod-build    # Build production image
make docker-prod-run      # Run on port 80
make docker-prod-logs     # View logs
make docker-prod-stop     # Stop container
make docker-prod-push DOCKER_HUB_USERNAME=your-username  # Push to Docker Hub
```

## Development

### Backend

```bash
cd apps/web/backend

# Install dependencies (using uv - recommended)
uv sync

# Run development server
uvicorn app.main:app --reload
```

> **Don't have `uv` yet?** Download it at [astral.sh/uv](https://astral.sh/uv) - it's a fast, modern Python package installer.

### Frontend

```bash
cd apps/web/frontend

# Install dependencies
npm install

# Run development server
npm run dev
```

## Production Deployment

The application uses a **multi-stage Docker build** that creates a single production-ready image:

**Stage 1**: Build React frontend with Vite  
**Stage 2**: Build Python backend with uv  
**Stage 3**: Combine everything - uvicorn serves both the API and static files

```bash
# From repository root - build single production image
docker build -f apps/web/Dockerfile -t withoutbg:latest .

# Run on port 80
docker run -p 80:80 withoutbg:latest

# Application available at: http://localhost
# API documentation at: http://localhost/docs
# Health check at: http://localhost/api/health
```

### Push to Docker Hub

```bash
# Tag and push
docker tag withoutbg:latest your-username/withoutbg:latest
docker push your-username/withoutbg:latest
```

## API Documentation

### Development Mode (docker-compose)
- Frontend: http://localhost:3000
- Backend API docs: http://localhost:8000/docs
- Health check: http://localhost:8000/api/health

### Production Mode (single image)
- Application: http://localhost
- API docs: http://localhost/docs
- Health check: http://localhost/api/health

## Structure

```
apps/web/
├── backend/               # FastAPI application
│   ├── app/
│   │   └── main.py       # Main API + static file serving
│   ├── Dockerfile        # Separate backend image (dev)
│   └── pyproject.toml
├── frontend/              # React application
│   ├── src/
│   ├── Dockerfile        # Separate frontend image (dev)
│   └── package.json
├── Dockerfile             # Multi-stage production image
├── docker-compose.yml     # Development setup
└── Makefile              # Build and deployment commands
```

### Production Architecture

The production `Dockerfile` uses a multi-stage build:

1. **frontend-builder**: Builds React app with Vite
2. **backend-builder**: Builds Python dependencies with uv
3. **Production runtime**: Python 3.12 slim with uvicorn serving both static files and API

No nginx or supervisord needed - uvicorn handles everything!

## Troubleshooting

### "exec format error" when running Docker image?

This error means the Docker image architecture doesn't match your CPU. The published `withoutbg/app` images support multiple platforms, but you may need to explicitly specify:

```bash
# For Intel/AMD systems (most common)
docker pull --platform linux/amd64 withoutbg/app:latest
docker run --platform linux/amd64 -p 80:80 withoutbg/app:latest

# For ARM systems (Apple Silicon, AWS Graviton)
docker pull --platform linux/arm64 withoutbg/app:latest
docker run --platform linux/arm64 -p 80:80 withoutbg/app:latest
```

**For developers**: When publishing images, use the multi-platform build:

```bash
cd apps/web
make docker-release VERSION=1.0.1
```

See [EXEC_FORMAT_ERROR_FIX.md](./EXEC_FORMAT_ERROR_FIX.md) for detailed troubleshooting steps.

## Additional Resources

- **[Dockerized Web App Documentation](https://withoutbg.com/documentation/integrations/dockerized-web-app?utm_source=github&utm_medium=withoutbg-readme&utm_campaign=web-app-readme)** - Complete deployment guide
- **[Python SDK Documentation](https://withoutbg.com/documentation/integrations/python-sdk?utm_source=github&utm_medium=withoutbg-readme&utm_campaign=web-app-readme)** - Backend API reference
- **[Focus Model Results](https://withoutbg.com/resources/background-removal-results/model-focus-open-source?utm_source=github&utm_medium=withoutbg-readme&utm_campaign=web-app-readme)** - Example outputs
- **[Pro API Results](https://withoutbg.com/resources/background-removal-results/model-pro-api?utm_source=github&utm_medium=withoutbg-readme&utm_campaign=web-app-readme)** - Example outputs
- **[Multi-Platform Docker Guide](./MULTI_PLATFORM_DOCKER.md)** - Technical details on cross-platform builds






