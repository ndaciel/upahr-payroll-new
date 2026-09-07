using Shared;

namespace Modules.Payroll.Api.PayrollRemuneration.Imports;

public class PayrollRemunerationImportHandler
{
    public PayrollRemunerationImportHandler(
        object db,
        object file,
        object user,
        object org,
        object scheme,
        object logger)
    {
    }

    public Task<BaseImportResult> ExecuteAsync(
        bool allowPartial,
        string? notes)
    {
        return Task.FromResult(new BaseImportResult());
    }
}