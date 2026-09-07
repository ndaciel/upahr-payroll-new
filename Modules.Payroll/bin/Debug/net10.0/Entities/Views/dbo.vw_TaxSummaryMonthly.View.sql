SELECT 
	tb.PeriodId, b.Tin, b.TkuId, ca.Month, ca.Year
	, ca.PeriodEndDate as TaxPeriod
	, a.PayrollTaxId TaxId, tb.PersonnelId
	, a.Name PersonnelName, d.Name JobPosition
	, a.IdNumber 
,'21-100-01' TaxCode
,e.Label TaxStatusName
,ISNULL(tr.Rate, 0) TaxRate
,case f.TaxationMethodId when 'TAXMGUP' then 'YES' else 'NO' end IsGrossUp
,'ID' CountryCode
,tb.GroupId
,tb.ProcessTypeId
,tb.TaxAllowanceAmount
,tb.GrossAmount
,tb.TaxAmount
,g.Status
,g.ErrorMessage
 from  (
	SELECT 
		a.PersonnelId, b.PeriodId, b.GroupId, b.ProcessTypeId
		, Max(ProcessId) ProcessId
		, SUM(a.TotalTakeHomePayDeductionAmount) TaxAllowanceAmount -- Tunjangan PPh
		, sum(a.CurrentTaxableAlowanceAmount) GrossAmount -- GROSS
		, sum(a.TaxAmount) TaxAmount
	from payrollprocesspersonnels a
	join payrollprocesses b on a.processid=b.id
	join Personnels c on c.Id = a.personnelid
	join PayrollPeriods d on d.Id = b.PeriodId
	group by a.PersonnelId, b.PeriodId, b.GroupId, b.ProcessTypeId
) tb
join Personnels a on a.Id = tb.PersonnelId
join PayrollGroups b on b.Id = tb.GroupId
join PayrollPeriods ca on ca.Id = tb.PeriodId
join JobPositions d on d.Id = a.JobPositionId
join HRDeskVariables e on e.Id = a.PayrollTaxStatusId
join PayrollProcessTypes f on f.Id = tb.ProcessTypeId
left join PayrollCoretaxMonthlyIntegrations g 
	ON g.PeriodId = tb.PeriodId and g.PersonnelId = tb.PersonnelId
LEFT JOIN PayrollProcessPersonnelTaxRates tr 
    ON tr.PersonnelId = tb.PersonnelId AND tr.ProcessId = tb.ProcessId