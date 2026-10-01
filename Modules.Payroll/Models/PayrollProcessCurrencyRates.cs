using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollProcessCurrencyRates")]
[ViewTable("vw_PayrollProcessCurrencyRates")]
public class PayrollProcessCurrencyRates
{
    public string ProcessId { get; set; } = null!;
    public string CurrencyId { get; set; } = null!;
    public decimal? Rate { get; set; }
    public string? CurrencyLabel { get; set; }
}
