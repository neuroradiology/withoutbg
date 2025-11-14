# 🚀 Docker Release Checklist

Use this checklist when releasing a new version of `withoutbg/app` to Docker Hub.

## Pre-Release Checklist

### 1. Version Bump

- [ ] Decide on version number (use [Semantic Versioning](https://semver.org/))
  - **Patch** (1.0.0 → 1.0.1): Bug fixes, small improvements
  - **Minor** (1.0.1 → 1.1.0): New features, backward compatible
  - **Major** (1.1.0 → 2.0.0): Breaking changes

### 2. Local Testing

- [ ] Test frontend locally
  ```bash
  cd apps/web/frontend
  npm run build
  npm run preview
  ```

- [ ] Test backend locally
  ```bash
  cd apps/web/backend
  uv run uvicorn app.main:app --reload
  curl http://localhost:8000/api/health
  ```

- [ ] Test full Docker build locally
  ```bash
  cd apps/web
  make docker-prod-build DOCKER_IMAGE_TAG=test
  make docker-prod-run DOCKER_IMAGE_TAG=test
  # Open http://localhost and test features
  make docker-prod-stop
  ```

### 3. Code Quality

- [ ] All tests passing
  ```bash
  cd packages/python
  uv run pytest
  ```

- [ ] No linting errors
  ```bash
  cd apps/web/frontend
  npm run lint
  ```

- [ ] Update CHANGELOG.md with release notes

### 4. Documentation

- [ ] Update version references in documentation
- [ ] Verify Docker Hub README is up to date
- [ ] Check that DOCKER_RELEASE.md reflects current process

---

## Release Process

### 1. Verify Prerequisites

- [ ] Docker Desktop is running
- [ ] Docker buildx is available
  ```bash
  docker buildx version
  ```

- [ ] Logged into Docker Hub
  ```bash
  docker login
  # Username: withoutbg
  ```

### 2. Build & Push Multi-Platform Image

- [ ] Run the release command
  ```bash
  cd apps/web
  make docker-release VERSION=X.Y.Z
  ```

- [ ] Wait for build to complete (15-20 minutes first time, 3-5 minutes cached)
- [ ] Verify both platforms were pushed
  ```bash
  docker manifest inspect withoutbg/app:X.Y.Z
  ```

Expected output should show:
```json
"manifests": [
  {"platform": {"architecture": "amd64", "os": "linux"}},
  {"platform": {"architecture": "arm64", "os": "linux"}}
]
```

### 3. Verify on Docker Hub

- [ ] Visit https://hub.docker.com/r/withoutbg/app/tags
- [ ] Verify new tags are present:
  - `X.Y.Z` (full version)
  - `X.Y` (minor version)
  - `X` (major version)
  - `latest`

- [ ] Check image size is reasonable (~800MB - 1GB)
- [ ] Verify "OS/ARCH" column shows multiple platforms

---

## Post-Release Testing

### 1. Test AMD64 (Intel/AMD)

If you have access to an Intel/AMD system:

```bash
docker pull withoutbg/app:X.Y.Z
docker run --platform linux/amd64 -p 80:80 withoutbg/app:X.Y.Z
# Open http://localhost
# Upload an image and verify it processes correctly
```

- [ ] Image pulls successfully
- [ ] Container starts without errors
- [ ] Web interface loads
- [ ] Background removal works
- [ ] Download processed image works

### 2. Test ARM64 (Apple Silicon / AWS Graviton)

If you have access to an ARM system:

```bash
docker pull withoutbg/app:X.Y.Z
docker run --platform linux/arm64 -p 80:80 withoutbg/app:X.Y.Z
# Open http://localhost
# Upload an image and verify it processes correctly
```

- [ ] Image pulls successfully
- [ ] Container starts without errors
- [ ] Web interface loads
- [ ] Background removal works
- [ ] Download processed image works

### 3. Test Auto-Detection

```bash
# Don't specify platform, let Docker auto-detect
docker pull withoutbg/app:X.Y.Z
docker run -p 80:80 withoutbg/app:X.Y.Z
```

- [ ] Docker automatically pulls correct architecture
- [ ] No "exec format error"

---

## Announcement Checklist

### 1. Update Documentation

- [ ] Update version in main README.md
- [ ] Update CHANGELOG.md with release notes
- [ ] Tag release in Git
  ```bash
  git tag -a vX.Y.Z -m "Release X.Y.Z"
  git push origin vX.Y.Z
  ```

### 2. Create GitHub Release

- [ ] Go to https://github.com/withoutbg/withoutbg/releases/new
- [ ] Choose tag: `vX.Y.Z`
- [ ] Release title: `withoutbg vX.Y.Z`
- [ ] Copy release notes from CHANGELOG.md
- [ ] Mention Docker image availability:
  ```markdown
  ## Docker Image
  
  ```bash
  docker run -p 80:80 withoutbg/app:X.Y.Z
  ```
  
  ✅ Multi-platform support: linux/amd64, linux/arm64
  ```
- [ ] Publish release

### 3. Social Media (Optional)

- [ ] Tweet about the release
- [ ] Post on relevant forums/communities
- [ ] Update website if applicable

---

## Rollback Procedure

If there's a critical issue with the release:

### 1. Revert `latest` tag

```bash
# Point latest back to previous version
docker pull withoutbg/app:PREVIOUS_VERSION
docker tag withoutbg/app:PREVIOUS_VERSION withoutbg/app:latest
docker push withoutbg/app:latest
```

### 2. Delete Bad Tags (Optional)

You cannot delete tags from Docker Hub via CLI, but you can:
- Go to https://hub.docker.com/r/withoutbg/app/tags
- Manually delete the problematic tags

### 3. Communicate

- [ ] Post issue on GitHub explaining the problem
- [ ] Update release notes
- [ ] Notify users if necessary

---

## Troubleshooting Release Issues

### Build fails on one platform

**Symptom**: Build succeeds for one platform but fails for another

**Diagnosis**:
```bash
# Try building each platform separately
docker buildx build --platform linux/amd64 -f apps/web/Dockerfile -t test-amd64 .
docker buildx build --platform linux/arm64 -f apps/web/Dockerfile -t test-arm64 .
```

**Solutions**:
- Check Dockerfile for architecture-specific dependencies
- Verify base images support both platforms
- Look for hardcoded architecture assumptions

### "no basic auth credentials"

**Symptom**: Build succeeds but push fails

**Solution**:
```bash
docker logout
docker login
# Re-enter credentials
```

### Multi-platform build is stuck

**Symptom**: Build hangs during cross-compilation

**Solution**:
- Check Docker Desktop has sufficient memory (4GB+)
- Restart Docker Desktop
- Clear build cache:
  ```bash
  docker buildx prune -a
  ```

### Image size too large

**Symptom**: Image over 2GB

**Solution**:
- Check for unnecessary files in image
- Verify `.dockerignore` is present
- Use multi-stage builds to minimize final image size
- Remove build dependencies in final stage

---

## Quick Reference

### Version Numbering

| Change Type | Example | Command |
|-------------|---------|---------|
| Bug fix | 1.0.0 → 1.0.1 | `make docker-release VERSION=1.0.1` |
| New feature | 1.0.1 → 1.1.0 | `make docker-release VERSION=1.1.0` |
| Breaking change | 1.1.0 → 2.0.0 | `make docker-release VERSION=2.0.0` |

### Useful Commands

```bash
# Check what platforms an image supports
docker manifest inspect withoutbg/app:latest

# Pull specific platform
docker pull --platform linux/amd64 withoutbg/app:latest

# Run with specific platform
docker run --platform linux/arm64 -p 80:80 withoutbg/app:latest

# Check your system architecture
uname -m  # Linux/Mac
docker version --format '{{.Server.Arch}}'  # Docker

# View buildx builders
docker buildx ls

# Remove old buildx builder
docker buildx rm withoutbg-builder
```

---

## Related Documents

- [DOCKER_RELEASE.md](./DOCKER_RELEASE.md) - Quick start guide
- [MULTI_PLATFORM_DOCKER.md](./MULTI_PLATFORM_DOCKER.md) - Technical details
- [EXEC_FORMAT_ERROR_FIX.md](./EXEC_FORMAT_ERROR_FIX.md) - User troubleshooting
- [ARCHITECTURE_COMPATIBILITY.md](../ARCHITECTURE_COMPATIBILITY.md) - Architecture guide

---

**Remember**: Multi-platform builds take longer but ensure compatibility for all users. The 15-20 minute build time is worth it to prevent "exec format error" for 70%+ of users on different architectures! 🚀

