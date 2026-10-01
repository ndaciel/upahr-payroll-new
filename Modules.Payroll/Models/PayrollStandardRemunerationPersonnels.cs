using System;
using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[ViewTable("vw_PayrollStandardRemunerationPersonnels")]
public class PayrollStandardRemunerationPersonnels
{
    [ExplicitKey]
    public string Id { get; set; } = null!;
    public string? Label { get; set; }
    public string? ComponentId { get; set; }
    public string? TypeId { get; set; }
    public string? ProcessTypeId { get; set; }
    public string? FormulaTypeId { get; set; }
    public string? VariableFormTypeId { get; set; }
    public string? Formula { get; set; }
    public decimal? Amount { get; set; }
    public string? Notes { get; set; }
    public bool? AppliedToAll { get; set; }
    public string? Status { get; set; }
    public DateTime? EffectiveDate { get; set; }
    public DateTime? ExpiredDate { get; set; }
    public int? CalculationOrder { get; set; }
    public DateTime? InsertStamp { get; set; }
    public string? InsertedBy { get; set; }
    public DateTime? UpdateStamp { get; set; }
    public string? UpdatedBy { get; set; }
    public string? LinkedRemunerationId { get; set; }
    public bool? LinkRemuneration { get; set; }
    public bool? Prorate { get; set; }
    public string? CurrencyId { get; set; }
    public bool? DateContext { get; set; }
    public string? DateContextMethod { get; set; }
    public bool? RecordPerVariableForm { get; set; }
    public string? PersonnelId { get; set; }
    public string? ComponentLabel { get; set; }
    public string? FormulaTypeLabel { get; set; }
    public string? ProcessTypeLabel { get; set; }
    public string? ProfilePictureUrl { get; set; }
    public DateTime? JoinedDate { get; set; }
    public string? LinkedRemunerationLabel { get; set; }
}
