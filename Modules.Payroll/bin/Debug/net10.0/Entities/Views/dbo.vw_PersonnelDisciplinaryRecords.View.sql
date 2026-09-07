SELECT 
  disciplinaryRecord.Id, 
  disciplinaryRecord.RecordNumber, 
  disciplinaryRecord.PersonnelId, 
  disciplinaryRecord.WorkLocationId, 
  disciplinaryRecord.OrganizationId, 
  disciplinaryRecord.JobTitleId, 
  disciplinaryRecord.JobGradeId, 
  disciplinaryRecord.JobPositionId, 
  disciplinaryRecord.EmploymentStatusId, 
  disciplinaryRecord.DisciplinaryTypeId, 
  disciplinaryRecord.ArticleNumber, 
  disciplinaryRecord.ClauseNumber, 
  disciplinaryRecord.EffectiveDate, 
  disciplinaryRecord.ExpiredDate, 
  disciplinaryRecord.FineStartDate, 
  disciplinaryRecord.FineEndDate, 
  disciplinaryRecord.Status, 
  disciplinaryRecord.Notes, 
  disciplinaryRecord.AttachmentFileName, 
  disciplinaryRecord.AttachmentContentType, 
  disciplinaryRecord.Attachment, 
  disciplinaryRecord.InsertStamp, 
  disciplinaryRecord.InsertedBy, 
  disciplinaryRecord.UpdateStamp, 
  disciplinaryRecord.UpdatedBy, 
  disciplinaryType.Label AS DisciplinaryTypeLabel, 
  workLocation.Name AS WorkLocationLabel, 
  organization.Name as OrganizationLabel, 
  jobTitle.Name AS JobTitleLabel, 
  jobPosition.Name AS JobPositionLabel, 
  jobGrade.Name AS JobGradeLabel, 
  employmentStatus.Name AS EmploymentStatusLabel, 
  employee.EmployeeNumber, 
  employee.Name AS EmployeeName, 
  employee.ProfilePictureUrl, 
  employee.PayrollGroupId 
FROM 
  dbo.PersonnelDisciplinaryRecords AS disciplinaryRecord 
  INNER JOIN dbo.DisciplinaryRecordTypes AS disciplinaryType ON disciplinaryType.Id = disciplinaryRecord.DisciplinaryTypeId 
  INNER JOIN dbo.WorkLocations AS workLocation ON workLocation.Id = disciplinaryRecord.WorkLocationId 
  INNER JOIN dbo.Organizations AS organization ON organization.Id = disciplinaryRecord.OrganizationId 
  INNER JOIN dbo.JobTitles AS jobTitle ON jobTitle.Id = disciplinaryRecord.JobTitleId 
  INNER JOIN dbo.JobPositions AS jobPosition ON jobPosition.Id = disciplinaryRecord.JobPositionId 
  INNER JOIN dbo.JobGrades AS jobGrade ON jobGrade.Id = disciplinaryRecord.JobGradeId 
  INNER JOIN dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = disciplinaryRecord.EmploymentStatusId 
  INNER JOIN dbo.Personnels AS employee ON employee.Id = disciplinaryRecord.PersonnelId
