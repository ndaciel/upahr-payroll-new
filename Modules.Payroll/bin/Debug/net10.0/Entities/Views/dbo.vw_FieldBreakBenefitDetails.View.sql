SELECT fbbdet.Id, fbbdet.FieldBreakId,hrdeskbenefit.label BenefitItemLabel,hrdeskterm.label Terms, fbbdet.AppliedAmount, fbbdet.SnapshotAt, fbbdet.Number
	FROM FieldBreakBenefitDetails fbbdet LEFT JOIN 
	HRDeskVariables hrdeskterm ON  fbbdet.AppliedTerms = hrdeskterm.Id AND hrdeskterm.VariableType = 'FieldBreakBenefitTerms' LEFT JOIN
	HRDeskVariables hrdeskbenefit ON  fbbdet.BenefitItemId = hrdeskbenefit.Id AND hrdeskbenefit.VariableType = 'BenefitItem'