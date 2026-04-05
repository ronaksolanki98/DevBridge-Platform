"""Configuration helpers for the sample service."""
from dataclasses import dataclass
import os


@dataclass(frozen=True)
class ServiceConfig:
    service_name: str
    service_version: str
    environment: str
    port: int


def load_config() -> ServiceConfig:
    return ServiceConfig(
        service_name=os.getenv("SERVICE_NAME", "devops-bridge"),
        service_version=os.getenv("SERVICE_VERSION", "0.1.0"),
        environment=os.getenv("SERVICE_ENV", "development"),
        port=int(os.getenv("SERVICE_PORT", "8000")),
    )
