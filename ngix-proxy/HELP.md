# Getting Started

### Routes

- `/spring-service` -> `spring-service:8080`
- `/python-service` -> `python-service:8080`
- `/quarkus-service` -> `quarkus-native-service:8080`

### Build the proxy image

```powershell
cd ngix-proxy
podman build -t ngix-proxy .
```

### Run the proxy

Run it on the same Podman network as the backend services so the container names resolve:

```powershell
podman run --rm -p 8080:8080 --network <your-network> --name ngix-proxy ngix-proxy
```

### Test the routes

```powershell
curl http://localhost:8080/spring-service/hello
curl http://localhost:8080/python-service/hello
curl http://localhost:8080/quarkus-service/hello
```
