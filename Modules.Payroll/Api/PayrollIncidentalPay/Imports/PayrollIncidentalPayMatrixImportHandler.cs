using Shared;

namespace Modules.Payroll.Api.PayrollIncidentalPay.Imports;

public class PayrollIncidentalPayMatrixImportHandler
{
    public PayrollIncidentalPayMatrixImportHandler(
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
