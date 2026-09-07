SELECT btas.Id as BudgetId, 
        btas.Label as BudgetLabel, btas.Status, 
        p.Id AS PersonnelId,  
        btt.BusinessTripTypeId, 
        budgetItem.ExpenseItemId as BudgetItemId, 
        budgetItemDef.Label as BudgetItemLabel, 
        budgetItem.Amount, budgetItem.Terms
FROM dbo.BusinessTripAllowanceSchemes btas INNER JOIN
     dbo.BusinessTripAllowanceItems budgetItem ON budgetItem.SchemeId = btas.Id INNER JOIN
     dbo.BusinessTripAllowanceSchemeTypes AS btt ON btt.AllowanceSchemeId = btas.Id INNER JOIN
     dbo.HRDeskVariables as budgetItemDef on budgetItemDef.Id = budgetItem.ExpenseItemId INNER JOIN
     dbo.Personnels AS p ON 1 = 1 
WHERE  (btas.Status = 'Active') AND (btas.AppliedToAll = 'True') OR 
       (btas.Status = 'Active') AND (btas.AppliedToAll = 'False') AND ( NOT EXISTS
            (SELECT 1 AS Expr1
            FROM      (SELECT DISTINCT Type
                                FROM      dbo.BusinessTripAllowanceSchemesEligibilityRequirements AS r
                                WHERE   (SchemeId = btas.Id)) AS t
            WHERE   ( NOT EXISTS
                                    (SELECT 1 AS Expr1
                                    FROM      dbo.BusinessTripAllowanceSchemesEligibilityRequirements AS r
                                    WHERE   
                                                    (SchemeId = btas.Id) AND (Type = t.Type) AND (Type = 'WorkLocation') AND (RequirementId = p.WorkLocationId) OR
                                                    (SchemeId = btas.Id) AND (Type = t.Type) AND (Type = 'Organization') AND (RequirementId = p.OrganizationId) OR
                                                    (SchemeId = btas.Id) AND (Type = t.Type) AND (Type = 'JobTitle') AND (RequirementId = p.JobTitleId) OR
                                                    (SchemeId = btas.Id) AND (Type = t.Type) AND (Type = 'JobGrade') AND (RequirementId = p.JobGradeId) OR
                                                    (SchemeId = btas.Id) AND (Type = t.Type) AND (Type = 'JobPosition') AND (RequirementId = p.JobPositionId) ))))