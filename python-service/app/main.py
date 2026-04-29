import logging
from pathlib import Path

from fastapi import FastAPI, Request

from app.config import load_message


LOG_PATH = Path("/logs/python-service/python-service.log")
LOG_PATH.parent.mkdir(parents=True, exist_ok=True)

logger = logging.getLogger("python-service")
logger.setLevel(logging.INFO)
logger.handlers.clear()
file_handler = logging.FileHandler(LOG_PATH, encoding="utf-8")
file_handler.setFormatter(logging.Formatter("%(asctime)s %(levelname)s %(message)s"))
logger.addHandler(file_handler)
logger.propagate = False

app = FastAPI(title="python-service")
logger.info("python-service started")


@app.middleware("http")
async def log_requests(request: Request, call_next):
    response = await call_next(request)
    logger.info("%s %s %s", request.method, request.url.path, response.status_code)
    return response


@app.get("/hello")
def hello() -> dict[str, str]:
    return {"result": load_message()}


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}
