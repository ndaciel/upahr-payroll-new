SELECT ct.Id
      ,ct.Name    
      ,ct.ChangeLocation
      ,ct.ChangeOrganization
      ,ct.ChangeJobTitle
      ,ct.ChangeJobGrade
      ,ct.ChangeJobPosition
      ,ct.ChangeEmploymentStatus
      ,ct.ChangeSupervisor
      ,ct.ChangeExpectedRenewalDate
      ,ct.Termination
      ,ct.Status
      ,ct.SequenceOrder
      ,ct.InsertStamp
      ,ct.InsertedBy
      ,ct.UpdateStamp
      ,ct.UpdatedBy
      ,ct.ChangePayrollGroup
      ,ct.DisplayInCareerHistory
      ,ct.TaxAnnualized
      ,ct.ChangeWorkshift
      ,ct.ChangeExpiryDate
      ,ct.ChangeSubstituteCoverage
      ,ct.BlackListedTermination
      ,p.Id AS PersonnelId
      ,p.ProfilePictureUrl
      ,p.JoinedDate
FROM     dbo.CareerTransitionTypes AS ct INNER JOIN
                  dbo.Personnels AS p ON 1 = 1 INNER JOIN
                  dbo.Organizations AS org ON org.Id = p.OrganizationId
WHERE  (ct.Status = 'Active') AND (ct.AppliedToAll = 'True') OR
                  (ct.Status = 'Active') AND (ct.AppliedToAll = 'False') AND (NOT EXISTS
                      (SELECT 1 AS Expr1
                       FROM      (SELECT DISTINCT Type
                                          FROM      dbo.CareerTransitionTypeEligibilityRequirements AS r
                                          WHERE   (TransitionTypeId = ct.Id)) AS t
                       WHERE   (NOT EXISTS
                                             (SELECT 1 AS Expr1
                                              FROM      dbo.CareerTransitionTypeEligibilityRequirements AS r
                                              WHERE
                                                  (TransitionTypeId = ct.Id) AND (Type = t.Type) AND (Type = 'JobGrade') AND (RequirementId = p.JobGradeId) OR
                                                  (TransitionTypeId = ct.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'MONTH') AND (DATEDIFF(MONTH, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) AND (RangeMax = 0 OR RangeMax IS NULL) OR
                                                  (TransitionTypeId = ct.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'MONTH') AND (DATEDIFF(MONTH, p.JoinedDate, GETDATE()) BETWEEN ISNULL(RangeMin, 0) AND RangeMax) OR
                                                  (TransitionTypeId = ct.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'YEAR') AND (RangeMax = 0 OR RangeMax IS NULL) AND (DATEDIFF(YEAR, p.JoinedDate, GETDATE()) >= ISNULL(RangeMin, 0)) OR
                                                  (TransitionTypeId = ct.Id) AND (Type = t.Type) AND (Type = 'Tenure') AND (RequirementId = 'YEAR') AND (DATEDIFF(YEAR, p.JoinedDate, GETDATE()) BETWEEN ISNULL(RangeMin, 0) AND RangeMax) OR
                                                  (TransitionTypeId = ct.Id) AND (Type = t.Type) AND (Type = 'RetirementAge') AND (RequirementId = 'YEAR') AND (DATEDIFF(YEAR, BirthDate, GETDATE()) > ISNULL(r.RangeMax, 0))
  ))))                