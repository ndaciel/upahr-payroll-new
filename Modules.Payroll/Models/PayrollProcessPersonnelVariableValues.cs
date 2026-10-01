using Core.Base;

namespace Modules.Payroll;

[ViewTable("vw_PayrollProcessPersonnelVariableValues")]
public class PayrollProcessPersonnelVariableValues
{
    public string ProcessId { get; set; } = null!;
    public string PersonnelId { get; set; } = null!;
    public string? Label { get; set; }
    public string? ReferenceType { get; set; }
    public double? Value { get; set; }
}
