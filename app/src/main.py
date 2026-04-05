"""Simple FastAPI service exposing health and info endpoints."""
from datetime import datetime

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from .settings import get_settings


settings = get_settings()

app = FastAPI(
    title="DevOps Bridge",
    version=settings.service_version,
    description="Small API used to demonstrate a production-grade DevOps pipeline.",
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["GET"],
    allow_headers=["*"]
)


@app.get("/health")
def health_check():
    """Return a lightweight health payload."""
    return JSONResponse(
        {
            "status": "ok",
            "timestamp": datetime.utcnow().isoformat() + "Z",
            "service": settings.service_name,
            "environment": settings.environment,
        }
    )


@app.get("/info")
def service_info():
    """Return metadata published by the service."""
    return JSONResponse(
        {
            "service": settings.service_name,
            "version": settings.service_version,
            "environment": settings.environment,
            "started": datetime.utcnow().isoformat() + "Z",
        }
    )
