# withoutbg

**AI-powered background removal with local and cloud options**

[![PyPI](https://img.shields.io/pypi/v/withoutbg.svg)](https://pypi.org/project/withoutbg/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Remove backgrounds from images instantly with AI. Choose between local processing (free) or cloud API (best quality).

## 🚀 Quick Start

### Python SDK

```bash
# Install (using uv - recommended)
uv add withoutbg

# Or with pip
pip install withoutbg

# Use in Python
from withoutbg import remove_background
result = remove_background("input.jpg")
result.save("output.png")

# CLI
withoutbg image.jpg
```

> **Don't have `uv` yet?** Download it at [astral.sh/uv](https://astral.sh/uv) - it's a fast, modern Python package installer.

### Web Application

```bash
# Clone and run with Docker
git clone https://github.com/withoutbg/withoutbg.git
cd withoutbg
docker-compose -f apps/web/docker-compose.yml up

# Open browser
open http://localhost:3000
```

## 📦 Repository Structure

This is a **monorepo** containing multiple components:

```
withoutbg/
├── packages/          # Reusable packages
│   └── python/        # Core Python SDK (published to PyPI)
│
├── apps/              # End-user applications
│   └── web/           # Web application (React + FastAPI)
│
├── integrations/      # Third-party tool integrations
│   └── (future: GIMP, Photoshop, Figma plugins)
│
├── models/            # Shared ML model files
│   └── checkpoints/   # ONNX model files
│
├── docs/              # Documentation
└── scripts/           # Development scripts
```

### Components

#### 📚 [Python SDK](packages/python/)
Core library for background removal. Published to PyPI.

- **Install**: `uv add withoutbg` (or `pip install withoutbg`)
- **Use**: Python API + CLI
- **Models**: Focus v1.0.0 (local), Cloud API

#### 🌐 [Web Application](apps/web/)
Modern web interface with drag-and-drop UI.

- **Stack**: React 18 + FastAPI + Nginx
- **Deploy**: Docker Compose
- **Features**: Batch processing, live preview

#### 🔌 Integrations (Coming Soon)
Plugins for popular creative tools.

- GIMP plugin
- Photoshop extension
- Figma plugin
- Blender addon

## 🎯 Features

- ✨ **Local Processing**: Free, private, offline with Focus v1.0.0
- 🚀 **Cloud API**: Best quality, scalable, 99.9% uptime
- 📦 **Batch Processing**: Process multiple images efficiently
- 🌐 **Web Interface**: Beautiful drag-and-drop UI
- 🔧 **CLI Tool**: Command-line automation
- 🎨 **Integrations**: Work in your favorite tools

## 📖 Documentation

- **[Python SDK Docs](packages/python/README.md)** - API reference and examples
- **[Web App Docs](apps/web/README.md)** - Deployment and development
- **[API Reference](https://withoutbg.com/documentation)** - Cloud API docs

## 🛠️ Development

### Python Package

```bash
cd packages/python

# Install in development mode (using uv - recommended)
uv sync --extra dev

# Or with pip
pip install -e ".[dev]"

# Run tests
pytest

# Format code
black src/ tests/
ruff check src/ tests/
```

### Web Application

```bash
# Development mode (hot-reload)
docker-compose -f apps/web/docker-compose.yml up

# Or run components separately
cd apps/web/backend
uv sync
uvicorn app.main:app --reload

cd apps/web/frontend
npm install
npm run dev
```

## 🌟 Latest Release: Focus v1.0.0

Our most advanced open source model with:

- ✅ **Significantly better edge detail** - Crisp, clean edges
- ✅ **Superior hair/fur handling** - Natural-looking fine details  
- ✅ **Better generalization** - Works on diverse image types

See [examples/](packages/python/examples/) for visual comparisons.

## 📄 License

Apache License 2.0 - see [LICENSE](LICENSE)

### Third-Party Components
- **Depth Anything V2**: Apache 2.0 License (only vits model)
- **ISNet**: Apache 2.0 License

See [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md) for complete attribution.

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📧 Support

- **Bug Reports**: [GitHub Issues](https://github.com/withoutbg/withoutbg/issues)
- **Feature Requests**: [GitHub Discussions](https://github.com/withoutbg/withoutbg/discussions)
- **Commercial Support**: [contact@withoutbg.com](mailto:contact@withoutbg.com)

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=withoutbg/withoutbg&type=Date)](https://star-history.com/#withoutbg/withoutbg&Date)

