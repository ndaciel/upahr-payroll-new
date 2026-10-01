using System;
using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollProcessPersonnelOvertimeDetails")]
[ViewTable("vw_PayrollProcessOvertimeDetails")]
public class PayrollProcessOvertimeDetails
{
    public string ProcessId { get; set; } = null!;
    public string PersonnelId { get; set; } = null!;
    public string OvertimeId { get; set; } = null!;
    public string? FormId { get; set; }
    public DateTime? OvertimeDate { get; set; }
    public TimeSpan? StartTime { get; set; }
    public TimeSpan? EndTime { get; set; }
    public double? MandatoryHours { get; set; }
    public double? OvertimeHours { get; set; }
    public double? NetActHours { get; set; }
    public double? CalculatedHours { get; set; }
    public double? CalculatedAmount { get; set; }
    public string? OvertimeReasonLabel { get; set; }
}
