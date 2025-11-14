# Root Makefile for withoutbg monorepo
# This orchestrates commands across the entire project

.PHONY: help install install-all install-python install-web test test-all test-python clean clean-all build build-all docker-up docker-down quality publish publish-test publish-check

# Default target
help:
	@echo "╔═══════════════════════════════════════════════════════════╗"
	@echo "║         WithoutBG Monorepo - Available Commands           ║"
	@echo "╚═══════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "📦 Installation:"
	@echo "  install-all         Install all components (Python + Web)"
	@echo "  install-python      Install Python package only"
	@echo "  install-web         Install web applications only"
	@echo ""
	@echo "🧪 Testing:"
	@echo "  test-all            Run all tests (Python package)"
	@echo "  test-python         Run Python package tests"
	@echo "  test-python-fast    Run fast Python tests"
	@echo "  test-coverage       Run tests with coverage report"
	@echo ""
	@echo "🔨 Building:"
	@echo "  build-all           Build all components"
	@echo "  build-python        Build Python package"
	@echo "  build-web           Build web applications"
	@echo ""
	@echo "🐳 Docker:"
	@echo "  docker-up           Start web application with Docker"
	@echo "  docker-down         Stop web application"
	@echo "  docker-logs         Show Docker logs"
	@echo "  docker-restart      Restart Docker services"
	@echo "  docker-clean        Clean Docker resources"
	@echo ""
	@echo "✨ Code Quality:"
	@echo "  quality             Run all quality checks (Python)"
	@echo "  lint-all            Run linters on all components"
	@echo "  lint-python         Run Python linter"
	@echo "  lint-web            Run web linters"
	@echo "  format              Format Python code"
	@echo "  fix                 Auto-fix Python issues"
	@echo ""
	@echo "🧹 Maintenance:"
	@echo "  clean-all           Clean all build artifacts"
	@echo "  clean-python        Clean Python artifacts"
	@echo "  clean-web           Clean web artifacts"
	@echo ""
	@echo "📦 Publishing (Python Package):"
	@echo "  publish-check       Check package before publishing"
	@echo "  publish-test        Publish to TestPyPI"
	@echo "  publish             Publish to PyPI (production)"
	@echo ""
	@echo "📋 Component-Specific Commands:"
	@echo "  make -C packages/python help    Show Python package commands"
	@echo "  make -C apps/web help           Show web application commands"
	@echo ""

# ============================================================================
# Installation Commands
# ============================================================================

install-all: install-python install-web
	@echo "✓ All components installed successfully!"

install-python:
	@echo "📦 Installing Python package..."
	$(MAKE) -C packages/python install

install-web:
	@echo "🌐 Installing web applications..."
	$(MAKE) -C apps/web install

# ============================================================================
# Testing Commands
# ============================================================================

test-all: test-python
	@echo "✓ All tests completed!"

test-python:
	@echo "🧪 Running Python package tests..."
	$(MAKE) -C packages/python test

test-python-fast:
	@echo "🧪 Running fast Python tests..."
	$(MAKE) -C packages/python test-fast

test-coverage:
	@echo "📊 Running tests with coverage..."
	$(MAKE) -C packages/python test-coverage

# ============================================================================
# Build Commands
# ============================================================================

build-all: build-python build-web
	@echo "✓ All components built successfully!"

build-python:
	@echo "🔨 Building Python package..."
	$(MAKE) -C packages/python build

build-web:
	@echo "🔨 Building web applications..."
	$(MAKE) -C apps/web build

# ============================================================================
# Docker Commands
# ============================================================================

docker-up:
	@echo "🐳 Starting web application with Docker..."
	$(MAKE) -C apps/web docker-up

docker-down:
	@echo "🐳 Stopping web application..."
	$(MAKE) -C apps/web docker-down

docker-logs:
	$(MAKE) -C apps/web docker-logs

docker-restart:
	@echo "🐳 Restarting Docker services..."
	$(MAKE) -C apps/web docker-restart

docker-clean:
	@echo "🐳 Cleaning Docker resources..."
	$(MAKE) -C apps/web docker-clean

# ============================================================================
# Code Quality Commands
# ============================================================================

quality:
	@echo "✨ Running quality checks..."
	$(MAKE) -C packages/python quality

lint-all: lint-python lint-web
	@echo "✓ All linting passed!"

lint-python:
	@echo "🔍 Linting Python package..."
	$(MAKE) -C packages/python lint

lint-web:
	@echo "🔍 Linting web applications..."
	$(MAKE) -C apps/web lint

format:
	@echo "✨ Formatting Python code..."
	$(MAKE) -C packages/python format

fix:
	@echo "🔧 Auto-fixing Python issues..."
	$(MAKE) -C packages/python fix

# ============================================================================
# Clean Commands
# ============================================================================

clean-all: clean-python clean-web
	@echo "✓ All artifacts cleaned!"

clean-python:
	@echo "🧹 Cleaning Python artifacts..."
	$(MAKE) -C packages/python clean

clean-web:
	@echo "🧹 Cleaning web artifacts..."
	$(MAKE) -C apps/web clean

# ============================================================================
# Development Workflows
# ============================================================================

dev-python:
	@echo "🚀 Running Python development workflow..."
	$(MAKE) -C packages/python dev

dev-web:
	@echo "🚀 Starting web development servers..."
	@echo "Note: This will show you how to start the servers"
	$(MAKE) -C apps/web dev

ci-python:
	@echo "🤖 Running Python CI pipeline..."
	$(MAKE) -C packages/python ci

# ============================================================================
# Version Management (Python Package)
# ============================================================================

version-show:
	@echo "📌 Current version:"
	$(MAKE) -C packages/python version-show

version-patch:
	@echo "⬆️  Bumping patch version..."
	$(MAKE) -C packages/python version-patch

version-minor:
	@echo "⬆️  Bumping minor version..."
	$(MAKE) -C packages/python version-minor

version-major:
	@echo "⬆️  Bumping major version..."
	$(MAKE) -C packages/python version-major

# ============================================================================
# Publishing Commands (Python Package)
# ============================================================================

publish-check:
	@echo "🔍 Checking package before publishing..."
	$(MAKE) -C packages/python publish-check

publish-test:
	@echo "📤 Publishing to TestPyPI..."
	$(MAKE) -C packages/python publish-test

publish:
	@echo "📤 Publishing to PyPI (production)..."
	$(MAKE) -C packages/python publish

# ============================================================================
# Quick Start Commands
# ============================================================================

setup: install-all
	@echo "✓ Project setup complete!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Run 'make docker-up' to start the web application"
	@echo "  2. Visit http://localhost:3000 for the frontend"
	@echo "  3. Visit http://localhost:8000/docs for the API docs"
	@echo "  4. Run 'make test-all' to verify everything works"

quickstart: setup test-all
	@echo "✓ Quickstart complete - your environment is ready!"