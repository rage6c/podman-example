# podman-example

This repository contains sample services, a reverse proxy, and a private image registry that can be built and run with Podman.

Windows note: on this machine Podman is installed at `C:\Program Files\RedHat\Podman\podman.exe` but is not on `PATH`. If `podman` is not recognized, use `& 'C:\Program Files\RedHat\Podman\podman.exe' ...`.

## Folder structure

```text
podman-example/
|-- BUILD_IMAGES.md
|-- CREATE_VOLUME.md
|-- dotnet-service/
|-- image-registry/
|-- ngix-proxy/
|-- podman-compose/
|-- python-service/
|-- quarkus-native-service/
|-- spring-service/
`-- README.md
```

## Services

### `spring-service`

- Stack: Spring Boot
- Hello endpoint: `GET /hello`
- Health endpoint: `GET /actuator/health`

Local run:

```powershell
cd spring-service
.\mvnw.cmd test
.\mvnw.cmd spring-boot:run
```

Podman:

```powershell
cd spring-service
podman build -t localhost/spring-service:latest .
podman run --rm -p 8080:8080 localhost/spring-service:latest
```

### `python-service`

- Stack: Python 3.12, FastAPI, `pytoml`
- Hello endpoint: `GET /hello`
- Health endpoint: `GET /health`

Local run:

```powershell
cd python-service
py -3.12 -m pip install -e .[test]
py -3.12 -m pytest
py -3.12 -m uvicorn app.main:app --host 0.0.0.0 --port 8080
```

Podman:

```powershell
cd python-service
podman build -t localhost/python-service:latest .
podman run --rm -p 8080:8080 localhost/python-service:latest
```

### `dotnet-service`

- Stack: .NET 10, ASP.NET Core minimal API
- Hello endpoint: `GET /hello`
- Health endpoint: `GET /health`

Local run:

```powershell
cd dotnet-service
dotnet test dotnet-service.slnx
dotnet run
```

Podman:

```powershell
cd dotnet-service
podman build -t localhost/dotnet-service:latest .
podman run --rm -p 8080:8080 localhost/dotnet-service:latest
```

### `quarkus-native-service`

- Stack: Quarkus native-friendly REST service
- Hello endpoint: `GET /hello`
- Health endpoint: `GET /q/health`

Local run:

```powershell
cd quarkus-native-service
.\mvnw.cmd test
.\mvnw.cmd quarkus:dev
```

Native build:

```powershell
cd quarkus-native-service
.\mvnw.cmd package -Dnative "-Dquarkus.native.container-build=true"
```

Podman:

```powershell
cd quarkus-native-service
podman build -t localhost/quarkus-native-service:latest .
podman run --rm -p 8080:8080 localhost/quarkus-native-service:latest
```

### `ngix-proxy`

- Stack: Nginx reverse proxy
- Proxies:
  - `/spring-service` -> `spring-service:8080`
  - `/python-service` -> `python-service:8080`
  - `/quarkus-service` -> `quarkus-native-service:8080`

Podman:

```powershell
cd ngix-proxy
podman build -t localhost/ngix-proxy:latest .
podman run --rm -p 8080:8080 localhost/ngix-proxy:latest
```

### `image-registry`

- Stack: Docker distribution registry
- Catalog endpoint: `GET /v2/_catalog`
- Purpose: expose selected local images to external Nexus after sync

Podman:

```powershell
cd image-registry
podman build -t localhost/image-registry:latest .
podman run --rm -p 5000:5000 localhost/image-registry:latest
```

## Default ports

- `spring-service`: `8080`
- `python-service`: `8080`
- `dotnet-service`: `8080` in container, `5000` by default with `dotnet run`
- `quarkus-native-service`: `8080`
- `ngix-proxy`: `8080`
- `image-registry`: `5000`

## Build images one by one

Use `BUILD_IMAGES.md` for the full Windows-friendly build sequence.

## Run the full stack

Install a compose provider first if needed:

```powershell
C:\Users\Kenshin\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe -m pip install --user podman-compose
```

Start all services with Podman Compose:

```powershell
cd podman-compose
podman compose up --build
```

Windows fallback:

```powershell
cd podman-compose
& 'C:\Program Files\RedHat\Podman\podman.exe' compose up --build
```

This starts:

- `spring-service`
- `python-service`
- `dotnet-service`
- `quarkus-native-service`
- `ngix-proxy`
- `image-registry`

Exposed endpoints:

- `http://localhost:8080/spring-service/hello`
- `http://localhost:8080/python-service/hello`
- `http://localhost:8080/quarkus-service/hello`
- `http://localhost:5000/v2/_catalog`
- `dotnet-service` runs in the stack but is not exposed through `ngix-proxy`

## Sync local images into the registry

Running the registry does not automatically publish your local images into it. Sync them with:

```powershell
cd image-registry
.\sync-local-images.ps1 -RegistryHost localhost -RegistryPort 5000 -Namespace local
```

After sync, the registry catalog contains repositories like:

- `local/spring-service`
- `local/python-service`
- `local/dotnet-service`
- `local/quarkus-native-service`
- `local/ngix-proxy`
- `local/image-registry`

## Shared logs volume

The compose stack mounts a shared named volume at `/logs` for every service.

Create the volumes manually if you want them ahead of time:

```powershell
podman volume create logs
podman volume create registry-data
```

With `podman compose`, the actual volume names are usually prefixed:

- `podman-compose_logs`
- `podman-compose_registry-data`

Windows path to the logs volume data:

- `\\wsl$\podman-machine-default\home\user\.local\share\containers\storage\volumes\podman-compose_logs\_data`

Log files:

- `\\wsl$\podman-machine-default\home\user\.local\share\containers\storage\volumes\podman-compose_logs\_data\spring-service\spring-service.log`
- `\\wsl$\podman-machine-default\home\user\.local\share\containers\storage\volumes\podman-compose_logs\_data\python-service\python-service.log`
- `\\wsl$\podman-machine-default\home\user\.local\share\containers\storage\volumes\podman-compose_logs\_data\dotnet-service\dotnet-service.log`
- `\\wsl$\podman-machine-default\home\user\.local\share\containers\storage\volumes\podman-compose_logs\_data\quarkus-native-service\quarkus-native-service.log`
- `\\wsl$\podman-machine-default\home\user\.local\share\containers\storage\volumes\podman-compose_logs\_data\ngix-proxy\ngix-proxy.log`
- `\\wsl$\podman-machine-default\home\user\.local\share\containers\storage\volumes\podman-compose_logs\_data\image-registry\image-registry.log`

## Notes

- Each service folder has its own `HELP.md` with service-specific commands.
- `CREATE_VOLUME.md` documents manual volume creation.
- `BUILD_IMAGES.md` documents one-by-one image builds.
