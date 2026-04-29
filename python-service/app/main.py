from fastapi import FastAPI

from app.config import load_message


app = FastAPI(title="python-service")


@app.get("/hello")
def hello() -> dict[str, str]:
    return {"result": load_message()}


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}
