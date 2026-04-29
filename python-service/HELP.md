# Getting Started

### Run locally

Install the dependencies:

```powershell
py -3.12 -m pip install -e .[test]
```

Start the FastAPI application from the `python-service` folder:

```powershell
py -3.12 -m uvicorn app.main:app --host 0.0.0.0 --port 8080
```

Test the sample endpoint:

```powershell
curl http://localhost:8080/hello
```

Test the health endpoint:

```powershell
curl http://localhost:8080/health
```

Run the tests:

```powershell
py -3.12 -m pytest
```

### Build and run with Podman

Build the FastAPI image from the `python-service` folder:

```powershell
podman build -t python-service .
```

Run the container and publish the application on port `8080`:

```powershell
podman run --rm -p 8080:8080 python-service
```

Test the sample endpoint:

```powershell
curl http://localhost:8080/hello
```

Test the health endpoint:

```powershell
curl http://localhost:8080/health
```
