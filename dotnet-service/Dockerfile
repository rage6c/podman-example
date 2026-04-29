FROM registry.access.redhat.com/ubi9/dotnet-100 AS builder

WORKDIR /src

COPY DotnetService.csproj DotnetService.csproj
COPY Program.cs Program.cs
COPY appsettings.json appsettings.json
COPY appsettings.Development.json appsettings.Development.json
COPY Properties/ Properties/

RUN dotnet restore DotnetService.csproj
RUN dotnet publish DotnetService.csproj -c Release -o /app/publish /p:UseAppHost=false

FROM registry.access.redhat.com/ubi9/dotnet-100-aspnet

WORKDIR /app

COPY --from=builder /app/publish .

EXPOSE 8080

ENV ASPNETCORE_HTTP_PORTS=8080

ENTRYPOINT ["dotnet", "DotnetService.dll"]
