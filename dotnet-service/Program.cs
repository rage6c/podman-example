namespace DotnetService;

public partial class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);
        builder.Services.AddHealthChecks();

        var app = builder.Build();

        app.MapGet("/hello", () => Results.Ok(new HelloResponse("This a dotnet service")));
        app.MapHealthChecks("/health");

        app.Run();
    }

    private sealed record HelloResponse(string Result);
}
