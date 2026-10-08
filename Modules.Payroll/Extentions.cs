using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using PajakExpress.Services;

namespace Modules.Payroll
{
    public static class Extensions
    {
        public static IServiceCollection AddModulePayroll(
            this IServiceCollection services,
            IConfiguration? configuration = null)
        {
            if (configuration != null)
            {
                services.AddPajakExpressClient(options =>
                {
                    options.BaseUrl = configuration["PajakExpress:BaseUrl"];
                    options.CalculationBaseUrl = configuration["PajakExpress:CalculationBaseUrl"] ?? "https://restdev.pajakexpress.com:9122";
                    options.Email = configuration["PajakExpress:UserName"];
                    options.Password = configuration["PajakExpress:Password"];
                });
            }

            // register service payroll
            return services;
        }

        public static IApplicationBuilder UseModulePayroll(this IApplicationBuilder app)
        {
            return app;
        }
    }
}

namespace Modules.Payroll.Reporting.IMIP
{
    public static class Extensions
    {
    }
}