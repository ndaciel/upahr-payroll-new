WITH PersonnelBase AS
     (SELECT p.Id AS PersonnelId, p.EmployeeNumber, p.Name AS PersonnelName, p.ProfilePictureUrl, p.JoinedDate AS PersonnelJoinedDate, p.ResignedDate AS PersonnelResignedDate, p.Status AS PersonnelStatus, p.PayrollGroupId,
         p.GenderId, p.MaritalStatusId, p.ReligionId, p.NationalityId, p.EthnicityId, p.WorkLocationId, p.OrganizationId, p.JobTitleId, p.JobPositionId, p.JobGradeId, p.EmploymentStatusId, p.PointOfHireId, p.PayrollTaxStatusId, p.PayrollTaxId, p.BirthDate,
         GETDATE() AS TodayDate
FROM  dbo.Personnels p), StandardRemunerationBase AS
    (SELECT sr.Id AS RemunerationId, sr.ProcessTypeId, sr.LinkRemuneration, sr.LinkedRemunerationId, sr.Label, sr.ComponentId, sr.TypeId, sr.FormulaTypeId, sr.VariableFormTypeId, sr.Formula, sr.Amount, sr.Notes, sr.Prorate, sr.EffectiveDate, sr.ExpiredDate, sr.CalculationOrder, sr.Status, sr.InsertStamp, sr.InsertedBy, sr.UpdateStamp, sr.UpdatedBy, sr.AppliedToAll,
            c.Label AS ComponentLabel, ct.Label AS TypeLabel, ft.Label AS FormulaTypeLabel, pt.Label AS ProcessTypeLabel, sr.CurrencyId, sr.DateContext, sr.DateContextMethod, sr.RecordPerVariableForm, cur.Label AS CurrencyLabel,
            lsr.Label AS LinkedRemunerationLabel
   FROM  dbo.PayrollStandardRemunerations sr JOIN
            dbo.PayrollComponents c ON c.Id = sr.ComponentId JOIN
            dbo.HRDeskVariables ct ON ct.Id = sr.TypeId JOIN
            dbo.HRDeskVariables ft ON ft.Id = sr.FormulaTypeId JOIN
            dbo.PayrollProcessTypes pt ON pt.Id = sr.ProcessTypeId LEFT JOIN
            dbo.HRDeskVariables cur ON cur.Id = sr.CurrencyId LEFT JOIN
            dbo.PayrollStandardRemunerations lsr ON lsr.Id = sr.LinkedRemunerationId),
/* =========================================================
   SET-BASED ELIGIBILITY FOR STANDARD REMUNERATIONS
   Original logic (per-pair correlated NOT EXISTS) is replaced
   by computing, once, every (remuneration, personnel) pair where
   the personnel is missing at least one required eligibility type.
   A remuneration applies to a personnel when AppliedToAll = True
   OR the personnel is NOT in the disqualified set.
   ========================================================= */
