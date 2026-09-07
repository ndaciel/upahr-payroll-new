SELECT
    jobChange.*,

    changeType.Name AS TransitionTypeLabel,

    workLocation.Name AS WorkLocationLabel,
    organization.Name AS OrganizationLabel,
    jobTitle.Name AS JobTitleLabel,
    jobPosition.Name AS JobPositionLabel,
    jobGrade.Name AS JobGradeLabel,
    employmentStatus.Name AS EmploymentStatusLabel,
    employmentStatus.HasExpiryDate AS EmploymentStatusHasExpiryDate,

    employee.EmployeeNumber,
    employee.Name AS EmployeeName,
    employee.ProfilePictureUrl,
    employee.JoinedDate,
    changeType.Termination AS IsTermination,

    spv.Name AS DirectSupervisorLabel,
    origSpv.Name AS OriginalSupervisorLabel,

    ISNULL(originalWorkLocation.Name, '') AS OriginalWorkLocationLabel,
    ISNULL(originalOrganization.Name, '') AS OriginalOrganizationLabel,
    ISNULL(originalJobTitle.Name, '') AS OriginalJobTitleLabel,
    ISNULL(originalJobPosition.Name, '') AS OriginalJobPositionLabel,
    ISNULL(originalJobGrade.Name, '') AS OriginalJobGradeLabel,
    ISNULL(originalEmploymentStatus.Name, '') AS OriginalEmploymentStatusLabel,

    employee.GenderId,
    employeeAddress.Address AS EmployeeAddress,

    originalPyGroup.Label AS OriginalPayrollGroupLabel,
    pyGroup.Label AS PayrollGroupLabel,

    ISNULL(
        COALESCE(
            originalShiftPattern.Label,
            CASE WHEN changeType.Name = 'Joined' OR jobChange.TransitionTypeId = 'TRANS_IN'
                 THEN employeeShiftPattern.Label END
        ),
        ''
    ) AS OriginalShiftPatternLabel,
    ISNULL(
        COALESCE(
            shiftPattern.Label,
            originalShiftPattern.Label,
            CASE WHEN changeType.Name = 'Joined' OR jobChange.TransitionTypeId = 'TRANS_IN'
                 THEN employeeShiftPattern.Label END
        ),
        ''
    ) AS ShiftPatternLabel,

    ISNULL(originalSubstituteEmployee.Name, '') AS OriginalSubstituteEmployeeLabel,
    ISNULL(substituteEmployee.Name, '') AS SubstituteEmployeeLabel,

    jsonSummary.ServiceTimeSummary

