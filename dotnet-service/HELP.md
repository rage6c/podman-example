# Getting Started

### Run locally

Run the application from the `dotnet-service` folder:

```powershell
dotnet run
```

Test the sample endpoint:

```powershell
curl http://localhost:5000/hello
```

Test the health endpoint:

```powershell
curl http://localhost:5000/health
```

Run the tests:

```powershell
dotnet test
```

### Build and run with Podman

Build the ASP.NET Core image from the `dotnet-service` folder:

```powershell
podman build -t dotnet-service .
```

Run the container and publish the application on port `8080`:

```powershell
podman run --rm -p 8080:8080 dotnet-service
```

Test the sample endpoint:

```powershell
curl http://localhost:8080/hello
```

Test the health endpoint:

```powershell
curl http://localhost:8080/health
```
