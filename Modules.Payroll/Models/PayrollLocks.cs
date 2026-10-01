using System;
using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollLocks")]
[ViewTable("vw_PayrollLocks")]
public class PayrollLocks
{
    [ExplicitKey]
    public string Id { get; set; } = null!;
    public string GroupId { get; set; } = null!;
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public string Status { get; set; } = null!;
    public string? Notes { get; set; }
    public DateTime InsertStamp { get; set; }
    public string InsertedBy { get; set; } = null!;
    public DateTime UpdateStamp { get; set; }
    public string UpdatedBy { get; set; } = null!;
    public string? GroupLabel { get; set; }
}
