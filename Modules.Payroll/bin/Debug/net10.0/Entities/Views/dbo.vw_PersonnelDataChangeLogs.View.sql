SELECT 
  employee.Id, 
  employee.PersonnelId, 
  employee.PreviousEmployeeId,
  employee.Name, 
  employee.GenderId, 
  employee.BirthDate, 
  employee.BirthPlace, 
  employee.MaritalStatusId, 
  employee.ReligionId, 
  employee.EthnicityId, 
  employee.NationalityId, 
  employee.MobilePhoneNumber, 
  employee.PersonalEmailAddress, 
  employee.IdType, 
  employee.IdNumber, 
  employee.PassportNumber, 
  employee.PointOfHireId, 
  employee.EmployeeNumber, 
  employee.OldEmployeeNumber,
  employee.WorkLocationId, 
  employee.OrganizationId, 
  employee.JobTitleId, 
  employee.JobGradeId, 
  employee.JobPositionId, 
  employee.EmploymentStatusId, 
  employee.OfficePhoneNumber, 
  employee.OfficeEmailAddress, 
  employee.ShiftPatternId,
  employee.JoinedDate, 
  employee.ExpectedRenewalDate, 
  employee.ResignedDate,
  employee.ContractExpiredDate,
  employee.PayrollTaxId, 
  employee.PaymentMethod, 
  employee.PayrollBankId, 
  employee.BankBranch,
  employee.PayrollBankAccountNumber, 
  employee.PayrollBankAccountHolderName, 
  employee.BpjsKetenagakerjaanId, 
  employee.BpjsKesehatanId, 
  employee.PayrollGroupId,
  employee.AdmsEnabled,
  employee.AdmsUserId,
  employee.PayrollTaxStatusId,
  employee.InitialPayrollPeriodYear,
  employee.InitialPayrollPeriodMonth,
  employee.InitialPayrollPeriodWeek,
  employee.LastTaxSlipDisclosed,
  employee.LastTaxSlipNumber,
  employee.LastTaxSlipYear,
  employee.LastNettTaxableIncome,
  employee.LastPaidTaxIncome,
  employee.Status, 
  employee.ChangeNotes, 
  employee.CareerTransitionId, 
  employee.EnableEssAccount, 
  employee.EnableFlexiPunch, 
  employee.FlexiLocationId,
  employee.SupervisorId,
  employee.ProfilePictureUrl,
  employee.CountryId,
  employee.WorkspaceId,
  employee.InsertStamp, 
  employee.InsertedBy,
  employee.UpdateStamp,
  employee.UpdatedBy,
  employee.DeleteStamp,
  employee.DeletedBy,
  employee.EffectiveDate,
  employee.ExpiredDate, 
  employee.IsApplied,
  employee.ChangedFields,
  employee.RelatedData,
  employee.Endpoint,
  employee.Payload,
  gender.Label AS GenderLabel, 
  maritalStatus.Label AS MaritalStatusLabel, 
  religion.Label AS ReligionLabel, 
  ethnicity.Label AS EthnicityLabel, 
  nationality.Label AS NationalityLabel, 
  pointOfHire.Name AS PointOfHireLabel, 
  workLocation.Name AS WorkLocationLabel, 
  organization.Name AS OrganizationLabel, 
  jobTitle.Name AS JobTitleLabel, 
  jobPosition.Name AS JobPositionLabel, 
  jobGrade.Name AS JobGradeLabel, 
  employmentStatus.Name AS EmploymentStatusLabel, 
  payrollGroup.Label AS PayrollGroupLabel, 
  bank.Label AS BankLabel,
  taxStatus.Label AS PayrollTaxStatusLabel,
  shiftPattern.Label AS ShiftPatternLabel,
  supervisor.Name AS SupervisorName,
  locations.Name AS CountryLabel,
  careerTransition.Status AS CareerTransitionStatus,
  CASE
    WHEN careerTransition.Id IS NOT NULL
    THEN CONCAT(careerTransition.RecordNumber, ' - ', careerTransitionType.Name)
    ELSE NULL
  END AS CareerTransitionRecordNumber
FROM 
  dbo.PersonnelDataChangeLogs AS employee 
  INNER JOIN dbo.HRDeskVariables AS gender ON gender.Id = employee.GenderId 
  INNER JOIN dbo.HRDeskVariables AS maritalStatus ON maritalStatus.Id = employee.MaritalStatusId 
  INNER JOIN dbo.HRDeskVariables AS religion ON religion.Id = employee.ReligionId 
  INNER JOIN dbo.HRDeskVariables AS nationality ON nationality.Id = employee.NationalityId 
  LEFT JOIN dbo.HRDeskVariables AS ethnicity ON ethnicity.Id = employee.EthnicityId 
  INNER JOIN dbo.WorkLocations AS pointOfHire ON pointOfHire.Id = employee.PointOfHireId 
  INNER JOIN dbo.WorkLocations AS workLocation ON workLocation.Id = employee.WorkLocationId 
  INNER JOIN dbo.Organizations AS organization ON organization.Id = employee.OrganizationId 
  INNER JOIN dbo.JobTitles AS jobTitle ON jobTitle.Id = employee.JobTitleId 
  INNER JOIN dbo.JobPositions AS jobPosition ON jobPosition.Id = employee.JobPositionId 
  INNER JOIN dbo.JobGrades AS jobGrade ON jobGrade.Id = employee.JobGradeId 
  INNER JOIN dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = employee.EmploymentStatusId 
  LEFT JOIN dbo.PayrollGroups AS payrollGroup ON payrollGroup.Id = employee.PayrollGroupId 
  LEFT JOIN dbo.HRDeskVariables AS bank ON bank.Id = employee.PayrollBankId
  LEFT JOIN dbo.HRDeskVariables AS taxStatus ON taxStatus.Id = employee.PayrollTaxStatusId
  LEFT JOIN dbo.ShiftPatterns AS shiftPattern ON shiftPattern.Id = employee.ShiftPatternId
  LEFT JOIN dbo.Personnels AS supervisor ON supervisor.Id = employee.SupervisorId
  LEFT JOIN dbo.Locations AS locations ON locations.Id = employee.CountryId
  LEFT JOIN dbo.CareerTransitions AS careerTransition ON careerTransition.Id = employee.CareerTransitionId
  LEFT JOIN dbo.CareerTransitionTypes AS careerTransitionType ON careerTransitionType.Id = careerTransition.TransitionTypeId
WHERE
  employee.DeleteStamp IS NULL
