# Contributing to withoutbg

We welcome contributions to withoutbg! This document provides guidelines for contributing to the project.

## 🤝 How to Contribute

### Reporting Issues
- **Bug Reports**: Use our [issue template](https://github.com/withoutbg/withoutbg/issues/new?template=bug_report.md)
- **Feature Requests**: Use our [feature request template](https://github.com/withoutbg/withoutbg/issues/new?template=feature_request.md)
- **Security Issues**: Email security@withoutbg.com instead of creating public issues

### Code Contributions

1. **Fork the Repository**
   ```bash
   git clone https://github.com/your-username/withoutbg.git
   cd withoutbg
   ```

2. **Set Up Development Environment**
   ```bash
   # Install uv (if you don't have it yet)
   # Download from: https://astral.sh/uv
   
   # Install dependencies (using uv - recommended)
   uv sync --extra dev
   
   # Or with pip (create venv first)
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -e ".[dev]"
   
   pre-commit install
   ```

3. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make Your Changes**
   - Write clean, well-documented code
   - Add tests for new functionality
   - Update documentation as needed
   - Follow our coding standards (see below)

5. **Test Your Changes**
   ```bash
   # Run tests
   pytest
   
   # Check code formatting
   black src/ tests/
   ruff check src/ tests/
   
   # Type checking
   mypy src/
   ```

6. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "feat: add awesome new feature"
   ```

7. **Push and Create Pull Request**
   ```bash
   git push origin feature/your-feature-name
   ```

## 📋 Coding Standards

### Python Code Style
- **Formatting**: We use [Black](https://black.readthedocs.io/) with 88 character line length
- **Linting**: We use [Ruff](https://docs.astral.sh/ruff/) for fast Python linting
- **Type Hints**: All new code should include type hints
- **Docstrings**: Use Google-style docstrings for all public functions

### Example Code Style
```python
def remove_background(
    input_image: Union[str, Path, Image.Image, bytes],
    output_path: Optional[Union[str, Path]] = None,
    api_key: Optional[str] = None,
) -> Image.Image:
    """Remove background from an image.
    
    Args:
        input_image: Input image as file path, PIL Image, or bytes
        output_path: Optional path to save the result
        api_key: API key for Studio service
        
    Returns:
        PIL Image with background removed
        
    Raises:
        WithoutBGError: If background removal fails
    """
    # Implementation here
    pass
```

### Commit Message Format
We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```bash
git commit -m "feat: add batch processing support"
git commit -m "fix: handle RGBA images correctly"
git commit -m "docs: update API examples"
```

## 🧪 Testing Guidelines

### Writing Tests
- Write tests for all new functionality
- Aim for >80% test coverage
- Use descriptive test names
- Mock external dependencies (API calls, file operations)

### Test Structure
```python
class TestRemoveBackground:
    """Test the remove_background function."""
    
    def test_remove_background_with_pil_image(self):
        """Test background removal with PIL Image input."""
        # Arrange
        input_image = Image.new('RGB', (100, 100), 'red')
        
        # Act
        result = remove_background(input_image)
        
        # Assert
        assert isinstance(result, Image.Image)
        assert result.mode == 'RGBA'
```

### Running Tests
```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src/withoutbg

# Run specific test file
pytest tests/test_core.py

# Run with verbose output
pytest -v
```

## 📚 Documentation

### Updating Documentation
- Update docstrings for any changed functions
- Update README.md if adding new features
- Add examples to the `examples/` directory
- Update `docs/` for comprehensive changes

### Documentation Style
- Use clear, concise language
- Include code examples
- Explain the "why" not just the "how"
- Add links to related concepts

## 🎯 Areas Where We Need Help

### High Priority
- **Error Handling**: Better error messages and recovery
- **Documentation**: More examples and tutorials

### Medium Priority
- **CLI Enhancements**: Additional output formats and options
- **Testing**: Edge cases and integration tests
- **Platform Support**: Windows and macOS compatibility testing
- **Accessibility**: Better error messages for beginners

### Future Ideas
- **GUI Application**: Desktop app for non-developers
- **Plugin System**: Support for custom preprocessing/postprocessing

## ⚡ Development Setup

### Prerequisites
- Python 3.9+
- Git
- (Optional) CUDA-compatible GPU for faster local processing

### Full Development Setup
```bash
# Clone repository
git clone https://github.com/withoutbg/withoutbg.git
cd withoutbg

# Install uv (if you don't have it yet)
# Download from: https://astral.sh/uv

# Install package in development mode (using uv - recommended)
uv sync --extra dev

# Or with pip (create venv first)
python -m venv venv
source venv/bin/activate
pip install -e ".[dev]"

# Install pre-commit hooks
pre-commit install

# Run tests to verify setup
pytest

# Check code quality
black --check src/ tests/
ruff check src/ tests/
mypy src/
```

### IDE Configuration

#### VS Code
Install the following extensions:
- Python
- Black Formatter
- Ruff
- Pylance

Add to `.vscode/settings.json`:
```json
{
    "python.defaultInterpreterPath": "./venv/bin/python",
    "python.formatting.provider": "black",
    "python.linting.enabled": true,
    "python.linting.ruffEnabled": true,
    "python.typeChecking": "strict"
}
```

## 🏷️ Release Process

### Version Numbering
We use [Semantic Versioning](https://semver.org/):
- `MAJOR.MINOR.PATCH`
- Major: Breaking changes
- Minor: New features (backward compatible)
- Patch: Bug fixes

### Release Checklist
1. Update version in `pyproject.toml`
2. Update `CHANGELOG.md`
3. Create git tag: `git tag v1.2.3`
4. Push tag: `git push origin v1.2.3`
5. GitHub Actions will automatically build and publish to PyPI

## 📄 License

By contributing to withoutbg, you agree that your contributions will be licensed under the Apache License 2.0.

## 🙏 Recognition

Contributors will be recognized in:
- `CONTRIBUTORS.md` file
- GitHub contributors list
- Release notes for significant contributions

## ❓ Questions?

- **General Questions**: [GitHub Discussions](https://github.com/withoutbg/withoutbg/discussions)
- **Technical Issues**: [GitHub Issues](https://github.com/withoutbg/withoutbg/issues)
- **Security Concerns**: security@withoutbg.com
- **Other**: contact@withoutbg.com

Thank you for contributing to withoutbg! 🎭