# withoutbg Backend

FastAPI-based REST API for AI-powered background removal.

## Features

- 🚀 High-performance async API with FastAPI
- 🤖 Built-in Focus v1.0.0 AI model
- 🔌 Optional cloud API integration
- 📊 Health checks and monitoring
- 🔄 Single and batch processing
- 📝 Interactive API documentation (Swagger/OpenAPI)

## Development

### Prerequisites

- Python 3.12
- uv (recommended) or pip

### Setup

```bash
# Install dependencies with uv
uv pip install -r requirements.txt

# Or with pip
pip install -r requirements.txt

# Run the server
python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### Environment Variables

Create a `.env` file:

```bash
PORT=8000
PYTHONUNBUFFERED=1
WITHOUTBG_API_KEY=sk_your_api_key_here  # Optional
```

## Project Structure

```
backend/
├── app/
│   ├── __init__.py
│   └── main.py          # FastAPI application
├── requirements.txt      # Python dependencies
├── pyproject.toml       # Package configuration
└── README.md
```

## API Endpoints

### Health Check
```
GET /api/health
```

Response:
```json
{
  "status": "healthy",
  "version": "1.0.0",
  "service": "withoutbg-api"
}
```

### Remove Background (Single)
```
POST /api/remove-background
Content-Type: multipart/form-data
```

Parameters:
- `file`: Image file (required)
- `format`: Output format - png/jpg/webp (default: png)
- `quality`: JPEG quality 1-100 (default: 95)
- `api_key`: Optional API key for cloud processing

Returns: Processed image file

### Remove Background (Batch)
```
POST /api/batch-remove-background
Content-Type: multipart/form-data
```

Parameters:
- `files[]`: Multiple image files (max 10)
- `format`: Output format - png/jpg/webp (default: png)
- `quality`: JPEG quality 1-100 (default: 95)
- `api_key`: Optional API key for cloud processing

Returns: JSON with base64-encoded images

### Get Usage
```
GET /api/usage?api_key=sk_your_key
```

Returns: API usage statistics

## Interactive Documentation

When the server is running, visit:
- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

## Technology Stack

- **FastAPI**: Modern Python web framework
- **Uvicorn**: ASGI server
- **Pillow**: Image processing
- **python-multipart**: File upload handling
- **withoutbg**: Core background removal library

## Docker

Build and run with Docker:

```bash
# Build
docker build -f ../Dockerfile.backend -t withoutbg-backend ..

# Run
docker run -p 8000:8000 -v $(pwd)/../checkpoints:/app/checkpoints withoutbg-backend
```

## Testing

```bash
# Test health endpoint
curl http://localhost:8000/api/health

# Test background removal
curl -X POST http://localhost:8000/api/remove-background \
  -F "file=@test.jpg" \
  -F "format=png" \
  --output result.png
```

## Performance

- Async/await for non-blocking I/O
- Efficient memory management
- Supports concurrent requests
- Health checks for monitoring

## Error Handling

The API returns appropriate HTTP status codes:
- `200`: Success
- `400`: Bad request (invalid input)
- `500`: Internal server error

Error responses include detailed messages:
```json
{
  "detail": "File must be an image"
}
```

## Contributing

1. Make changes to the code
2. Test with `uvicorn app.main:app --reload`
3. Ensure all endpoints work correctly
4. Submit a pull request

## License

Apache 2.0 - See parent LICENSE file
