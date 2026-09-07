SELECT
    evaluationRecord.*,
    workLocation.Name AS WorkLocationLabel,
    organization.Name AS OrganizationLabel,
    jobTitle.Name AS JobTitleLabel,
    jobPosition.Name AS JobPositionLabel,
    jobGrade.Name AS JobGradeLabel,
    employmentStatus.Name AS EmploymentStatusLabel,
    personel.EmployeeNumber,
    personel.Name AS PersonnelName,
    personel.ProfilePictureUrl,
    personel.PayrollGroupId,
    evaluationForm.Label AS EvaluationFormLabel,
    reviewer.EmployeeNumber AS ReviewerEmployeeNumber,
    reviewer.Name AS ReviewerName,
    personel.Status AS PersonnelStatus,
    COALESCE(assessmentPeriod.Label, payrollPeriod.Label) AS PeriodLabel,
    evaluationFormSession.Label AS SessionLabel
FROM dbo.PersonnelEvaluationRecords AS evaluationRecord
LEFT JOIN dbo.WorkLocations AS workLocation ON workLocation.Id = evaluationRecord.WorkLocationId
LEFT JOIN dbo.Organizations AS organization ON organization.Id = evaluationRecord.OrganizationId
LEFT JOIN dbo.JobTitles AS jobTitle ON jobTitle.Id = evaluationRecord.JobTitleId
LEFT JOIN dbo.JobPositions AS jobPosition ON jobPosition.Id = evaluationRecord.JobPositionId
LEFT JOIN dbo.JobGrades AS jobGrade ON jobGrade.Id = evaluationRecord.JobGradeId
LEFT JOIN dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = evaluationRecord.EmploymentStatusId
INNER JOIN dbo.Personnels AS personel ON personel.Id = evaluationRecord.PersonnelId
INNER JOIN dbo.EvaluationForms AS evaluationForm ON evaluationForm.Id = evaluationRecord.EvaluationFormId
LEFT JOIN dbo.Personnels AS reviewer ON reviewer.Id = evaluationRecord.ReviewerId
LEFT JOIN dbo.HRDeskVariables AS assessmentPeriod ON assessmentPeriod.Id = evaluationRecord.PeriodId
LEFT JOIN dbo.PayrollPeriods AS payrollPeriod ON payrollPeriod.Id = evaluationRecord.PayrollPeriodId
LEFT JOIN dbo.EvaluationFormSessions AS evaluationFormSession ON evaluationFormSession.Id = evaluationRecord.SessionId
