from fastapi.testclient import TestClient

from src import app as application


client = TestClient(application)


def test_health_endpoint():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "ok"


def test_info_endpoint_contains_meta():
    response = client.get("/info")
    payload = response.json()
    assert payload["service"] == "devops-bridge"
    assert payload["environment"] == "development"