FROM dbo.CareerTransitions AS jobChange

         INNER JOIN dbo.CareerTransitionTypes AS changeType
                    ON changeType.Id = jobChange.TransitionTypeId

         INNER JOIN dbo.WorkLocations AS workLocation
                    ON workLocation.Id = jobChange.WorkLocationId

         INNER JOIN dbo.Organizations AS organization
                    ON organization.Id = jobChange.OrganizationId

         INNER JOIN dbo.JobTitles AS jobTitle
                    ON jobTitle.Id = jobChange.JobTitleId

         INNER JOIN dbo.JobPositions AS jobPosition
                    ON jobPosition.Id = jobChange.JobPositionId

         INNER JOIN dbo.JobGrades AS jobGrade
                    ON jobGrade.Id = jobChange.JobGradeId

         INNER JOIN dbo.PersonnelEmploymentStatuses AS employmentStatus
                    ON employmentStatus.Id = jobChange.EmploymentStatusId

         INNER JOIN dbo.Personnels AS employee
                    ON employee.Id = jobChange.PersonnelId

         LEFT JOIN dbo.Personnels AS spv
                   ON spv.Id = jobChange.SupervisorId

         LEFT JOIN dbo.Personnels AS origSpv
                   ON origSpv.Id = jobChange.OriginalSupervisorId

         LEFT JOIN dbo.WorkLocations AS originalWorkLocation
                   ON originalWorkLocation.Id = jobChange.OriginalWorkLocationId
                       AND jobChange.TransitionTypeId <> 'TRANS_IN'

         LEFT JOIN dbo.Organizations AS originalOrganization
                   ON originalOrganization.Id = jobChange.OriginalOrganizationId
                       AND jobChange.TransitionTypeId <> 'TRANS_IN'

         LEFT JOIN dbo.JobTitles AS originalJobTitle
                   ON originalJobTitle.Id = jobChange.OriginalJobTitleId
                       AND jobChange.TransitionTypeId <> 'TRANS_IN'

         LEFT JOIN dbo.JobPositions AS originalJobPosition
                   ON originalJobPosition.Id = jobChange.OriginalJobPositionId
                       AND jobChange.TransitionTypeId <> 'TRANS_IN'

         LEFT JOIN dbo.JobGrades AS originalJobGrade
                   ON originalJobGrade.Id = jobChange.OriginalJobGradeId
                       AND jobChange.TransitionTypeId <> 'TRANS_IN'

         LEFT JOIN dbo.PersonnelEmploymentStatuses AS originalEmploymentStatus
                   ON originalEmploymentStatus.Id = jobChange.OriginalEmploymentStatusId
                       AND jobChange.TransitionTypeId <> 'TRANS_IN'

         LEFT JOIN (
    SELECT
        PersonnelId,
        Address,
        ROW_NUMBER() OVER (
            PARTITION BY PersonnelId
            ORDER BY PrimaryAddress DESC, Id DESC
        ) AS rn
    FROM dbo.PersonnelAddresses
) AS employeeAddress
                   ON employeeAddress.PersonnelId = jobChange.PersonnelId
                       AND employeeAddress.rn = 1

         LEFT JOIN dbo.PayrollGroups AS originalPyGroup
                   ON originalPyGroup.Id = jobChange.OriginalPayrollGroupId

         LEFT JOIN dbo.PayrollGroups AS pyGroup
                   ON pyGroup.Id = jobChange.PayrollGroupId

         LEFT JOIN dbo.ShiftPatterns AS shiftPattern
                   ON shiftPattern.Id = jobChange.ShiftPatternId

         LEFT JOIN dbo.ShiftPatterns AS originalShiftPattern
                   ON originalShiftPattern.Id = jobChange.OriginalShiftPatternId

         LEFT JOIN dbo.ShiftPatterns AS employeeShiftPattern
                   ON employeeShiftPattern.Id = employee.ShiftPatternId

         LEFT JOIN dbo.Personnels AS substituteEmployee
                   ON substituteEmployee.Id = jobChange.SubstituteEmployeeId

         LEFT JOIN dbo.Personnels AS originalSubstituteEmployee
                   ON originalSubstituteEmployee.Id = jobChange.OriginalSubstituteEmployeeId

         OUTER APPLY (
             SELECT TOP 1 ct.EffectiveDate AS TerminationDate
             FROM dbo.CareerTransitions ct
             INNER JOIN dbo.CareerTransitionTypes ctt ON ctt.Id = ct.TransitionTypeId
             WHERE ct.PersonnelId = jobChange.PersonnelId
               AND ctt.Termination = 1
             ORDER BY ct.EffectiveDate DESC, ct.Id DESC
         ) latestTermination
         CROSS APPLY (
             SELECT 
                 CASE WHEN latestTermination.TerminationDate IS NOT NULL THEN CAST(latestTermination.TerminationDate AS DATE)
                      ELSE DATEADD(day, 1, CAST(GETDATE() AS DATE)) END AS NowDate,
                 CAST(employee.JoinedDate AS DATE) AS PastDate
         ) consts
         CROSS APPLY (
             SELECT 
                 CASE WHEN consts.PastDate > consts.NowDate THEN 0
                      ELSE DATEDIFF(YEAR, consts.PastDate, consts.NowDate) - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, consts.PastDate, consts.NowDate), consts.PastDate) > consts.NowDate THEN 1 ELSE 0 END
                 END AS Years
         ) y
         CROSS APPLY (
             SELECT DATEADD(YEAR, y.Years, consts.PastDate) AS PastAfterYears
         ) y2
         CROSS APPLY (
             SELECT 
                 CASE WHEN consts.PastDate > consts.NowDate THEN 0
                      ELSE DATEDIFF(MONTH, y2.PastAfterYears, consts.NowDate) - CASE WHEN DATEADD(MONTH, DATEDIFF(MONTH, y2.PastAfterYears, consts.NowDate), y2.PastAfterYears) > consts.NowDate THEN 1 ELSE 0 END
                 END AS Months
         ) m
         CROSS APPLY (
             SELECT DATEADD(MONTH, m.Months, y2.PastAfterYears) AS PastAfterMonths
         ) m2
         CROSS APPLY (
             SELECT 
                 CASE WHEN consts.PastDate > consts.NowDate THEN 0 ELSE DATEDIFF(DAY, m2.PastAfterMonths, consts.NowDate) END AS Days
         ) d
         CROSS APPLY (
             SELECT 
                 CASE WHEN consts.PastDate > consts.NowDate THEN 'Join on ' + CONVERT(VARCHAR(20), consts.PastDate, 106)
                      ELSE
                          CASE WHEN y.Years > 0 THEN CAST(y.Years AS VARCHAR) + ' Year(s)' ELSE '' END +
                          CASE WHEN y.Years > 0 AND m.Months > 0 THEN ', ' ELSE '' END +
                          CASE WHEN m.Months > 0 THEN CAST(m.Months AS VARCHAR) + ' Month(s)' ELSE '' END +
                          CASE WHEN (y.Years > 0 OR m.Months > 0) AND d.Days > 0 THEN ' and ' ELSE '' END +
                          CASE WHEN d.Days > 0 THEN CAST(d.Days AS VARCHAR) + ' Day(s)' ELSE '' END
                 END AS RawText
         ) t
         CROSS APPLY (
             SELECT 
                 CASE WHEN t.RawText = '' THEN '0 Day(s)' ELSE t.RawText END AS Text
         ) t2
         CROSS APPLY (
             SELECT 
                 y.Years,
                 m.Months,
                 d.Days,
                 t2.Text
             FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
         ) jsonSummary(ServiceTimeSummary);