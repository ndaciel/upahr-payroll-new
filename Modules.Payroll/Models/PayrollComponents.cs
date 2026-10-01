using System;
using System.ComponentModel.DataAnnotations;
using Core.Base;
using Dapper.Contrib.Extensions;

namespace Modules.Payroll;

[Table("PayrollComponents")]
[ViewTable("vw_PayrollComponents")]
public class PayrollComponents
{
    [ExplicitKey]
    public string Id { get; set; } = null!;
    public string TypeId { get; set; } = null!;
    public string Label { get; set; } = null!;
    public string? VariableId { get; set; }
    public string? FormulationCode { get; set; }
    public bool Annualized { get; set; }
    public bool? Taxable { get; set; }
    public string? TaxationMethodId { get; set; }
    public bool Paid { get; set; }
    public int? SequenceOrder { get; set; }
    public string Status { get; set; } = null!;
    public DateTime InsertStamp { get; set; }
    public string InsertedBy { get; set; } = null!;
    public DateTime UpdateStamp { get; set; }
    public string UpdatedBy { get; set; } = null!;
    public string? TaxStatementGroup { get; set; }
    public string? TaxStatementGroupLabel { get; set; }
    public string? TypeLabel { get; set; }
    public string? TaxationMethodLabel { get; set; }
    public string? VariableLabel { get; set; }
    public string? VariableCode { get; set; }
}
