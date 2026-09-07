SELECT payrollProcessPersonnel.ProcessId, payrollProcessPersonnel.PersonnelId, payrollProcessPersonnel.WorkLocationId, payrollProcessPersonnel.OrganizationId, payrollProcessPersonnel.JobTitleId, payrollProcessPersonnel.JobGradeId, payrollProcessPersonnel.JobPositionId, 
             payrollProcessPersonnel.EmploymentStatusId, payrollProcessPersonnel.PayrollTaxId, payrollProcessPersonnel.PayrollBankId, payrollProcessPersonnel.PayrollBankAccountNumber, payrollProcessPersonnel.PayrollBankAccountHolderName, 
             payrollProcessPersonnel.PayrollTaxStatusId, payrollProcessPersonnel.TotalTakeHomePayAllowanceAmount, payrollProcessPersonnel.TotalTakeHomePayDeductionAmount, payrollProcessPersonnel.OtherProcessTaxableAllowanceAmount, 
             payrollProcessPersonnel.OtherProcessTaxableDeductionAmount, payrollProcessPersonnel.CurrentTaxableAlowanceAmount, payrollProcessPersonnel.CurrentTaxableDeductionAmount, payrollProcessPersonnel.Annualized, 
             payrollProcessPersonnel.UpToLastPeriodTaxableAllowanceAmount, payrollProcessPersonnel.UpToLastPeriodTaxableDeductionAmount, payrollProcessPersonnel.OtherTaxableDeductionAmount, payrollProcessPersonnel.LastNettTaxableIncome, 
             payrollProcessPersonnel.LastPaidTaxIncome, payrollProcessPersonnel.NonTaxableIncome, payrollProcessPersonnel.TaxableIncome, payrollProcessPersonnel.PayableTaxAmount, payrollProcessPersonnel.PaidTaxAmount, payrollProcessPersonnel.TaxAmount, 
             payrollProcessPersonnel.TakeHomePayAmount, payrollProcessPersonnel.Status, payrollProcessPersonnel.InsertStamp, payrollProcessPersonnel.InsertedBy, payrollProcessPersonnel.UpdateStamp, payrollProcessPersonnel.UpdatedBy, 
             workLocation.Name AS WorkLocationLabel, organization.Name AS OrganizationLabel, jobTitle.Name AS JobTitleLabel, jobPosition.Name AS JobPositionLabel, jobGrade.Name AS JobGradeLabel, personel.EmployeeNumber, personel.Name AS PersonnelName, personel.ProfilePictureUrl, 
             employmentStatus.Name AS EmploymentStatusLabel, taxStatus.Label AS PayrollTaxStatusLabel, bank.Label AS PayrollBankLabel, processType.Label + ' - ' + period.Label AS ProcessLabel, process.PayDate, process.PeriodId, process.GroupId, payrollGroup.Label AS GroupLabel, process.Status AS ProcessStatus, 
             process.ProcessTypeId, period.Year, period.Month, period.Week, payrollProcessPersonnel.IsLocked
FROM   dbo.PayrollProcessPersonnels AS payrollProcessPersonnel INNER JOIN
             dbo.WorkLocations AS workLocation ON workLocation.Id = payrollProcessPersonnel.WorkLocationId INNER JOIN
             dbo.Organizations AS organization ON organization.Id = payrollProcessPersonnel.OrganizationId INNER JOIN
             dbo.JobTitles AS jobTitle ON jobTitle.Id = payrollProcessPersonnel.JobTitleId INNER JOIN
             dbo.JobPositions AS jobPosition ON jobPosition.Id = payrollProcessPersonnel.JobPositionId INNER JOIN
             dbo.JobGrades AS jobGrade ON jobGrade.Id = payrollProcessPersonnel.JobGradeId INNER JOIN
             dbo.Personnels AS personel ON personel.Id = payrollProcessPersonnel.PersonnelId INNER JOIN
             dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = payrollProcessPersonnel.EmploymentStatusId INNER JOIN
             dbo.HRDeskVariables AS taxStatus ON taxStatus.Id = payrollProcessPersonnel.PayrollTaxStatusId INNER JOIN
             dbo.HRDeskVariables AS bank ON bank.Id = payrollProcessPersonnel.PayrollBankId INNER JOIN
             dbo.PayrollProcesses AS process ON process.Id = payrollProcessPersonnel.ProcessId INNER JOIN
             dbo.PayrollPeriods AS period ON period.Id = process.PeriodId INNER JOIN
             dbo.PayrollProcessTypes AS processType ON processType.Id = process.ProcessTypeId INNER JOIN
             dbo.PayrollGroups AS payrollGroup ON payrollGroup.Id = process.GroupId
