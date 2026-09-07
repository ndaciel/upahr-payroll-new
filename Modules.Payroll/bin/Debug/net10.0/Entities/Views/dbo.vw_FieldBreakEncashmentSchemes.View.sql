SELECT fbe.Id
      ,fbe.Label
      ,fbe.AppliedToAll
      ,fbe.PrintOutTemplateId
      ,fbe.Status
      ,fbe.InsertStamp
      ,fbe.InsertedBy
      ,fbe.UpdateStamp
      ,fbe.UpdatedBy
      ,fbe.Amount
      ,fbe.PayOnPayrollProcess
      ,fbe.FieldBreakEncashmentComponentId
      ,fbe.ProcessTypeId
      ,fbe.SequenceOrder
      ,pc.Label FieldBreakEncashmentComponentLabel
      ,ppt.Label ProcessTypeLabel
  FROM dbo.FieldBreakEncashmentSchemes fbe LEFT OUTER JOIN 
       dbo.PayrollComponents pc ON fbe.FieldBreakEncashmentComponentId = pc.Id LEFT OUTER JOIN
       dbo.PayrollProcessTypes ppt ON fbe.ProcessTypeId  = ppt.Id
