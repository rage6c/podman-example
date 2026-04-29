# Getting Started

### Run locally

Run the application in dev mode from the `quarkus-native-service` folder:

```powershell
.\mvnw.cmd quarkus:dev
```

Test the sample endpoint:

```powershell
curl http://localhost:8080/hello
```

Test the health endpoint:

```powershell
curl http://localhost:8080/q/health
```

Run the tests:

```powershell
.\mvnw.cmd test
```

### Build native executable

Build a native executable in a container:

```powershell
.\mvnw.cmd package -Dnative "-Dquarkus.native.container-build=true"
```

### Build and run with Podman

Build the native image container from the `quarkus-native-service` folder:

```powershell
podman build -f src/main/docker/Dockerfile.native -t quarkus-native-service .
```

Run the container and publish the application on port `8080`:

```powershell
podman run --rm -p 8080:8080 quarkus-native-service
```