PersonnelRequirementMatches AS
    (-- Attribute based types: requirement id must equal a personnel attribute
     SELECT r.PayrollStandardRemunerationId, r.Type, p.PersonnelId
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r JOIN
           PersonnelBase p ON
               (r.Type = 'Gender' AND r.RequirementId = p.GenderId)
            OR (r.Type = 'MaritalStatus' AND r.RequirementId = p.MaritalStatusId)
            OR (r.Type = 'Religion' AND r.RequirementId = p.ReligionId)
            OR (r.Type = 'Nationality' AND r.RequirementId = p.NationalityId)
            OR (r.Type = 'Ethnicity' AND r.RequirementId = p.EthnicityId)
            OR (r.Type = 'WorkLocation' AND r.RequirementId = p.WorkLocationId)
            OR (r.Type = 'Organization' AND r.RequirementId = p.OrganizationId)
            OR (r.Type = 'JobTitle' AND r.RequirementId = p.JobTitleId)
            OR (r.Type = 'JobGrade' AND r.RequirementId = p.JobGradeId)
            OR (r.Type = 'JobPosition' AND r.RequirementId = p.JobPositionId)
            OR (r.Type = 'EmploymentStatus' AND r.RequirementId = p.EmploymentStatusId)
            OR (r.Type = 'PayrollGroup' AND r.RequirementId = p.PayrollGroupId)
            OR (r.Type = 'PointOfHire' AND r.RequirementId = p.PointOfHireId)
            OR (r.Type = 'TaxStatus' AND r.RequirementId = p.PayrollTaxStatusId)
            OR (r.Type = 'ForTerminatePersonnel' AND r.RequirementId = 'TERMINATE' AND p.PersonnelStatus = 'Terminated')
            OR (r.Type = 'HasNoTaxId' AND r.RequirementId = 'HASNOTAXID' AND p.PayrollTaxId IS NULL)
     UNION ALL
     -- Tenure (months / years of service)
     SELECT r.PayrollStandardRemunerationId, r.Type, p.PersonnelId
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r JOIN
           PersonnelBase p ON
               (r.Type = 'Tenure' AND
                ((r.RequirementId = 'MONTH' AND DATEDIFF(MONTH, p.PersonnelJoinedDate, p.TodayDate) >= ISNULL(r.RangeMin, 0) AND (r.RangeMax = 0 OR r.RangeMax IS NULL OR DATEDIFF(MONTH, p.PersonnelJoinedDate, p.TodayDate) <= r.RangeMax))
                 OR (r.RequirementId = 'YEAR' AND DATEDIFF(YEAR, p.PersonnelJoinedDate, p.TodayDate) >= ISNULL(r.RangeMin, 0) AND (r.RangeMax = 0 OR r.RangeMax IS NULL OR DATEDIFF(YEAR, p.PersonnelJoinedDate, p.TodayDate) <= r.RangeMax))))
     UNION ALL
     -- Employee age
     SELECT r.PayrollStandardRemunerationId, r.Type, p.PersonnelId
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r JOIN
           PersonnelBase p ON
               (r.Type = 'EmployeeAge' AND r.RequirementId = 'YEAR'
                AND DATEDIFF(YEAR, p.BirthDate, p.TodayDate) >= ISNULL(r.RangeMin, 0)
                AND (r.RangeMax IS NULL OR DATEDIFF(YEAR, p.BirthDate, p.TodayDate) <= r.RangeMax))
     UNION ALL
     -- Personnel classification
     SELECT DISTINCT r.PayrollStandardRemunerationId, r.Type, pc.PersonnelId
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r JOIN
           dbo.PersonnelClassifications pc ON pc.ClassificationId = r.RequirementId AND pc.Allow = 'True'
     WHERE r.Type = 'PersonnelClassificationType'
     UNION ALL
     -- Education
     SELECT DISTINCT r.PayrollStandardRemunerationId, r.Type, pe.PersonnelId
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r JOIN
           dbo.PersonnelEducations pe ON pe.EducationLevelId = r.RequirementId
     WHERE r.Type = 'Education'
     UNION ALL
     -- Shift pattern
     SELECT DISTINCT r.PayrollStandardRemunerationId, r.Type, spa.PersonnelId
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r JOIN
           dbo.ShiftPatternAssignments spa ON spa.ShiftPatternId = r.RequirementId AND spa.Status = 'Active'
     WHERE r.Type = 'ShiftPattern'
     UNION ALL
     -- Disciplinary type
     SELECT DISTINCT r.PayrollStandardRemunerationId, r.Type, pdr.PersonnelId
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r JOIN
           dbo.PersonnelDisciplinaryRecords pdr ON pdr.DisciplinaryTypeId = r.RequirementId AND pdr.Status = 'Verified'
     WHERE r.Type = 'DisciplinaryType'
     UNION ALL
     -- Family relation
     SELECT DISTINCT r.PayrollStandardRemunerationId, r.Type, pf.PersonnelId
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r JOIN
           dbo.PersonnelFamilies pf ON pf.RelationTypeId = r.RequirementId
     WHERE r.Type = 'FamilyRelation'
     UNION ALL
     -- Relative age range of family members
     SELECT DISTINCT r.PayrollStandardRemunerationId, r.Type, pf.PersonnelId
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r JOIN
           dbo.PersonnelFamilies pf ON
                (r.Type = 'RelativeRange' AND
                 ((r.RangeMax IS NULL) AND DATEDIFF(YEAR, pf.BirthDate, GETDATE()) >= ISNULL(r.RangeMin, 0))
                 OR (r.RangeMax IS NOT NULL AND DATEDIFF(YEAR, pf.BirthDate, GETDATE()) BETWEEN ISNULL(r.RangeMin, 0) AND r.RangeMax))
     WHERE r.Type = 'RelativeRange'),
RequirementTypes AS
    (SELECT DISTINCT r.PayrollStandardRemunerationId, r.Type
     FROM  dbo.PayrollStandardRemunerationEligibilityRequirements r
     WHERE r.Type != 'AttendanceCode'),
