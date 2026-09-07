SELECT
    shiftRevision.Id,
    shiftRevision.RecordNumber,
    shiftRevision.PersonnelId,
    shiftRevision.ReasonId,
    shiftRevision.AttendanceDate,
    shiftRevision.OriginalShiftId,
    shiftRevision.ShiftId,
    shiftRevision.Notes,
    shiftRevision.Status,
    shiftRevision.InsertStamp,
    shiftRevision.InsertedBy,
    shiftRevision.UpdateStamp,
    shiftRevision.UpdatedBy,
    employee.EmployeeNumber,
    employee.Name AS PersonnelName,
    employee.ProfilePictureUrl,
    employee.PayrollGroupId,
    workLocation.Id AS WorkLocationId,
    organization.Id as OrganizationId,
    jobTitle.Id AS JobTitleId,
    jobPosition.Id AS JobPositionId,
    jobGrade.Id AS JobGradeId,
    employmentStatus.Id AS EmploymentStatusId,
    workLocation.Name AS WorkLocationLabel,
    organization.Name as OrganizationLabel,
    jobTitle.Name AS JobTitleLabel,
    jobPosition.Name AS JobPositionLabel,
    jobGrade.Name AS JobGradeLabel,
    employmentStatus.Name AS EmploymentStatusLabel,
    reason.Label AS ReasonLabel,
    originalShift.Label AS OriginalShiftLabel,
    newShift.Label AS ShiftLabel,
    payrollGroup.Label AS PayrollGroupLabel
FROM
    dbo.AttendanceShiftChanges AS shiftRevision
        INNER JOIN dbo.Personnels AS employee ON employee.Id = shiftRevision.PersonnelId
        INNER JOIN dbo.WorkLocations AS workLocation ON workLocation.Id = employee.WorkLocationId
        INNER JOIN dbo.Organizations AS organization ON organization.Id = employee.OrganizationId
        INNER JOIN dbo.JobTitles AS jobTitle ON jobTitle.Id = employee.JobTitleId
        INNER JOIN dbo.JobPositions AS jobPosition ON jobPosition.Id = employee.JobPositionId
        INNER JOIN dbo.JobGrades AS jobGrade ON jobGrade.Id = employee.JobGradeId
        INNER JOIN dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = employee.EmploymentStatusId
        INNER JOIN dbo.HRDeskVariables AS reason ON reason.Id = shiftRevision.ReasonId
        INNER JOIN dbo.Shifts AS originalShift ON originalShift.Id = shiftRevision.OriginalShiftId
        INNER JOIN dbo.Shifts AS newShift ON newShift.Id = shiftRevision.ShiftId
        LEFT JOIN dbo.PayrollGroups AS payrollGroup ON payrollGroup.Id = employee.PayrollGroupId
