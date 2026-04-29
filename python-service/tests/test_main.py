from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_hello_returns_expected_payload() -> None:
    response = client.get("/hello")

    assert response.status_code == 200
    assert response.json() == {"result": "This a python service"}


def test_health_returns_ok() -> None:
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"status": "ok"}
