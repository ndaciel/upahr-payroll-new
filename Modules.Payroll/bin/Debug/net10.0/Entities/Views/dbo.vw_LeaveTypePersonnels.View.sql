SELECT lt.Id, lt.Label, lt.AllowHalfDay, lt.RequireAttachment, lt.QuotaRequired, lt.Quota, lt.QuotaReplenishmentMethodId, lt.QuotaDurationId, lt.CarryForwardQuotaDuration, lt.ActivitiesDetailed, lt.DurationCalculationMethodId, 
                  lt.MaximumDurationTaken, lt.MaximumOverBalance, lt.AttendanceCodeId, lt.AppliedToAll, lt.RequiredServiceTimeRangeMin, lt.RequiredServiceTimeRangeMax, lt.Status, lt.InsertStamp, lt.InsertedBy, lt.UpdateStamp, lt.UpdatedBy, 
                  lt.NoticePeriod, lt.MaximumRequestFrequency, lt.MaximumLeavePerDate, lt.PrintOutTemplateId, lt.EncashmentFormula, lt.ProcessTypeId, lt.EncashmentComponentId, p.Id AS PersonnelId, dcm.Label AS DurationCalculationMethodLabel, p.ProfilePictureUrl, 
                  p.JoinedDate
FROM     dbo.LeaveTypes AS lt INNER JOIN
                  dbo.Personnels AS p ON 1 = 1 INNER JOIN
                  dbo.Organizations AS org ON org.Id = p.OrganizationId INNER JOIN
                  dbo.HRDeskVariables AS dcm ON lt.DurationCalculationMethodId = dcm.Id
WHERE  (lt.Status = 'Active') AND (lt.AppliedToAll = 'True') OR
                  (lt.Status = 'Active') AND (lt.AppliedToAll = 'False') AND (NOT EXISTS
                      (SELECT 1 AS Expr1
                       FROM      (SELECT DISTINCT Type
                                          FROM      dbo.LeaveTypeEligibilityRequirements AS r
                                          WHERE   (LeaveTypeId = lt.Id)) AS t
                       WHERE   (NOT EXISTS
                                             (SELECT 1 AS Expr1
                                              FROM      dbo.LeaveTypeEligibilityRequirements AS r
                                              WHERE   (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Gender') AND (RequirementId = p.GenderId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'MaritalStatus') AND (RequirementId = p.MaritalStatusId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Personnel') AND (RequirementId = p.Id) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Religion') AND (RequirementId = p.ReligionId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Nationality') AND (RequirementId = p.NationalityId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Ethnicity') AND (RequirementId = p.EthnicityId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'PointOfHire') AND (RequirementId = p.PointOfHireId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'WorkLocation') AND (RequirementId = p.WorkLocationId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Organization') AND (RequirementId = p.OrganizationId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'JobTitle') AND (RequirementId = p.JobTitleId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'MONTH') AND (DATEDIFF(MONTH, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) AND (RangeMax = 0 OR
                                                                RangeMax IS NULL) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'MONTH') AND (DATEDIFF(MONTH, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) AND (DATEDIFF(MONTH, p.JoinedDate, 
                                                                GETDATE()) <= RangeMax) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'YEAR') AND (RangeMax = 0 OR
                                                                RangeMax IS NULL) AND (DATEDIFF(YEAR, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'YEAR') AND (DATEDIFF(YEAR, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) AND (DATEDIFF(YEAR, p.JoinedDate, 
                                                                GETDATE()) <= RangeMax) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'JobGrade') AND (RequirementId = p.JobGradeId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'JobPosition') AND (RequirementId = p.JobPositionId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'EmploymentStatus') AND (RequirementId = p.EmploymentStatusId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'PayrollGroup') AND (RequirementId = p.PayrollGroupId) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'FamilyRelation') AND EXISTS
                                                                    (SELECT 1 AS Expr1
                                                                     FROM      dbo.PersonnelFamilies AS pf
                                                                     WHERE   (PersonnelId = p.Id) AND (RelationTypeId = r.RequirementId)) OR
                                                                (LeaveTypeId = lt.Id) AND (Type = t.Type) AND (Type = 'PersonnelClassificationType') AND EXISTS
                                                                    (SELECT 1 AS Expr1
                                                                     FROM      dbo.PersonnelClassifications AS pc
                                                                     WHERE   (PersonnelId = p.Id) AND (ClassificationId = r.RequirementId) AND (Allow = 'True'))))))
