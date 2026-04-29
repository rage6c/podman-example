namespace DotnetService;

public partial class Program
{
    private const string LogPath = "/logs/dotnet-service/dotnet-service.log";

    public static void Main(string[] args)
    {
        Directory.CreateDirectory(Path.GetDirectoryName(LogPath)!);
        LogMessage("dotnet-service starting");

        var builder = WebApplication.CreateBuilder(args);
        builder.Services.AddHealthChecks();

        var app = builder.Build();

        app.Use(async (context, next) =>
        {
            await next();
            LogMessage($"{context.Request.Method} {context.Request.Path} {context.Response.StatusCode}");
        });

        app.MapGet("/hello", () => Results.Ok(new HelloResponse("This a dotnet service")));
        app.MapHealthChecks("/health");

        app.Run();
    }

    private static void LogMessage(string message)
    {
        File.AppendAllText(LogPath, $"{DateTimeOffset.UtcNow:O} {message}{Environment.NewLine}");
    }

    private sealed record HelloResponse(string Result);
}
