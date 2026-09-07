SELECT p.Id AS PersonnelId,
       fbes.Id
      ,fbes.Label
      ,fbes.AppliedToAll
      ,fbes.Status
      ,fbes.InsertStamp
      ,fbes.InsertedBy
      ,fbes.UpdateStamp
      ,fbes.UpdatedBy
      ,fbes.Amount
      ,fbes.PayOnPayrollProcess
      ,fbes.FieldBreakEncashmentComponentId
      ,fbes.ProcessTypeId
      ,fbes.SequenceOrder
FROM     dbo.FieldBreakEncashmentSchemes AS fbes INNER JOIN
                  dbo.Personnels AS p ON 1 = 1
WHERE  (fbes.Status = 'Active') AND (fbes.AppliedToAll = 'True') OR
                  (fbes.Status = 'Active') AND (fbes.AppliedToAll = 'False') AND (NOT EXISTS
                      (SELECT 1 AS Expr1
                       FROM      (SELECT DISTINCT Type
                                          FROM      dbo.FieldBreakEncashmentEligibilityRequirements AS r
                                          WHERE   (FieldBreakEncashmentId = fbes.Id)) AS t
                       WHERE   (NOT EXISTS
                                             (SELECT 1 AS Expr1
                                              FROM      dbo.FieldBreakEncashmentEligibilityRequirements AS r
                                              WHERE   (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'Gender') AND (RequirementId = p.GenderId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'MaritalStatus') AND (RequirementId = p.MaritalStatusId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'Religion') AND (RequirementId = p.ReligionId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'Nationality') AND (RequirementId = p.NationalityId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'Ethnicity') AND (RequirementId = p.EthnicityId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'WorkLocation') AND (RequirementId = p.WorkLocationId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'Organization') AND (RequirementId = p.OrganizationId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'JobTitle') AND (RequirementId = p.JobTitleId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'MONTH') AND (DATEDIFF(MONTH, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) AND 
                                                                (RangeMax = 0 OR
                                                                RangeMax IS NULL) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'MONTH') AND (DATEDIFF(MONTH, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) AND 
                                                                (DATEDIFF(MONTH, p.JoinedDate, GETDATE()) <= RangeMax) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'YEAR') AND (RangeMax = 0 OR
                                                                RangeMax IS NULL) AND (DATEDIFF(YEAR, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'YEAR') AND (DATEDIFF(YEAR, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) AND (DATEDIFF(YEAR, 
                                                                p.JoinedDate, GETDATE()) <= RangeMax) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'JobGrade') AND (RequirementId = p.JobGradeId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'JobPosition') AND (RequirementId = p.JobPositionId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'EmploymentStatus') AND (RequirementId = p.EmploymentStatusId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'PayrollGroup') AND (RequirementId = p.PayrollGroupId) OR
                                                                (FieldBreakEncashmentId = fbes.Id) AND (Type = t.Type) AND (Type = 'PersonnelClassificationType') AND EXISTS
                                                                    (SELECT 1 AS Expr1
                                                                     FROM      dbo.PersonnelClassifications AS pc
                                                                     WHERE   (PersonnelId = p.Id) AND (ClassificationId = r.RequirementId) AND (Allow = 'True'))))))