SELECT
    employee.Id,
    employee.PreviousEmployeeId,
    employee.EmployeeNumber,
    employee.OldEmployeeNumber,
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
    employee.PointOfHireId,
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
    employee.PayrollTaxId,
    employee.PaymentMethod,
    employee.PayrollBankId,
    employee.BankBranch,
    employee.PayrollBankAccountNumber,
    employee.PayrollBankAccountHolderName,
    employee.PayrollGroupId,
    employee.AdmsEnabled,
    employee.AdmsUserId,
    employee.PayrollTaxStatusId,
    employee.InitialPayrollPeriodYear,
    employee.InitialPayrollPeriodMonth,
    employee.InitialPayrollPeriodWeek,
    employee.Status,
    employee.EnableEssAccount,
    employee.EnableFlexiPunch,
    employee.FlexiLocationId,
    employee.SupervisorId,
    employee.InsertStamp,
    employee.InsertedBy,
    employee.UpdateStamp,
    employee.UpdatedBy,
    employee.EffectiveDate,
    employee.ExpiredDate,
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
    FLOOR(
            (
                CAST(
                        GETDATE() AS INTEGER
                ) - CAST(employee.BirthDate AS INTEGER)
                ) / 365.25
    ) AS Age,
    '' AS ServiceTimeSummary,
    payrollGroup.Label AS PayrollGroupLabel,
    taxStatus.Label AS PayrollTaxStatusLabel,
    bank.Label AS PayrollBankLabel,
    CASE WHEN employee.AdmsEnabled = 'True' THEN 'Registered' ELSE 'Unregistered' END AS FIDStatus,
    CASE WHEN employee.EnableFlexiPunch = 'True' THEN 'Registered' ELSE 'Unregistered' END AS FlexiStatus,
    CASE WHEN biometrics.AdmsFaceBiometric IS NOT NULL THEN 'Registered' ELSE 'Unregistered' END AS BiometricStatus,
    biometrics.AdmsFaceBiometric,
    biometrics.AdmsPalmBiometric,
    biometrics.AdmsFingerBiometric,
    ISNULL(punchLocations.RegisteredDeviceCount, 0) AS RegisteredDeviceCount,
    ISNULL(supervisor.Name, '') AS SupervisorName,
    employee.LastTaxSlipDisclosed,
    employee.LastTaxSlipNumber,
    employee.LastTaxSlipYear,
    employee.LastNettTaxableIncome,
    employee.LastPaidTaxIncome,
    employee.ProfilePictureUrl,
    employee.CountryId,
    employee.PassportNumber,
    employee.BpjsKetenagakerjaanId,
    employee.BpjsKesehatanId,
    locations.Code AS LocationCode,
    locations.Name AS CountryLabel
FROM
    dbo.Personnels AS employee
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
        INNER JOIN dbo.PayrollGroups AS payrollGroup ON payrollGroup.Id = employee.PayrollGroupId
        INNER JOIN dbo.HRDeskVariables AS taxStatus ON taxStatus.Id = employee.PayrollTaxStatusId
        INNER JOIN dbo.HRDeskVariables AS bank ON bank.Id = employee.PayrollBankId
        LEFT JOIN dbo.Locations AS locations ON locations.Id = employee.CountryId
        -- Supervisor resolved via LEFT JOIN ('' when none) so the UNION branches collapse into one
        LEFT JOIN dbo.Personnels AS supervisor ON supervisor.Id = employee.SupervisorId
        -- One pass per AdmsUser over PersonnelBiometrics instead of 3 correlated subqueries per row
        LEFT JOIN (
            SELECT
                AdmsUserId,
                MAX(CASE WHEN BiometricType = '9' THEN IndexNumber END) AS AdmsFaceBiometric,
                MAX(CASE WHEN BiometricType = '8' THEN IndexNumber END) AS AdmsPalmBiometric,
                MAX(CASE WHEN BiometricType = '1' THEN IndexNumber END) AS AdmsFingerBiometric
            FROM dbo.PersonnelBiometrics
            GROUP BY AdmsUserId
        ) biometrics ON biometrics.AdmsUserId = employee.AdmsUserId
        -- One pass over PersonnelPunchLocations instead of a correlated COUNT per row
        LEFT JOIN (
            SELECT PersonnelId, COUNT(LocationId) AS RegisteredDeviceCount
            FROM dbo.PersonnelPunchLocations
            GROUP BY PersonnelId
        ) punchLocations ON punchLocations.PersonnelId = employee.Id
