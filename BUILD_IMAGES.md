# Build Images One by One

This guide shows how to build each image individually with Podman from this repository.

## Prerequisites

- Podman is installed at `C:\Program Files\RedHat\Podman\podman.exe`
- If `podman` is not on `PATH`, use the full executable path
- On this machine, Podman also requires a working backend before builds will run

If needed, initialize the backend first:

```powershell
wsl.exe --install
& 'C:\Program Files\RedHat\Podman\podman.exe' machine init
& 'C:\Program Files\RedHat\Podman\podman.exe' machine start
```

## Verify Podman

```powershell
& 'C:\Program Files\RedHat\Podman\podman.exe' info
```

## Build `spring-service`

```powershell
cd C:\Users\Kenshin\work\podman-example\spring-service
& 'C:\Program Files\RedHat\Podman\podman.exe' build -t spring-service .
```

## Build `python-service`

```powershell
cd C:\Users\Kenshin\work\podman-example\python-service
& 'C:\Program Files\RedHat\Podman\podman.exe' build -t python-service .
```

## Build `dotnet-service`

```powershell
cd C:\Users\Kenshin\work\podman-example\dotnet-service
& 'C:\Program Files\RedHat\Podman\podman.exe' build -t dotnet-service .
```

## Build `quarkus-native-service`

```powershell
cd C:\Users\Kenshin\work\podman-example\quarkus-native-service
& 'C:\Program Files\RedHat\Podman\podman.exe' build -t quarkus-native-service .
```

## Build `ngix-proxy`

```powershell
cd C:\Users\Kenshin\work\podman-example\ngix-proxy
& 'C:\Program Files\RedHat\Podman\podman.exe' build -t ngix-proxy .
```

## Build `image-registry`

```powershell
cd C:\Users\Kenshin\work\podman-example\image-registry
& 'C:\Program Files\RedHat\Podman\podman.exe' build -t image-registry .
```

## List built images

```powershell
& 'C:\Program Files\RedHat\Podman\podman.exe' images
```
