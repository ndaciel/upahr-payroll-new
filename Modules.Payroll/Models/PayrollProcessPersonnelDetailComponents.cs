using System;
using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollProcessPersonnelDetailComponents")]
[ViewTable("vw_PayrollProcessPersonnelDetailComponents")]
public class PayrollProcessPersonnelDetailComponents
{
    public string ProcessId { get; set; } = null!;
    public string PersonnelId { get; set; } = null!;
    public string ComponentId { get; set; } = null!;
    public string? TypeId { get; set; }
    public string? VariableId { get; set; }
    public string? TaxationMethodId { get; set; }
    public bool? Annualized { get; set; }
    public bool? Paid { get; set; }
    public bool? Taxable { get; set; }
    public double? Amount { get; set; }
    public string? ForeignCurrencyId { get; set; }
    public decimal? ForeignCurrencyAmount { get; set; }
    public string? ComponentLabel { get; set; }
    public int? SequenceOrder { get; set; }
    public string? WorkLocationLabel { get; set; }
    public string? OrganizationLabel { get; set; }
    public string? JobTitleLabel { get; set; }
    public string? JobPositionLabel { get; set; }
    public string? JobGradeLabel { get; set; }
    public string? EmployeeNumber { get; set; }
    public string? PersonnelName { get; set; }
    public string? ProfilePictureUrl { get; set; }
    public string? PersonnelPayrollGroupId { get; set; }
    public string? PeriodId { get; set; }
    public string? ProcessStatus { get; set; }
    public int? Year { get; set; }
    public int? Month { get; set; }
    public string? ProcessTypeLabel { get; set; }
    public DateTime? PayDate { get; set; }
    public string? GroupId { get; set; }
    public string? ForeignCurrencyLabel { get; set; }
}
