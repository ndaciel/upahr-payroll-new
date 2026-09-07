using Microsoft.Extensions.DependencyInjection;

namespace Modules.Payroll
{
    public static class Extensions
    {
        public static IServiceCollection AddModulePayroll(
            this IServiceCollection services)
        {
            // register service payroll
            return services;
        }
    }
}
