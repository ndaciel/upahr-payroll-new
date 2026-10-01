using System;
using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollProcesses")]
[ViewTable("vw_PayrollProcesses")]
public class PayrollProcesses
{
    [ExplicitKey]
    public string Id { get; set; } = null!;
    public string GroupId { get; set; } = null!;
    public string ProcessTypeId { get; set; } = null!;
    public string PeriodId { get; set; } = null!;
    public DateTime PayDate { get; set; }
    public int? AffectedPersonnelCount { get; set; }
    public decimal? GrossAmount { get; set; }
    public decimal? DeductionAmount { get; set; }
    public decimal? TaxAmount { get; set; }
    public decimal? THPAmount { get; set; }
    public bool? SkipZeroAmount { get; set; }
    public string Status { get; set; } = null!;
    public DateTime? PostDate { get; set; }
    public bool? IsProcessing { get; set; }
    public DateTime? ProcessingStartedAt { get; set; }
    public int? ProcessingDone { get; set; }
    public int? ProcessingTotal { get; set; }
    public DateTime? ProcessingEstimatedFinish { get; set; }
    public string? ProcessingErrorMessage { get; set; }
    public DateTime InsertStamp { get; set; }
    public string InsertedBy { get; set; } = null!;
    public DateTime UpdateStamp { get; set; }
    public string UpdatedBy { get; set; } = null!;
    public string? PayrollGroupLabel { get; set; }
    public string? ProcessTypeLabel { get; set; }
    public string? PeriodLabel { get; set; }
}