MissingType AS
    (SELECT rt.PayrollStandardRemunerationId, rt.Type, p.PersonnelId
     FROM  RequirementTypes rt JOIN
           PersonnelBase p ON 1 = 1 LEFT JOIN
           PersonnelRequirementMatches m ON m.PayrollStandardRemunerationId = rt.PayrollStandardRemunerationId
                                        AND m.Type = rt.Type
                                        AND m.PersonnelId = p.PersonnelId
     WHERE m.PersonnelId IS NULL),
Disqualified AS
    (SELECT DISTINCT PayrollStandardRemunerationId, PersonnelId FROM MissingType)
/* =========================================================
   1. STANDARD REMUNERATION
      - UNIFIED LOGIC
   ========================================================= */
SELECT sr.RemunerationId AS Id, p.PersonnelId, sr.LinkRemuneration AS LinkRemuneration, sr.LinkedRemunerationId AS LinkedRemunerationId, sr.ProcessTypeId, sr.Label,
sr.ComponentId, sr.TypeId, sr.FormulaTypeId, sr.VariableFormTypeId, sr.Formula, sr.Amount, sr.Prorate, sr.Notes, sr.EffectiveDate, sr.ExpiredDate, sr.CalculationOrder, sr.Status, sr.InsertStamp, sr.InsertedBy, sr.UpdateStamp, sr.UpdatedBy, sr.ComponentLabel, sr.LinkedRemunerationLabel, sr.TypeLabel, sr.FormulaTypeLabel, sr.ProcessTypeLabel, p.PayrollGroupId, p.PersonnelStatus,
p.PersonnelJoinedDate, p.PersonnelResignedDate, CAST('True' AS varchar(5)) AS IsStandardRemuneration, 'StandardRemuneration' AS RemunerationType, p.EmployeeNumber, p.PersonnelName, p.ProfilePictureUrl, sr.CurrencyId, sr.DateContext, sr.DateContextMethod, sr.RecordPerVariableForm,
p.WorkLocationId, p.OrganizationId, p.JobTitleId, p.JobPositionId, p.JobGradeId, p.EmploymentStatusId,
workLocation.Name as WorkLocationLabel,
organization.Name as OrganizationLabel,
jobTitle.Name as JobTitleLabel,
jobPosition.Name as JobPositionLabel,
jobGrade.Name as JobGradeLabel,
employmentStatus.Name as EmploymentStatusLabel,
sr.CurrencyLabel
FROM  StandardRemunerationBase sr JOIN
         PersonnelBase p ON 1 = 1 LEFT JOIN
         Disqualified d ON d.PayrollStandardRemunerationId = sr.RemunerationId AND d.PersonnelId = p.PersonnelId INNER JOIN
         dbo.WorkLocations AS workLocation ON workLocation.Id = p.WorkLocationId INNER JOIN
         dbo.Organizations AS organization ON organization.Id = p.OrganizationId INNER JOIN
         dbo.JobTitles AS jobTitle ON jobTitle.Id = p.JobTitleId INNER JOIN
         dbo.JobPositions AS jobPosition ON jobPosition.Id = p.JobPositionId INNER JOIN
         dbo.JobGrades AS jobGrade ON jobGrade.Id = p.JobGradeId INNER JOIN
         dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = p.EmploymentStatusId
WHERE sr.Status = 'Active' AND (sr.AppliedToAll = 'True' OR d.PersonnelId IS NULL)
UNION ALL
/* =========================================================
   2. INDIVIDUAL REMUNERATION
   ========================================================= */ SELECT r.Id AS RemunerationId, r.PersonnelId, r.LinkRemuneration, r.LinkedRemunerationId, r.ProcessTypeId, r.Label, r.ComponentId, r.TypeId, r.FormulaTypeId, r.VariableFormTypeId, r.Formula, r.Amount, r.Prorate,
         r.Notes, r.EffectiveDate, r.ExpiredDate, r.CalculationOrder, r.Status, r.InsertStamp, r.InsertedBy, r.UpdateStamp, r.UpdatedBy, c.Label, lr.Label AS LinkedRemunerationLabel, ct.Label, ft.Label, pt.Label, p.PayrollGroupId, p.PersonnelStatus, p.PersonnelJoinedDate, p.PersonnelResignedDate, CAST('False' AS varchar(5)), 'IndividualRemuneration', p.EmployeeNumber, p.PersonnelName, p.ProfilePictureUrl, r.CurrencyId, r.DateContext, r.DateContextMethod, r.RecordPerVariableForm,
