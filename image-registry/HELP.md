# Getting Started

This folder contains a private container registry that can expose your locally built images to an external Nexus instance.

Windows note: if `podman` is not recognized, use `& 'C:\Program Files\RedHat\Podman\podman.exe' ...`.

### Build the registry image

```powershell
cd image-registry
podman build -t image-registry .
```

### Run the registry

```powershell
cd image-registry
New-Item -ItemType Directory -Force data | Out-Null
podman run --rm -d --name image-registry -p 5000:5000 -v "${PWD}\\data:/var/lib/registry" image-registry
```

The registry will be available at:

```text
http://<your-host>:5000
```

### Sync all local Podman images into the registry

```powershell
cd image-registry
.\sync-local-images.ps1 -RegistryHost localhost -RegistryPort 5000 -Namespace local
```

Images will be pushed into repositories like:

```text
localhost:5000/local/spring-service:latest
localhost:5000/local/python-service:latest
```

### Verify the registry catalog

```powershell
curl http://localhost:5000/v2/_catalog
```

### Nexus integration

Point Nexus at this registry endpoint so it can pull mirrored images:

```text
http://<your-host>:5000
```

If Nexus runs on a different machine, make sure:

- port `5000` is reachable from Nexus
- the Podman host firewall allows inbound access
- Nexus is allowed to use an HTTP registry, or you place TLS in front of this service
