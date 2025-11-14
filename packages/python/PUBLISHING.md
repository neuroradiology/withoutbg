# Publishing Guide for withoutbg Python Package

This guide covers how to publish the `withoutbg` Python package to PyPI using modern tools (`uv` and `hatch`).

## Prerequisites

### 1. Create PyPI API Tokens

You'll need API tokens for authentication (more secure than passwords):

- **TestPyPI** (for testing): https://test.pypi.org/manage/account/token/
- **PyPI** (for production): https://pypi.org/manage/account/token/

### 2. Configure UV with Your Tokens

Create or edit `~/.config/uv/config.toml`:

```toml
[publish]
# For TestPyPI
[publish.test-pypi]
url = "https://test.pypi.org/legacy/"
username = "__token__"
password = "pypi-..."  # Your TestPyPI token

# For PyPI (production)
[publish.pypi]
username = "__token__"
password = "pypi-..."  # Your PyPI token
```

Alternatively, you can use environment variables:

```bash
# For TestPyPI
export UV_PUBLISH_USERNAME="__token__"
export UV_PUBLISH_PASSWORD="pypi-..."

# For PyPI
export UV_PUBLISH_URL="https://upload.pypi.org/legacy/"
export UV_PUBLISH_USERNAME="__token__"
export UV_PUBLISH_PASSWORD="pypi-..."
```

Or pass the token interactively when prompted during publishing.

## Publishing Workflow

### Step 1: Pre-publish Checks

Run quality checks and build the package:

```bash
make publish-check
```

This will:
- Run linting (ruff)
- Check code formatting (black)
- Run type checking (mypy)
- Build the package (creates `dist/` directory)
- Show you what will be published

### Step 2: Test on TestPyPI (Recommended)

Always test on TestPyPI first before publishing to production:

```bash
make publish-test
```

This will:
- Run all pre-publish checks
- Upload to https://test.pypi.org
- Provide instructions for testing the installation

Test the installation from TestPyPI:

```bash
pip install --index-url https://test.pypi.org/simple/ withoutbg
```

### Step 3: Publish to PyPI (Production)

Once you've verified everything works on TestPyPI:

```bash
make publish
```

This will:
- Run all pre-publish checks
- Show the version being published
- Wait 3 seconds (giving you time to cancel with Ctrl+C)
- Upload to https://pypi.org

After publishing, users can install with:

```bash
pip install withoutbg
```

## Version Management

The package uses semantic versioning. Use these commands to bump versions:

```bash
# Increment patch version (0.1.0 -> 0.1.1) - for bug fixes
make version-patch

# Increment minor version (0.1.0 -> 0.2.0) - for new features
make version-minor

# Increment major version (0.1.0 -> 1.0.0) - for breaking changes
make version-major

# Check current version
make version-show
```

## Complete Release Workflow Example

Here's a typical workflow for releasing a new version:

```bash
# 1. Make your changes and commit them
git add .
git commit -m "Add new feature X"

# 2. Bump the version (e.g., minor release for new features)
make version-minor

# 3. Run pre-publish checks
make publish-check

# 4. Test on TestPyPI
make publish-test

# 5. Test installation from TestPyPI
pip install --index-url https://test.pypi.org/simple/ withoutbg
# ... test your package ...

# 6. If everything works, publish to PyPI
make publish

# 7. Tag the release in git
git tag -a v$(uv run hatch version) -m "Release v$(uv run hatch version)"
git push origin v$(uv run hatch version)
```

## Troubleshooting

### Authentication Issues

If you get authentication errors:

1. **Check your token**: Make sure you're using `__token__` as the username
2. **Token format**: PyPI tokens start with `pypi-`
3. **Token permissions**: Ensure your token has upload permissions
4. **Config location**: UV looks for config at `~/.config/uv/config.toml`

### Version Already Exists

If you try to upload a version that already exists on PyPI:

```
ERROR: File already exists
```

You cannot replace an existing version on PyPI. You must:
1. Bump the version number: `make version-patch`
2. Build again: `make build`
3. Publish the new version: `make publish`

### Build Failures

If the build fails:

1. Check `pyproject.toml` is correctly configured
2. Ensure all required files are included (see `tool.hatch.build.targets.sdist`)
3. Run `make quality` to catch issues before building

## Why UV Instead of Twine?

The package uses **UV** (from Astral, the creators of Ruff) instead of the traditional Twine:

**Advantages:**
- ✅ **Faster**: Written in Rust, significantly faster than Twine
- ✅ **Modern**: Part of the next-generation Python tooling ecosystem
- ✅ **Integrated**: Works seamlessly with the rest of the UV toolchain
- ✅ **Simple**: Same tool for installing, building, and publishing
- ✅ **Secure**: Built-in support for API tokens and modern authentication

**Comparison:**
```bash
# Traditional approach
pip install build twine
python -m build
twine upload dist/*

# Modern approach with UV
uv build
uv publish
```

## Additional Resources

- **UV Documentation**: https://docs.astral.sh/uv/
- **PyPI Publishing Guide**: https://packaging.python.org/tutorials/packaging-projects/
- **Hatch Documentation**: https://hatch.pypa.io/
- **Package on PyPI**: https://pypi.org/project/withoutbg/

## Support

If you encounter issues, check:
1. UV version: `uv --version` (should be recent)
2. Package builds locally: `make build`
3. All tests pass: `make test`
4. Code quality checks pass: `make quality`

