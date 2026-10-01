using System;
using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollProcessPersonnels")]
[ViewTable("vw_PayrollProcessPersonnels")]
public class PayrollProcessPersonnels
{
    [ExplicitKey]
    public string ProcessId { get; set; } = null!;
    public string PersonnelId { get; set; } = null!;
    public string? WorkLocationId { get; set; }
    public string? OrganizationId { get; set; }
    public string? JobTitleId { get; set; }
    public string? JobGradeId { get; set; }
    public string? JobPositionId { get; set; }
    public string? EmploymentStatusId { get; set; }
    public string? PayrollTaxId { get; set; }
    public string? PayrollBankId { get; set; }
    public string? PayrollBankAccountNumber { get; set; }
    public string? PayrollBankAccountHolderName { get; set; }
    public string? PayrollTaxStatusId { get; set; }
    public decimal? TotalTakeHomePayAllowanceAmount { get; set; }
    public decimal? TotalTakeHomePayDeductionAmount { get; set; }
    public decimal? OtherProcessTaxableAllowanceAmount { get; set; }
    public decimal? OtherProcessTaxableDeductionAmount { get; set; }
    public decimal? CurrentTaxableAlowanceAmount { get; set; }
    public decimal? CurrentTaxableDeductionAmount { get; set; }
    public bool? Annualized { get; set; }
    public decimal? UpToLastPeriodTaxableAllowanceAmount { get; set; }
    public decimal? UpToLastPeriodTaxableDeductionAmount { get; set; }
    public decimal? OtherTaxableDeductionAmount { get; set; }
    public decimal? LastNettTaxableIncome { get; set; }
    public decimal? LastPaidTaxIncome { get; set; }
    public decimal? NonTaxableIncome { get; set; }
    public decimal? TaxableIncome { get; set; }
    public decimal? PayableTaxAmount { get; set; }
    public decimal? PaidTaxAmount { get; set; }
    public decimal? TaxAmount { get; set; }
    public decimal? TakeHomePayAmount { get; set; }
    public string? Status { get; set; }
    public DateTime? InsertStamp { get; set; }
    public string? InsertedBy { get; set; }
    public DateTime? UpdateStamp { get; set; }
    public string? UpdatedBy { get; set; }
    public string? WorkLocationLabel { get; set; }
    public string? OrganizationLabel { get; set; }
    public string? JobTitleLabel { get; set; }
    public string? JobPositionLabel { get; set; }
    public string? JobGradeLabel { get; set; }
    public string? EmployeeNumber { get; set; }
    public string? PersonnelName { get; set; }
    public string? ProfilePictureUrl { get; set; }
    public string? EmploymentStatusLabel { get; set; }
    public string? PayrollTaxStatusLabel { get; set; }
    public string? PayrollBankLabel { get; set; }
    public string? ProcessLabel { get; set; }
    public DateTime? PayDate { get; set; }
    public string? PeriodId { get; set; }
    public string? GroupId { get; set; }
    public string? GroupLabel { get; set; }
    public string? ProcessStatus { get; set; }
    public string? ProcessTypeId { get; set; }
    public int? Year { get; set; }
    public int? Month { get; set; }
    public int? Week { get; set; }
    public bool? IsLocked { get; set; }
}
