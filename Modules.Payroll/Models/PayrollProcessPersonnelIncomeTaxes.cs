using System;
using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollProcessPersonnelIncomeTaxes")]
[ViewTable("vw_PayrollProcessPersonnelIncomeTaxes")]
public class PayrollProcessPersonnelIncomeTaxes
{
    [ExplicitKey]
    public string Id { get; set; } = null!;
    public string ProcessId { get; set; } = null!;
    public string PersonnelId { get; set; } = null!;
    public string? TaxationMethodId { get; set; }
    public bool? Annualized { get; set; }
    public decimal? AllowanceAmount { get; set; }
    public decimal? DeductionAmount { get; set; }
    public decimal? PositionAllowanceAmount { get; set; }
    public decimal? GrossAmount { get; set; }
    public decimal? NonTaxableAmount { get; set; }
    public decimal? TaxableAmount { get; set; }
    public double? TaxRate1 { get; set; }
    public double? TaxRate2 { get; set; }
    public double? TaxRate3 { get; set; }
    public double? TaxRate4 { get; set; }
    public decimal? TaxAmount1 { get; set; }
    public decimal? TaxAmount2 { get; set; }
    public decimal? TaxAmount3 { get; set; }
    public decimal? TaxAmount4 { get; set; }
    public decimal? AnnualTaxAmount { get; set; }
    public decimal? AnnualTaxAmountRegular { get; set; }
    public decimal? PaidTaxAmount { get; set; }
    public decimal? PayableTaxAmount { get; set; }
    public decimal? ThisPeriodTaxAmount { get; set; }
    public int? SequenceOrder { get; set; }
    public string? TaxationMethodLabel { get; set; }
    public DateTime? PeriodStartDate { get; set; }
    public DateTime? PeriodEndDate { get; set; }
}
