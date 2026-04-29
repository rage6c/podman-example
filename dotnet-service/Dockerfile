FROM registry.access.redhat.com/ubi9/dotnet-100 AS builder

USER 0

WORKDIR /src

RUN chown 1001:0 /src

USER 1001

COPY DotnetService.csproj DotnetService.csproj
COPY Program.cs Program.cs
COPY appsettings.json appsettings.json
COPY appsettings.Development.json appsettings.Development.json
COPY Properties/ Properties/

RUN dotnet restore DotnetService.csproj
RUN dotnet publish DotnetService.csproj -c Release -o /src/publish /p:UseAppHost=false

FROM registry.access.redhat.com/ubi9/dotnet-100-aspnet

WORKDIR /app

COPY --from=builder /src/publish .

EXPOSE 8080

ENV ASPNETCORE_HTTP_PORTS=8080

ENTRYPOINT ["sh", "-c", "mkdir -p /logs/dotnet-service && exec dotnet DotnetService.dll"]
