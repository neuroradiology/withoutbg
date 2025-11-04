# Repository Structure

This document explains the organization of the withoutbg monorepo.

## Overview

The repository follows a **monorepo architecture** with clear separation between:

1. **Reusable packages** - Core libraries that can be published independently
2. **Applications** - End-user facing applications built on top of packages
3. **Integrations** - Third-party tool plugins and extensions
4. **Shared resources** - ML models, documentation, scripts

## Directory Layout

```
withoutbg/
├── packages/                  # Reusable, versioned packages
│   └── python/                # Core Python SDK
│       ├── src/withoutbg/     # Package source code
│       ├── tests/             # Unit and integration tests
│       ├── pyproject.toml     # Package configuration
│       └── README.md          # Package documentation
│
├── apps/                      # End-user applications
│   └── web/                   # Web application
│       ├── backend/           # FastAPI backend
│       │   ├── app/           # Application code
│       │   ├── Dockerfile     # Backend container
│       │   └── pyproject.toml # Backend dependencies
│       ├── frontend/          # React frontend
│       │   ├── src/           # React components
│       │   ├── Dockerfile     # Frontend container
│       │   └── package.json   # NPM dependencies
│       ├── nginx/             # Nginx configuration
│       ├── docker-compose.yml # Development orchestration
│       └── README.md          # Web app documentation
│
├── integrations/              # Third-party tool integrations
│   ├── .gitkeep               # Placeholder for future plugins
│   └── (future: gimp/, photoshop/, figma/, blender/)
│
├── models/                    # Shared ML model files
│   └── checkpoints/           # ONNX model files
│       ├── depth_anything_v2_vits_slim.onnx
│       ├── focus_matting_1.0.2.onnx
│       ├── focus_refiner_0.1.0.onnx
│       └── isnet.onnx
│
├── docs/                      # Documentation
│   └── .gitkeep              # Placeholder for docs
│
├── scripts/                   # Development and build scripts
│   └── .gitkeep              # Placeholder for scripts
│
├── .github/                   # CI/CD workflows
│   └── workflows/
│
├── README.md                  # Main repository README
├── STRUCTURE.md               # This file
├── LICENSE                    # Apache 2.0 License
├── CONTRIBUTING.md            # Contribution guidelines
└── CHANGELOG.md               # Version history
```

## Component Details

### 📦 packages/python/

The **core Python SDK** - independently versioned and published to PyPI.

**Key files:**
- `src/withoutbg/` - Package source code
- `pyproject.toml` - Dependencies and metadata
- `tests/` - Comprehensive test suite

**Installation:**
```bash
# From PyPI (end users) - using uv (recommended)
uv add withoutbg

# Or with pip
pip install withoutbg

# From source (development)
cd packages/python
uv sync --extra dev  # or: pip install -e ".[dev]"
```

> **Don't have `uv` yet?** Download it at [astral.sh/uv](https://astral.sh/uv) - it's a fast, modern Python package installer.

**Publishing:**
```bash
cd packages/python
hatch build
hatch publish
```

### 🌐 apps/web/

The **web application** - React frontend + FastAPI backend.

**Backend:**
- Depends on `packages/python/` for core functionality
- FastAPI for REST API
- Docker container for deployment

**Frontend:**
- React 18 + Vite
- Tailwind CSS for styling
- Nginx for production serving

**Development:**
```bash
# Run everything with Docker Compose
docker-compose -f apps/web/docker-compose.yml up

# Or run components separately
cd apps/web/backend && uvicorn app.main:app --reload
cd apps/web/frontend && npm run dev
```

### 🔌 integrations/

**Third-party tool plugins** - each integration is independent.

**Future structure:**
```
integrations/
├── gimp/                   # GIMP plugin
│   ├── withoutbg_plugin.py
│   ├── install.sh
│   └── README.md
├── photoshop/              # Photoshop extension
│   ├── manifest.json
│   └── src/
└── figma/                  # Figma plugin
    ├── manifest.json
    └── code.ts
```

Each integration:
- Has its own README
- Can be installed independently
- Depends on `packages/python/` or web API

### 🧠 models/

**Shared ML model files** - ONNX models used across components.

- Checkpoints are downloaded on first use
- Shared between CLI, web app, and integrations
- Large files tracked with Git LFS (optional)

## Dependency Flow

```
┌─────────────────┐
│ packages/python │  ← Core library (published to PyPI)
└────────┬────────┘
         │
         ├─────────────────┐
         │                 │
    ┌────▼─────┐    ┌─────▼────────┐
    │ apps/web │    │ integrations │
    └──────────┘    └──────────────┘
```

- **packages/python/** - No dependencies on other repo components
- **apps/web/backend/** - Depends on `packages/python/`
- **integrations/** - Depend on `packages/python/` or web API

## Versioning Strategy

Each component has **independent versioning**:

- **packages/python/**: Semantic versioning (v1.0.0)
  - Published to PyPI
  - Version in `src/withoutbg/__version__.py`
  
- **apps/web/**: Calendar versioning or semantic (v2025.1.0)
  - Docker images tagged with version
  - Version in `apps/web/backend/pyproject.toml`
  
- **integrations/**: Independent per plugin (v0.5.0)
  - Each plugin has its own version
  - Version in plugin manifest

## CI/CD Strategy

Separate workflows for each component:

```
.github/workflows/
├── python-package.yml     # Test & publish Python package
├── web-app.yml            # Test & build web app containers
└── integrations.yml       # Test integrations
```

## Development Workflow

### Adding a New Integration

1. Create directory in `integrations/`:
   ```bash
   mkdir -p integrations/gimp
   cd integrations/gimp
   ```

2. Add plugin files and README

3. Plugin depends on:
   - `packages/python/` (local processing)
   - OR web API (cloud processing)

### Updating the Python Package

1. Make changes in `packages/python/src/`
2. Update tests in `packages/python/tests/`
3. Update version in `packages/python/src/withoutbg/__version__.py`
4. Publish to PyPI

### Updating the Web App

1. Backend changes in `apps/web/backend/`
2. Frontend changes in `apps/web/frontend/`
3. Test locally with `docker-compose`
4. Build and push Docker images

## Benefits of This Structure

### ✅ Clear Separation
- Core library is independent
- Applications build on top
- Integrations are isolated

### ✅ Independent Releases
- Python package can be published without affecting web app
- Web app can be updated without republishing Python package
- Integrations have their own release cycles

### ✅ Easy to Extend
- Adding new apps is straightforward
- Adding integrations doesn't affect core
- Each component has focused scope

### ✅ Better Testing
- Unit tests in `packages/python/tests/`
- Integration tests in `apps/web/`
- E2E tests per integration

### ✅ Maintainability
- Each component has clear ownership
- Dependencies are explicit
- Documentation is colocated
