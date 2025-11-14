# Quick Start: Publishing to PyPI

## ✅ Setup Complete!

Your package now has modern publishing commands using **UV** instead of Twine.

## 📦 New Make Commands Available

From the **root directory** or the **packages/python** directory:

```bash
# Option 1: Pre-publish checks (quality + build)
make publish-check

# Option 2: Publish to TestPyPI (for testing)
make publish-test

# Option 3: Publish to PyPI (production)
make publish
```

## 🚀 Quick Publishing Workflow

### 1. First Time Setup

You need to configure your PyPI API tokens. Choose ONE of these methods:

#### Method A: Environment Variables (Recommended for CI/CD)

```bash
# For PyPI
export UV_PUBLISH_USERNAME="__token__"
export UV_PUBLISH_PASSWORD="pypi-YOUR_TOKEN_HERE"

# For TestPyPI
export UV_PUBLISH_USERNAME="__token__"
export UV_PUBLISH_PASSWORD="pypi-YOUR_TEST_TOKEN_HERE"
```

#### Method B: Interactive (Easiest for Manual Publishing)

Just run the publish command, and UV will prompt you for credentials.

#### Method C: Config File (Persistent)

Create `~/.config/uv/config.toml`:

```toml
[publish.pypi]
username = "__token__"
password = "pypi-YOUR_TOKEN_HERE"
```

Get your tokens:
- **TestPyPI**: https://test.pypi.org/manage/account/token/
- **PyPI**: https://pypi.org/manage/account/token/

### 2. Before Publishing

Fix any linting issues first:

```bash
# Auto-fix most issues
make fix

# Check if everything passes
make quality
```

### 3. Publish to TestPyPI (Recommended First Step)

```bash
# Test on TestPyPI first
make publish-test
```

This will:
- ✅ Run quality checks (lint, format, type check)
- ✅ Build the package
- ✅ Upload to TestPyPI

Then test installation:

```bash
pip install --index-url https://test.pypi.org/simple/ withoutbg
```

### 4. Publish to PyPI (Production)

Once TestPyPI works:

```bash
# Publish to production PyPI
make publish
```

This will:
- ✅ Run quality checks
- ✅ Build the package
- ⏸️  Wait 3 seconds (giving you time to cancel)
- ✅ Upload to PyPI

## 🔄 Version Management

Bump version before publishing:

```bash
# For bug fixes (0.1.0 -> 0.1.1)
make version-patch

# For new features (0.1.0 -> 0.2.0)
make version-minor

# For breaking changes (0.1.0 -> 1.0.0)
make version-major
```

## 📝 Complete Release Example

Here's a typical release workflow:

```bash
# 1. Fix any code quality issues
cd packages/python
make fix

# 2. Verify quality checks pass
make quality

# 3. Bump version (e.g., for a patch release)
make version-patch

# 4. Test on TestPyPI
make publish-test

# 5. If all looks good, publish to production
make publish
```

## 🆘 Current Issue

Your codebase has some linting errors (mostly line length and whitespace issues). Before you can publish, you need to:

```bash
# Auto-fix most issues
cd /Users/elif/withoutbg/withoutbg/packages/python
make fix

# Or from root:
cd /Users/elif/withoutbg/withoutbg
make fix
```

This will automatically:
- Fix line length issues
- Remove trailing whitespace
- Sort imports
- Format code with Black

## 🎯 Immediate Next Steps

1. **Fix linting issues**: `make fix`
2. **Verify quality**: `make quality`
3. **Test publish**: `make publish-test`
4. **Production publish**: `make publish`

## 📚 More Details

See `PUBLISHING.md` for comprehensive documentation.

## ⚡ Why UV Instead of Twine?

- **10x faster** (written in Rust)
- **Modern** (part of next-gen Python tooling)
- **Integrated** (same tool for everything)
- **Secure** (built-in token support)

No need to install separate tools like `twine` and `build`!


