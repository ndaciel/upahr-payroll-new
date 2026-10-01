using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollProcessPersonnelTaxRates")]
[ViewTable("PayrollProcessPersonnelTaxRates")]
public class PayrollProcessPersonnelTaxRates
{
    public string ProcessId { get; set; } = null!;
    public string PersonnelId { get; set; } = null!;
    public int? Bracket { get; set; }
    public string? Label { get; set; }
    public decimal? TaxableAmount { get; set; }
    public double? Rate { get; set; }
    public decimal? TaxAmount { get; set; }
}
