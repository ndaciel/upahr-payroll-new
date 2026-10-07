using Shared;

namespace Modules.Payroll.Api.PayrollRemuneration.Imports;

public class PayrollRemunerationImportHandler : IImportHandler
{
    public string? UserScopes { get; set; }
    public string? DataAccessScopes { get; set; }

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
        bool allowPartialImport = false,
        string? notes = null)
    {
        return Task.FromResult(new BaseImportResult());
    }
}