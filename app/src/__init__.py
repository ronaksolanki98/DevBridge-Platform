"""App package entrypoints."""

from .main import app  # expose FastAPI instance for tests and UVicorn

__all__ = ["app"]
