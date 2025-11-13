# 🚀 Docker Hub Quick Start - withoutbg/app

Your Docker image will be available at: **`withoutbg/app`**

## Prerequisites

1. **Login to Docker Hub** (first time only):
   ```bash
   docker login
   ```

## Publishing Your First Release

### Super Simple - One Command:

```bash
cd apps/web
make docker-release VERSION=1.0.0
```

That's it! This will:
- ✅ Build the production image
- ✅ Create tags: `1.0.0`, `1.0`, `1`, `latest`
- ✅ Push everything to Docker Hub

## What Users Will Do

Your users can now run:

```bash
docker run -p 80:80 withoutbg/app:latest
```

Then open: **http://localhost**

## Future Releases

### Bug Fix (1.0.0 → 1.0.1):
```bash
make docker-release VERSION=1.0.1
```

### New Feature (1.0.1 → 1.1.0):
```bash
make docker-release VERSION=1.1.0
```

### Breaking Change (1.1.0 → 2.0.0):
```bash
make docker-release VERSION=2.0.0
```

## Available Tags

After releasing `1.2.3`, users can use:

| Tag | Command | Use Case |
|-----|---------|----------|
| `latest` | `docker run -p 80:80 withoutbg/app:latest` | Always get newest |
| `1.2.3` | `docker run -p 80:80 withoutbg/app:1.2.3` | Pin exact version |
| `1.2` | `docker run -p 80:80 withoutbg/app:1.2` | Get patch updates |
| `1` | `docker run -p 80:80 withoutbg/app:1` | Get all v1 updates |

## Test Before Pushing

```bash
# Build locally
make docker-prod-build DOCKER_IMAGE_TAG=1.0.0

# Test locally
make docker-prod-run DOCKER_IMAGE_TAG=1.0.0

# Open http://localhost and test

# Stop
make docker-prod-stop
```

## Troubleshooting

### "Cannot connect to Docker daemon"
```bash
# Start Docker Desktop or Docker daemon
open -a Docker  # macOS
```

### "Access denied"
```bash
docker logout
docker login
# Enter: withoutbg / [your password]
```

### Check your published images
Visit: https://hub.docker.com/r/withoutbg/app

---

**Pro Tip:** See the full guide in `DOCKER_HUB_GUIDE.md` for more details!

