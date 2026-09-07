SELECT 
    fba.Id, fba.PersonnelId, fba.FieldBreakSchemeId, fba.EffectiveDate, fba.ExpectedExpiredDate, 
    fba.ExpiredDate, fba.Notes, fba.PreviousFieldBreakSchemeId, fba.Status, 
    fba.InsertStamp, fba.InsertedBy, fba.UpdateStamp, fba.UpdatedBy,
    p.Name AS PersonnelName,
    p.EmployeeNumber,
    p.WorkLocationId,
    p.OrganizationId,
    p.JobTitleId,
    p.JobGradeId,
    p.JobPositionId,
    p.EmploymentStatusId,
    p.PayrollGroupId,
    scheme.Label AS FieldBreakSchemeLabel,
    prevScheme.Label AS PreviousFieldBreakSchemeLabel
FROM dbo.FieldBreakAssignments fba
INNER JOIN dbo.Personnels p ON p.Id = fba.PersonnelId
INNER JOIN dbo.FieldBreakSchemes scheme ON scheme.Id = fba.FieldBreakSchemeId
LEFT JOIN dbo.FieldBreakSchemes prevScheme ON prevScheme.Id = fba.PreviousFieldBreakSchemeId
