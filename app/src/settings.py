"""Central configuration backed by Pydantic settings."""
from functools import lru_cache
from pydantic import BaseSettings


class ServiceSettings(BaseSettings):
    service_name: str = "devops-bridge"
    service_version: str = "0.1.0"
    environment: str = "development"
    port: int = 8000
    log_level: str = "info"

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


@lru_cache()
def get_settings() -> ServiceSettings:
    return ServiceSettings()
