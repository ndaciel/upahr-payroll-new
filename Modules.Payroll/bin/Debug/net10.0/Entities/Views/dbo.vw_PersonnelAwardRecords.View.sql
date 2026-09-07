SELECT 
  awardRecord.Id, 
  awardRecord.RecordNumber, 
  awardRecord.PersonnelId, 
  awardRecord.WorkLocationId, 
  awardRecord.OrganizationId, 
  awardRecord.JobTitleId, 
  awardRecord.JobGradeId, 
  awardRecord.JobPositionId, 
  awardRecord.EmploymentStatusId, 
  awardRecord.AwardTypeId, 
  awardRecord.LetterNumber, 
  awardRecord.EffectiveDate, 
  awardRecord.ExpiredDate, 
  awardRecord.Status, 
  awardRecord.Notes, 
  awardRecord.AttachmentFileName, 
  awardRecord.AttachmentContentType, 
  awardRecord.Attachment, 
  awardRecord.InsertStamp, 
  awardRecord.InsertedBy, 
  awardRecord.UpdateStamp, 
  awardRecord.UpdatedBy, 
  awardType.Label AS AwardTypeLabel, 
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
  dbo.PersonnelAwardRecords AS awardRecord
  INNER JOIN dbo.AwardRecordTypes AS awardType ON awardType.Id = awardRecord.AwardTypeId 
  INNER JOIN dbo.WorkLocations AS workLocation ON workLocation.Id = awardRecord.WorkLocationId 
  INNER JOIN dbo.Organizations AS organization ON organization.Id = awardRecord.OrganizationId 
  INNER JOIN dbo.JobTitles AS jobTitle ON jobTitle.Id = awardRecord.JobTitleId 
  INNER JOIN dbo.JobPositions AS jobPosition ON jobPosition.Id = awardRecord.JobPositionId 
  INNER JOIN dbo.JobGrades AS jobGrade ON jobGrade.Id = awardRecord.JobGradeId 
  INNER JOIN dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = awardRecord.EmploymentStatusId 
  INNER JOIN dbo.Personnels AS employee ON employee.Id = awardRecord.PersonnelId