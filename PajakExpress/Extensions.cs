using Microsoft.Extensions.DependencyInjection;

namespace PajakExpress.Services;

public static class Extensions
{
    public static IServiceCollection AddPajakExpressClient(
        this IServiceCollection services,
        Action<PajakExpressOptions> options)
    {
        var config = new PajakExpressOptions();

        options(config);

        services.AddSingleton(config);

        return services;
    }
}

public class PajakExpressOptions
{
    public string? BaseUrl { get; set; }
    public string? CalculationBaseUrl { get; set; }
    public string? Email { get; set; }
    public string? Password { get; set; }
}