p.WorkLocationId, p.OrganizationId, p.JobTitleId, p.JobPositionId, p.JobGradeId, p.EmploymentStatusId,
workLocation.Name as WorkLocationLabel,
organization.Name as OrganizationLabel,
jobTitle.Name as JobTitleLabel,
jobPosition.Name as JobPositionLabel,
jobGrade.Name as JobGradeLabel,
employmentStatus.Name as EmploymentStatusLabel,
cur.Label AS CurrencyLabel
FROM  dbo.PayrollRemunerations r JOIN
         dbo.PayrollComponents c ON c.Id = r.ComponentId JOIN
         dbo.HRDeskVariables ct ON ct.Id = r.TypeId JOIN
         dbo.HRDeskVariables ft ON ft.Id = r.FormulaTypeId JOIN
         dbo.PayrollProcessTypes pt ON pt.Id = r.ProcessTypeId JOIN
         PersonnelBase p ON p.PersonnelId = r.PersonnelId INNER JOIN
         dbo.WorkLocations AS workLocation ON workLocation.Id = p.WorkLocationId INNER JOIN
         dbo.Organizations AS organization ON organization.Id = p.OrganizationId INNER JOIN
         dbo.JobTitles AS jobTitle ON jobTitle.Id = p.JobTitleId INNER JOIN
         dbo.JobPositions AS jobPosition ON jobPosition.Id = p.JobPositionId INNER JOIN
         dbo.JobGrades AS jobGrade ON jobGrade.Id = p.JobGradeId INNER JOIN
         dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = p.EmploymentStatusId LEFT JOIN
         dbo.HRDeskVariables AS cur ON cur.Id = r.CurrencyId LEFT JOIN
         dbo.PayrollRemunerations AS lr ON lr.Id = r.LinkedRemunerationId
UNION ALL
/* =========================================================
   3. ADDITIONAL / INCIDENTAL PAY
   ========================================================= */ SELECT ip.Id AS RemunerationId, ip.PersonnelId, CAST('False' AS bit), NULL, ip.ProcessTypeId, ip.Notes, ip.ComponentId, c.TypeId, 'REMFTAM', NULL, NULL, ip.Amount, CAST('False' AS bit), ip.Notes, ip.PayDate, NULL, ip.CalculationOrder, ip.Status,
         ip.InsertStamp, ip.InsertedBy, ip.UpdateStamp, ip.UpdatedBy, c.Label, NULL, ct.Label, 'Amount', pt.Label, p.PayrollGroupId, p.PersonnelStatus, p.PersonnelJoinedDate, p.PersonnelResignedDate, CAST('False' AS varchar(5)), 'Additional', p.EmployeeNumber, p.PersonnelName, p.ProfilePictureUrl, ip.CurrencyId, CAST('False' AS bit), '', CAST('False' AS bit),
p.WorkLocationId, p.OrganizationId, p.JobTitleId, p.JobPositionId, p.JobGradeId, p.EmploymentStatusId,
workLocation.Name as WorkLocationLabel,
organization.Name as OrganizationLabel,
jobTitle.Name as JobTitleLabel,
jobPosition.Name as JobPositionLabel,
jobGrade.Name as JobGradeLabel,
employmentStatus.Name as EmploymentStatusLabel,
cur.Label AS CurrencyLabel
FROM  dbo.PayrollIncidentalPays ip JOIN
         dbo.PayrollComponents c ON c.Id = ip.ComponentId JOIN
         dbo.HRDeskVariables ct ON ct.Id = c.TypeId JOIN
         dbo.PayrollProcessTypes pt ON pt.Id = ip.ProcessTypeId JOIN
         PersonnelBase p ON p.PersonnelId = ip.PersonnelId INNER JOIN
         dbo.WorkLocations AS workLocation ON workLocation.Id = p.WorkLocationId INNER JOIN
         dbo.Organizations AS organization ON organization.Id = p.OrganizationId INNER JOIN
         dbo.JobTitles AS jobTitle ON jobTitle.Id = p.JobTitleId INNER JOIN
         dbo.JobPositions AS jobPosition ON jobPosition.Id = p.JobPositionId INNER JOIN
         dbo.JobGrades AS jobGrade ON jobGrade.Id = p.JobGradeId INNER JOIN
         dbo.PersonnelEmploymentStatuses AS employmentStatus ON employmentStatus.Id = p.EmploymentStatusId LEFT JOIN
         dbo.HRDeskVariables AS cur ON cur.Id = ip.CurrencyId
