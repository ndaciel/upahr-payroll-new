SELECT remuneration.Id, remuneration.LinkRemuneration, remuneration.LinkedRemunerationId, remuneration.CurrencyId, remuneration.Label, remuneration.ComponentId, remuneration.TypeId, remuneration.ProcessTypeId, remuneration.FormulaTypeId, remuneration.VariableFormTypeId, remuneration.Formula, remuneration.Amount, remuneration.Notes, remuneration.Prorate, 
         remuneration.AppliedToAll, remuneration.Status, remuneration.EffectiveDate, remuneration.ExpiredDate, remuneration.CalculationOrder, remuneration.InsertStamp, remuneration.InsertedBy, remuneration.UpdateStamp, remuneration.UpdatedBy, component.Label AS ComponentLabel, componentType.Label AS TypeLabel, formulatType.Label AS FormulaTypeLabel, 
         processType.Label AS ProcessTypeLabel, lsr.Label AS LinkedRemunerationLabel, remuneration.DateContext, remuneration.DateContextMethod, remuneration.RecordPerVariableForm, cur.Label AS CurrencyLabel
FROM  dbo.PayrollStandardRemunerations AS remuneration INNER JOIN
         dbo.PayrollComponents AS component ON component.Id = remuneration.ComponentId INNER JOIN
         dbo.HRDeskVariables AS componentType ON remuneration.TypeId = componentType.Id INNER JOIN
         dbo.HRDeskVariables AS formulatType ON formulatType.Id = remuneration.FormulaTypeId INNER JOIN
         dbo.PayrollProcessTypes AS processType ON processType.Id = remuneration.ProcessTypeId LEFT JOIN
         dbo.HRDeskVariables AS cur ON cur.Id = remuneration.CurrencyId LEFT JOIN
         dbo.PayrollStandardRemunerations AS lsr ON lsr.Id = remuneration.LinkedRemunerationId