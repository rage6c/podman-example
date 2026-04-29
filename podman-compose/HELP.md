# Getting Started

### Start all services

Run the stack from the `podman-compose` folder:

```powershell
podman compose up --build
```

If `podman` is not on `PATH` in Windows, use:

```powershell
& 'C:\Program Files\RedHat\Podman\podman.exe' compose up --build
```

### Exposed ports

- `ngix-proxy`: `8080:8080`
- `image-registry`: `5000:5000`

### Routed endpoints

- `http://localhost:8080/spring-service/hello`
- `http://localhost:8080/python-service/hello`
- `http://localhost:8080/quarkus-service/hello`

### Registry endpoint

- `http://localhost:5000/v2/_catalog`
