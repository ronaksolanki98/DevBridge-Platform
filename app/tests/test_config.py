import os
from src.config import load_config, ServiceConfig


def test_load_config_uses_defaults(monkeypatch):
    monkeypatch.delenv("SERVICE_NAME", raising=False)
    monkeypatch.delenv("SERVICE_VERSION", raising=False)
    monkeypatch.delenv("SERVICE_ENV", raising=False)
    monkeypatch.delenv("SERVICE_PORT", raising=False)

    result: ServiceConfig = load_config()

    assert result.service_name == "devops-bridge"
    assert result.service_version == "0.1.0"
    assert result.environment == "development"
    assert result.port == 8000


def test_load_config_overrides(monkeypatch):
    monkeypatch.setenv("SERVICE_NAME", "infra-service")
    monkeypatch.setenv("SERVICE_VERSION", "1.0.1")
    monkeypatch.setenv("SERVICE_ENV", "staging")
    monkeypatch.setenv("SERVICE_PORT", "9090")

    result = load_config()

    assert result.service_name == "infra-service"
    assert result.service_version == "1.0.1"
    assert result.environment == "staging"
    assert result.port == 9090
