# 🎨 withoutbg/app - AI-Powered Background Removal

[![Docker Pulls](https://img.shields.io/docker/pulls/withoutbg/app)](https://hub.docker.com/r/withoutbg/app)
[![Docker Image Size](https://img.shields.io/docker/image-size/withoutbg/app/latest)](https://hub.docker.com/r/withoutbg/app)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://github.com/withoutbg/withoutbg/blob/main/LICENSE)

> **Remove backgrounds from images instantly** - A self-hosted web application powered by the **withoutBG Focus v1.0.0** open-source model with optional Pro API access for best-in-class quality.

---

## 🚀 Quick Start

Get up and running in **30 seconds**:

```bash
docker run -p 80:80 withoutbg/app:latest
```

Then open **http://localhost** in your browser. That's it! 🎉

---

## ✨ Why Choose withoutbg?

- **🏠 Self-Hosted** - Complete control over your data and processing
- **🚀 Production Ready** - Built with React 18, FastAPI, and Vite
- **🎯 Dual Processing Options** - Local Focus model OR withoutBG Pro API
- **🖼️ High Quality** - Professional-grade results with Focus v1.0.0
- **💻 Modern UI** - Beautiful, responsive interface with drag-and-drop
- **🔒 Privacy First** - Local processing keeps your images on your server
- **📦 Easy Deploy** - Single Docker command to get started
- **🆓 Open Source** - Apache 2.0 licensed, transparent, and extensible

---

## 🎯 Perfect For

- 📸 **Photographers** - Process portraits with fine hair detail preservation
- 🛒 **E-commerce** - Clean product images at scale
- 🎨 **Designers** - Quick background removal in your workflow
- 👥 **Marketing Teams** - Professional images for campaigns
- 🏢 **Agencies** - Self-hosted solution for client work
- 💼 **Small Businesses** - No subscription fees, run on your own hardware

---

## 🎬 What's Inside

This Docker image includes:

- **Frontend**: React 18 + Vite + TailwindCSS
- **Backend**: FastAPI (Python 3.12) with ONNX Runtime
- **AI Model**: **withoutBG Focus v1.0.0** (pre-loaded, ~320MB)
  - ISNet segmentation model (177 MB)
  - Depth Anything V2 vits (99 MB)
  - Focus Matting model (27 MB)
  - Focus Refiner model (15 MB)
- **Server**: Uvicorn serving both API and static files
- **All Dependencies**: Zero configuration needed

---

## 🖼️ Model Quality & Results

### withoutBG Focus (Included - Local Processing)

The **Focus v1.0.0** model included in this Docker image delivers professional results:

- ✅ **Significantly better edge detail** - Crisp, clean edges
- ✅ **Superior hair/fur handling** - Natural-looking fine details  
- ✅ **Better generalization** - Works on diverse image types
- ✅ **Depth-aware processing** - Smart subject detection

**[See Focus Model Results & Examples →](https://withoutbg.com/resources/background-removal-results/model-focus-open-source?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)**

### withoutBG Pro API (Optional - Best Quality)

For the absolute best quality, you can use the withoutBG Pro API:

- 🏆 **Best-in-class quality** - Superior to Focus model
- ⚡ **Faster processing** - Optimized cloud infrastructure
- 🔧 **No local resources** - Offload processing to the cloud
- 📈 **Scalable** - Handle high-volume workloads

**[See Pro API Results & Comparison →](https://withoutbg.com/resources/background-removal-results/model-pro-api?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)**

**[Compare Focus vs Pro →](https://withoutbg.com/resources/compare/focus-vs-pro?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)**

---

## 📖 Usage Examples

### Basic Usage

```bash
# Run on default port 80
docker run -p 80:80 withoutbg/app:latest

# Run on custom port
docker run -p 8080:80 withoutbg/app:latest

# Run in background
docker run -d -p 80:80 --name withoutbg withoutbg/app:latest
```

### Production Deployment

```bash
# With restart policy
docker run -d \
  --name withoutbg \
  --restart unless-stopped \
  -p 80:80 \
  withoutbg/app:latest
```

### With Docker Compose

```yaml
version: '3.8'
services:
  withoutbg:
    image: withoutbg/app:latest
    ports:
      - "80:80"
    restart: unless-stopped
```

### Using withoutBG Pro API (Optional)

Want even better quality? Simply enter your API key in the web interface!

1. Get your API key from: [withoutbg.com](https://withoutbg.com?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)
2. Open the web interface at http://localhost
3. Enter your API key in the settings
4. Switch between local Focus model and Pro API as needed

---

## 🌐 Access Your Application

After starting the container, open your browser:

**→ http://localhost**

That's it! You'll see a beautiful drag-and-drop interface where you can:
- 📤 Upload images (drag & drop or click to browse)
- 🎨 Process images with the Focus model
- 🔄 Compare before/after with an interactive slider
- 💾 Download processed images instantly

---

## 💡 How to Use the Web Interface

1. **Start the container** (see Quick Start above)
2. **Open http://localhost** in your browser
3. **Drag and drop** your image or click to browse
4. **Wait a few seconds** for processing (~2-5 seconds)
5. **Compare results** with the before/after slider
6. **Download** your image with transparent background

### Optional: Use Pro API for Best Quality

Want even better results? You can easily switch to the Pro API:

1. **Get your API key** from [withoutbg.com](https://withoutbg.com?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)
2. **Enter it in the web interface** settings
3. **Switch between models** as needed:
   - **Local Focus Model** (free, fast, good quality)
   - **Pro API** (best quality, requires API key)

---

## 📊 Version Tags

| Tag | Description | When to Use |
|-----|-------------|-------------|
| `latest` | Latest stable release | Production deployments |
| `1.x.x` | Specific version | Pin to exact version |
| `1.x` | Minor version line | Get patch updates automatically |
| `1` | Major version line | Get all v1.x updates |

**Example:**
```bash
# Always get latest
docker pull withoutbg/app:latest

# Pin to specific version
docker pull withoutbg/app:1.0.0

# Get patch updates for 1.0
docker pull withoutbg/app:1.0
```

---

## 🔧 Configuration & Environment

### Default Settings

- **Port**: 80 (internal container port)
- **Model**: withoutBG Focus v1.0.0 (pre-loaded)
- **Supported Formats**: PNG, JPEG, WebP
- **Max Upload Size**: 10MB (configurable)

### Custom Port Mapping

```bash
# Run on a different port (e.g., 8080)
docker run -d \
  -p 8080:80 \
  withoutbg/app:latest

# Then access at http://localhost:8080
```

---

## 📈 Performance

### Local Processing (Focus Model)

- **First Run**: ~5-10 seconds per image (model initialization)
- **Subsequent Runs**: ~2-5 seconds per image (CPU)
- **Memory Usage**: ~2GB RAM
- **Disk Space**: ~320MB (models are pre-loaded in the image)
- **Cost**: Free forever

### Pro API Processing (Optional)

- **Processing Time**: ~1-3 seconds per image
- **Memory Usage**: Minimal (processing happens in the cloud)
- **Cost**: Pay per use
- **Quality**: Best-in-class results

---

## 🔒 Privacy & Security

- **Local-First**: All processing with Focus model happens on your server
- **No External Calls**: Your images never leave your server (unless using Pro API)
- **Open Source**: Audit the code yourself
- **Apache 2.0 License**: Commercial-friendly license

---

## 🆘 Troubleshooting

### Container won't start?
```bash
# Check logs
docker logs withoutbg

# Check if port 80 is available
docker ps
lsof -i :80  # macOS/Linux
```

### Out of memory?
```bash
# Increase Docker memory limit
# Docker Desktop → Settings → Resources → Memory
# Recommended: 4GB+ for smooth operation
```

### Port already in use?
```bash
# Use a different port
docker run -p 8080:80 withoutbg/app:latest
# Then access at http://localhost:8080
```

### API returns errors?
```bash
# Check API health
curl http://localhost/api/health

# View detailed logs
docker logs -f withoutbg
```

---

## 🤝 Contributing

This is an open-source project! We welcome contributions:

- 🐛 **Report bugs**: [GitHub Issues](https://github.com/withoutbg/withoutbg/issues)
- 💡 **Suggest features**: [GitHub Discussions](https://github.com/withoutbg/withoutbg/discussions)
- 🔧 **Submit PRs**: [Contributing Guide](https://github.com/withoutbg/withoutbg/blob/main/CONTRIBUTING.md)

**Repository**: [github.com/withoutbg/withoutbg](https://github.com/withoutbg/withoutbg)

---

## 📜 License

**Apache License 2.0** - see [LICENSE](https://github.com/withoutbg/withoutbg/blob/main/LICENSE)

### Third-Party Components
- **Depth Anything V2**: Apache 2.0 License (vits model only)
- **ISNet**: Apache 2.0 License

See [THIRD_PARTY_LICENSES.md](https://github.com/withoutbg/withoutbg/blob/main/THIRD_PARTY_LICENSES.md) for complete attribution.

---

## 🌟 Star Us on GitHub!

If you find this useful, please ⭐ the repository:  
**[github.com/withoutbg/withoutbg](https://github.com/withoutbg/withoutbg)**

---

## 📚 Additional Resources

- **[Complete Documentation](https://withoutbg.com/documentation/integrations/dockerized-web-app?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)** - Detailed setup and deployment guide
- **[Focus Model Results](https://withoutbg.com/resources/background-removal-results/model-focus-open-source?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)** - See example outputs from the included model
- **[Pro API Results](https://withoutbg.com/resources/background-removal-results/model-pro-api?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)** - See best-quality outputs
- **[Model Comparison](https://withoutbg.com/resources/compare/focus-vs-pro?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)** - Focus vs Pro side-by-side
- **[GitHub Repository](https://github.com/withoutbg/withoutbg)** - Source code and issues
- **[Changelog](https://github.com/withoutbg/withoutbg/blob/main/CHANGELOG.md)** - Release history
- **[Python SDK](https://withoutbg.com/documentation/integrations/python-sdk?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)** - For programmatic use

---

## 💬 Support & Community

- **GitHub Issues**: [Report bugs](https://github.com/withoutbg/withoutbg/issues)
- **GitHub Discussions**: [Ask questions](https://github.com/withoutbg/withoutbg/discussions)
- **Website**: [withoutbg.com](https://withoutbg.com?utm_source=dockerhub&utm_medium=withoutbg-app&utm_campaign=docker-readme)

---

**Built with ❤️ by the withoutbg team**

*Remove backgrounds like a pro. No subscription required.* 🚀

