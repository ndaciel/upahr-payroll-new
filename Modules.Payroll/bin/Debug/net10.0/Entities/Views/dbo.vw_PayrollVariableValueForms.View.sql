
SELECT variableForm.Id, variableForm.RecordNumber, variableForm.PersonnelId, variableForm.WorkLocationId, variableForm.OrganizationId, variableForm.JobTitleId, variableForm.JobGradeId, variableForm.JobPositionId, variableForm.EmploymentStatusId, variableForm.ReferenceType, 
             variableForm.ReferenceId, variableForm.Date, variableForm.CoverDate, variableForm.PeriodId, variableForm.Notes, variableForm.Status, variableForm.InsertStamp, variableForm.InsertedBy, variableForm.UpdateStamp, variableForm.UpdatedBy, personel.EmployeeNumber, 
             personel.Name AS EmployeeName, personel.ProfilePictureUrl, variableSetType.Label AS ReferenceTypeLabel, personel.PayrollGroupId, workLocation.Name AS WorkLocationLabel,   organization.Name as OrganizationLabel, 
             jobTitle.Name AS JobTitleLabel, jobPosition.Name AS JobPositionLabel, jobGrade.Name AS JobGradeLabel
FROM   dbo.PayrollVariableValueForms AS variableForm INNER JOIN
             dbo.Personnels AS personel ON personel.Id = variableForm.PersonnelId INNER JOIN
             dbo.HRDeskVariables AS variableSetType ON variableSetType.Id = variableForm.ReferenceType INNER JOIN
             dbo.WorkLocations AS workLocation ON workLocation.Id = variableForm.WorkLocationId INNER JOIN
             dbo.Organizations AS organization ON organization.Id = variableForm.OrganizationId INNER JOIN
             
             dbo.JobTitles AS jobTitle ON jobTitle.Id = variableForm.JobTitleId INNER JOIN
             dbo.JobPositions AS jobPosition ON jobPosition.Id = variableForm.JobPositionId INNER JOIN
             dbo.JobGrades AS jobGrade ON jobGrade.Id = variableForm.JobGradeId
