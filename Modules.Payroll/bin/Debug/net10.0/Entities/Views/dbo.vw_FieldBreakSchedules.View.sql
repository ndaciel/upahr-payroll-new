SELECT 
    fbs.Id, fbs.PersonnelId, fbs.FieldBreakAssignmentId, fbs.StartDate, fbs.EndDate, 
    fbs.Label, fbs.ScheduleType, fbs.Status,
    p.Name AS PersonnelName,
    p.EmployeeNumber,
    p.WorkLocationId,
    p.OrganizationId,
    p.JobTitleId,
    p.JobGradeId,
    p.JobPositionId,
    p.EmploymentStatusId,
    p.PayrollGroupId,
    scheme.Label AS FieldBreakSchemeLabel
FROM dbo.FieldBreakSchedules fbs
INNER JOIN dbo.Personnels p ON p.Id = fbs.PersonnelId
INNER JOIN dbo.FieldBreakAssignments fba ON fba.Id = fbs.FieldBreakAssignmentId
INNER JOIN dbo.FieldBreakSchemes scheme ON scheme.Id = fba.FieldBreakSchemeId
