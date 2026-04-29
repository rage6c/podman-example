# Create Podman Volumes

This project uses a shared Podman volume named `logs` to store service log files under `/logs`.

## Create the logs volume

If `podman` is not on `PATH`, use the full executable path:

```powershell
& 'C:\Program Files\RedHat\Podman\podman.exe' volume create logs
```

If `podman` is already on `PATH`, you can run:

```powershell
podman volume create logs
```

## Verify the volume

```powershell
podman volume ls
```

You should see:

```text
logs
```

## Create the registry data volume

The image registry also uses a persistent volume for registry storage:

```powershell
podman volume create registry-data
```

## Create both volumes together

```powershell
podman volume create logs
podman volume create registry-data
```

## Notes

- In `podman compose`, named volumes may be created with a project prefix such as `podman-compose_logs`.
- The services write logs to:
  - `/logs/spring-service/spring-service.log`
  - `/logs/python-service/python-service.log`
  - `/logs/dotnet-service/dotnet-service.log`
  - `/logs/quarkus-native-service/quarkus-native-service.log`
  - `/logs/ngix-proxy/ngix-proxy.log`
  - `/logs/image-registry/image-registry.log`
