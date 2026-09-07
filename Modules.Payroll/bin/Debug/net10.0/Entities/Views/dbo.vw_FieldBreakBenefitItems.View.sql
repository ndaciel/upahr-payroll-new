SELECT fbb.Id
      ,fbb.Number
      ,fbb.FieldBreakTypeId
      ,fbb.BenefitItemId
      ,fbb.Amount
      ,fbb.Terms
  FROM dbo.FieldBreakBenefitItems fbb LEFT OUTER JOIN
                  dbo.HRDeskVariables AS hrv ON fbb.BenefitItemId = hrv.Id
