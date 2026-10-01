using Core.Base;

namespace Modules.Payroll;

[ViewTable("vw_PayrollVariableSetItems")]
public class PayrollVariableSetItems
{
    public string VariableSetId { get; set; } = null!;
    public string VariableId { get; set; } = null!;
    public string? VariableLabel { get; set; }
}
