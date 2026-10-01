using Core.Base;

namespace Modules.Payroll;

[ViewTable("vw_PayrollStandardRemunerationRequirements")]
public class PayrollStandardRemunerationRequirements
{
    public string? PayrollStandardRemunerationId { get; set; }
    public string? RequirementId { get; set; }
    public string? RequirementCategory { get; set; }
    public string? StandardRemunerationId { get; set; }
    public double? RangeMin { get; set; }
    public double? RangeMax { get; set; }
}
