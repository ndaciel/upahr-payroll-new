SELECT 
    a.ClaimTypeId,
    a.Id,
    a.Number,
    a.Label,
    a.QuotaAmount,
    a.CoverageFormula,
    a.Terms,
    cl.PersonnelId,
    ISNULL(SUM(cty.CoveredAmount),0) AS UsedAmount

FROM ClaimTypeExpenseItems a
LEFT JOIN ClaimExpenseItems cty 
    ON a.Id = cty.ExpenseItemId
INNER JOIN (SELECT * FROM Claims WHERE Status = 'Verified') cl
    ON cty.ClaimId = cl.Id
 GROUP BY 
    a.ClaimTypeId,
    a.Id,
    a.Number,
    a.Label,
    a.QuotaAmount,
    a.CoverageFormula,
    a.Terms,
    cl.PersonnelId