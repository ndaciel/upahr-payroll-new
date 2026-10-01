using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollProcessPersonnelIncomeTaxDetailComponents")]
[ViewTable("vw_PayrollProcessPersonnelIncomeTaxDetailComponents")]
public class PayrollProcessPersonnelIncomeTaxDetailComponents
{
    public string ProcessId { get; set; } = null!;
    public string PersonnelId { get; set; } = null!;
    public string ComponentId { get; set; } = null!;
    public string? TypeId { get; set; }
    public string? VariableId { get; set; }
    public bool? Annualized { get; set; }
    public string? TaxationMethodId { get; set; }
    public bool? Paid { get; set; }
    public bool? Taxable { get; set; }
    public decimal? ThisPeriodAmount { get; set; }
    public decimal? UpToLastPeriodAmount { get; set; }
    public decimal? ProjectedAmount { get; set; }
    public string? ComponentLabel { get; set; }
    public int? ComponentSequenceOrder { get; set; }
}
