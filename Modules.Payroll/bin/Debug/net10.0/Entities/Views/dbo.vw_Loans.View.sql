SELECT
    loan.Id,
    loan.RecordNumber,
    loan.PersonnelId,
    loan.WorkLocationId,
    loan.OrganizationId,
    loan.JobTitleId,
    loan.JobGradeId,
    loan.JobPositionId,
    loan.EmploymentStatusId,
    loan.LoanTypeId,
    loan.Date,
    loan.Amount,
    loan.Tenor,
    loan.DeductOnPayrollProcess,
    loan.ProcessTypeId,
    loan.DeductionComponentId,
    loan.StartInstallmentDate,
    loan.InstallmentAmount,
    loan.PaidAmount,
    loan.BalanceAmount,
    loan.Status,
    loan.Notes,
    loan.InsertStamp,
    loan.InsertedBy,
    loan.UpdateStamp,
    loan.UpdatedBy,
    workLocation.Name AS WorkLocationLabel,
    organization.Name AS OrganizationLabel,
    jobTitle.Name AS JobTitleLabel,
    jobPosition.Name AS JobPositionLabel,
    jobGrade.Name AS JobGradeLabel,
    personel.EmployeeNumber,
    personel.Name AS PersonnelName,
    personel.ProfilePictureUrl,
    loanType.Label AS LoanTypeLabel,
    employmentStatus.Name AS EmploymentStatusLabel,
    personel.PayrollGroupId,
    deductionComponent.Label AS DeductionComponentLabel,
    processType.Label AS ProcessTypeLabel
FROM
    dbo.Loans AS loan
        INNER JOIN dbo.WorkLocations AS workLocation ON workLocation.Id = loan.WorkLocationId
        INNER JOIN dbo.Organizations AS organization ON organization.Id = loan.OrganizationId
        INNER JOIN dbo.JobTitles AS jobTitle ON jobTitle.Id = loan.JobTitleId
        INNER JOIN dbo.JobPositions AS jobPosition ON jobPosition.Id = loan.JobPositionId
        INNER JOIN dbo.JobGrades AS jobGrade ON jobGrade.Id = loan.JobGradeId
        INNER JOIN dbo.Personnels AS personel ON personel.Id = loan.PersonnelId
        INNER JOIN dbo.LoanTypes AS loanType ON loanType.Id = loan.LoanTypeId
        INNER JOIN dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = loan.EmploymentStatusId
        LEFT OUTER JOIN dbo.PayrollComponents AS deductionComponent ON deductionComponent.Id = loan.DeductionComponentId
        LEFT OUTER JOIN dbo.PayrollProcessTypes AS processType ON processType.Id = loan.ProcessTypeId
