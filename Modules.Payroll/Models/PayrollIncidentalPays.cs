using System;
using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollIncidentalPays")]
[ViewTable("vw_PayrollIncidentalPays")]
public class PayrollIncidentalPays
{
    [ExplicitKey]
    public string Id { get; set; } = null!;
    public string? RecordNumber { get; set; }
    public string PersonnelId { get; set; } = null!;
    public string? WorkLocationId { get; set; }
    public string? OrganizationId { get; set; }
    public string? JobTitleId { get; set; }
    public string? JobGradeId { get; set; }
    public string? JobPositionId { get; set; }
    public string? EmploymentStatusId { get; set; }
    public string? ProcessTypeId { get; set; }
    public string ComponentId { get; set; } = null!;
    public decimal Amount { get; set; }
    public DateTime PayDate { get; set; }
    public bool? Negate { get; set; }
    public int? CalculationOrder { get; set; }
    public string? Notes { get; set; }
    public string? ProcessId { get; set; }
    public string Status { get; set; } = null!;
    public DateTime InsertStamp { get; set; }
    public string InsertedBy { get; set; } = null!;
    public DateTime UpdateStamp { get; set; }
    public string UpdatedBy { get; set; } = null!;
    public string? EmployeeNumber { get; set; }
    public string? EmployeeName { get; set; }
    public string? ProfilePictureUrl { get; set; }
    public string? ComponentLabel { get; set; }
    public string? ProcessTypeLabel { get; set; }
    public string? PayrollGroupId { get; set; }
    public string? WorkLocationLabel { get; set; }
    public string? OrganizationLabel { get; set; }
    public string? JobTitleLabel { get; set; }
    public string? JobPositionLabel { get; set; }
    public string? JobGradeLabel { get; set; }
    public string? ComponentTypeLabel { get; set; }
    public string? CurrencyId { get; set; }
    public string? CurrencyLabel { get; set; }
}
