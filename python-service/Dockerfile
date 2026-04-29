FROM registry.access.redhat.com/ubi9/python-312-minimal AS builder

WORKDIR /opt/app-root/src

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV VIRTUAL_ENV=/opt/app-root/venv
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

COPY pyproject.toml pyproject.toml
COPY app/ app/
COPY config/ config/

RUN python -m venv "${VIRTUAL_ENV}" \
    && pip install --upgrade pip \
    && pip install .

FROM registry.access.redhat.com/ubi9/python-312-minimal

WORKDIR /opt/app-root/src

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV VIRTUAL_ENV=/opt/app-root/venv
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

COPY --from=builder /opt/app-root/venv /opt/app-root/venv
COPY app/ app/
COPY config/ config/

EXPOSE 8080

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
