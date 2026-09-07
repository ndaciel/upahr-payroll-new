SELECT
    fb.Id, fb.RecordNumber, fb.PersonnelId, fb.WorkLocationId, fb.OrganizationId,
    fb.JobTitleId, fb.JobGradeId, fb.JobPositionId, fb.EmploymentStatusId,
    fb.FieldBreakScheduleId, fb.Encashed, fb.StartDate, fb.EndDate,
    fb.ActualStartDate, fb.ActualEndDate, fb.TotalDays, fb.Destination,
    fb.Ticket, fb.ReplacementId, fb.Notes, fb.Status,
    fb.InsertStamp, fb.InsertedBy, fb.UpdateStamp, fb.UpdatedBy, fb.FieldBreakTypeId,

    fb.CombinedLeaveDays,
    fb.FieldBreakEncashmentSchemeId,
    fb.AmountEncashment,
    fb.LeaveId,
    lt.Label AS LeaveTypeLabel,
    fbs.Label AS EncashmentSchemeLabel,
    fbs.PrintOutTemplateId AS EncashmentPrintOutTemplateId,

    workLocation.Name AS WorkLocationLabel,
    organization.Name AS OrganizationLabel,
    jobTitle.Name AS JobTitleLabel,
    jobPosition.Name AS JobPositionLabel,
    jobGrade.Name AS JobGradeLabel,
    personel.EmployeeNumber,
    personel.Name AS PersonnelName,
    personel.ProfilePictureUrl,
    personel.PayrollGroupId,
    personel.JoinedDate,
    personel.MobilePhoneNumber,
    employmentStatus.Name AS EmploymentStatusLabel,
    fbSchedule.Label AS FieldBreakScheduleLabel,
    replacement.Name AS ReplacementName,

    fbt.Label AS FieldBreakTypeLabel,
    fbt.PrintOutTemplateId,
    poh.Name AS PointOfHireLabel

FROM dbo.FieldBreaks AS fb
LEFT JOIN dbo.WorkLocations AS workLocation ON workLocation.Id = fb.WorkLocationId
LEFT JOIN dbo.Organizations AS organization ON organization.Id = fb.OrganizationId
LEFT JOIN dbo.JobTitles AS jobTitle ON jobTitle.Id = fb.JobTitleId
LEFT JOIN dbo.JobPositions AS jobPosition ON jobPosition.Id = fb.JobPositionId
LEFT JOIN dbo.JobGrades AS jobGrade ON jobGrade.Id = fb.JobGradeId
LEFT JOIN dbo.Personnels AS personel ON personel.Id = fb.PersonnelId
LEFT JOIN dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = fb.EmploymentStatusId
LEFT JOIN dbo.FieldBreakSchedules AS fbSchedule ON fbSchedule.Id = fb.FieldBreakScheduleId
LEFT JOIN dbo.Personnels AS replacement ON replacement.Id = fb.ReplacementId
LEFT JOIN dbo.Leaves AS lv ON lv.Id = fb.LeaveId
LEFT JOIN dbo.LeaveTypes AS lt ON lt.Id = lv.LeaveTypeId
LEFT JOIN dbo.FieldBreakEncashmentSchemes AS fbs ON fbs.Id = fb.FieldBreakEncashmentSchemeId
LEFT JOIN dbo.FieldBreakTypes AS fbt ON fbt.Id = fb.FieldBreakTypeId
LEFT JOIN dbo.WorkLocations AS poh ON poh.Id = personel.PointOfHireId
