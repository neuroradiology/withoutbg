# 🚀 Docker Hub Quick Start - withoutbg/app

Your Docker image will be available at: **`withoutbg/app`**

## Prerequisites

1. **Login to Docker Hub** (first time only):
   ```bash
   docker login
   ```

2. **Enable Docker Buildx** (usually enabled by default in Docker Desktop):
   ```bash
   # Verify buildx is available
   docker buildx version
   ```

## Publishing Your First Release

### Super Simple - One Command:

```bash
cd apps/web
make docker-release VERSION=1.0.0
```

That's it! This will:
- ✅ Build the production image for **multiple platforms** (amd64 + arm64)
- ✅ Create tags: `1.0.0`, `1.0`, `1`, `latest`
- ✅ Push everything to Docker Hub
- ✅ Works on Intel/AMD CPUs, Apple Silicon, AWS Graviton, and more!

**Note:** The first multi-platform build may take 10-20 minutes. Subsequent builds are faster due to layer caching.

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

### "buildx: command not found" or buildx not available
```bash
# Docker Desktop: Update to latest version (buildx is included)
# Docker CLI: Install buildx plugin
docker buildx install
```

### Multi-platform build is slow
This is normal! Building for multiple architectures takes longer:
- **First build**: 10-20 minutes (no cache)
- **Subsequent builds**: 3-5 minutes (with cache)
- The wait is worth it - users on ALL platforms will be able to run your image!

### Check your published images
Visit: https://hub.docker.com/r/withoutbg/app

You can also inspect the platforms:
```bash
docker manifest inspect withoutbg/app:latest
```

---

## Why Multi-Platform Builds?

The `exec format error` happens when Docker tries to run an image built for a different CPU architecture:

- **Problem**: Image built on Apple Silicon (ARM64) won't run on Intel/AMD servers (AMD64)
- **Solution**: Multi-platform builds create images for both architectures
- **Result**: Same image tag works everywhere - Docker automatically pulls the right version!

**Supported Platforms:**
- `linux/amd64` - Intel/AMD CPUs (most cloud servers, Windows, Linux desktops)
- `linux/arm64` - Apple Silicon (M1/M2/M3), AWS Graviton, Raspberry Pi

---

**Pro Tip:** See the full guide in `DOCKER_HUB_GUIDE.md` for more details!

