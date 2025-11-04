# withoutbg Web Application

Modern web interface for background removal with local AI processing.

## Architecture

- **Backend**: FastAPI (Python 3.12)
- **Frontend**: React 18 + Vite + Tailwind CSS
- **Server**: Nginx reverse proxy
- **Models**: Focus v1.0.0 (local processing)

## Quick Start

From the **repository root**:

```bash
# Development mode (hot-reload)
docker-compose -f apps/web/docker-compose.yml up

# Access the application
open http://localhost:3000
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

Build and run with Docker:

```bash
# From repository root
docker build -f apps/web/backend/Dockerfile -t withoutbg-backend .
docker build -f apps/web/frontend/Dockerfile -t withoutbg-frontend .

# Run containers
docker run -p 8000:8000 withoutbg-backend
docker run -p 80:80 withoutbg-frontend
```

## API Documentation

When running, visit:
- Backend API docs: http://localhost:8000/docs
- Health check: http://localhost:8000/api/health

## Structure

```
apps/web/
├── backend/          # FastAPI application
│   ├── app/
│   │   └── main.py
│   ├── Dockerfile
│   └── pyproject.toml
├── frontend/         # React application
│   ├── src/
│   ├── Dockerfile
│   └── package.json
├── nginx/            # Nginx configuration
│   └── nginx.conf
└── docker-compose.yml
```






