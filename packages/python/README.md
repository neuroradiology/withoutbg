# withoutbg - Python SDK

AI-powered background removal with local and cloud options.

[![PyPI](https://img.shields.io/pypi/v/withoutbg.svg)](https://pypi.org/project/withoutbg/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Installation

```bash
# Using uv (recommended)
uv add withoutbg

# Or with pip
pip install withoutbg
```

> **Don't have `uv` yet?** Download it at [astral.sh/uv](https://astral.sh/uv) - it's a fast, modern Python package installer.

## Quick Start

```python
from withoutbg import remove_background

# Remove background (local processing)
result = remove_background("input.jpg")
result.save("output.png")

# Use cloud API for best quality
result = remove_background("input.jpg", api_key="sk_your_key")
result.save("output.png")
```

## CLI Usage

```bash
# Process single image
withoutbg photo.jpg

# Batch processing
withoutbg photos/ --batch --output-dir results/

# Use cloud API
withoutbg photo.jpg --api-key sk_your_key
```

## Features

- ✨ Local processing with Focus v1.0.0 model (free)
- 🚀 Cloud API for best quality results
- 📦 Batch processing support
- 🎯 Python API and CLI
- 🔧 Flexible output formats (PNG, JPEG, WebP)

## Configuration

### Model Path Environment Variables

By default, models are downloaded from HuggingFace Hub. You can override this by setting environment variables to use local model files:

```bash
export WITHOUTBG_DEPTH_MODEL_PATH=/path/to/depth_anything_v2_vits_slim.onnx
export WITHOUTBG_ISNET_MODEL_PATH=/path/to/isnet.onnx
export WITHOUTBG_MATTING_MODEL_PATH=/path/to/focus_matting_1.0.0.onnx
export WITHOUTBG_REFINER_MODEL_PATH=/path/to/focus_refiner_1.0.0.onnx
```

This is useful for:
- Offline environments
- CI/CD pipelines
- Custom model versions
- Faster startup times (no download needed)

## Documentation

For complete documentation, see the [main project README](../../README.md).

## Development

```bash
# Install in development mode (using uv - recommended)
uv sync --extra dev

# Or with pip
pip install -e ".[dev]"

# Run tests
pytest

# Type checking
mypy src/

# Format code
black src/ tests/
ruff check src/ tests/
```

## License

Apache License 2.0 - see [LICENSE](../../LICENSE)






