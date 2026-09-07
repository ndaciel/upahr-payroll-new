
select 
finalizedProcess.ProcessId,
finalizedProcess.PersonnelId,
finalizedProcess.GroupId,
finalizedProcess.Year,
payrollGroup.Tin as TIN,
'No' as WorkForSecondEmployer,
(select top(1) initialProcess.Month from vw_PayrollProcessPersonnels as initialProcess 
where initialProcess.PersonnelId = finalizedProcess.PersonnelId and
initialProcess.Year = finalizedProcess.Year order by initialProcess.Month asc) as TaxPeriodMonthStart,
finalizedProcess.Month as TaxPeriodMonthEnd,
CASE
WHEN nationality.Value = 'true'
    THEN 'Non Resident'
    ELSE 'Resident'
END as CounterpartOpt,
personnel.IdNumber as CounterpartPassport,
finalizedProcess.PayrollTaxId as CounterpartTin,
finalizedProcess.PayrollTaxStatusLabel as TaxExemptOpt,
finalizedProcess.JobPositionLabel as CounterpartPosition,
'21-100-01' as TaxObjectCode,
CASE
WHEN (select top(1) initialProcess.Month from vw_PayrollProcessPersonnels as initialProcess 
where initialProcess.PersonnelId = finalizedProcess.PersonnelId and
initialProcess.Year = finalizedProcess.Year order by initialProcess.Month asc) = 1
and finalizedProcess.Month = 12
    THEN 'FullYear'
    ELSE 'PartialYear'
END as StatusOfWithholding,
(finalizedProcess.Month - (select top(1) initialProcess.Month from vw_PayrollProcessPersonnels as initialProcess 
where initialProcess.PersonnelId = finalizedProcess.PersonnelId and
initialProcess.Year = finalizedProcess.Year order by initialProcess.Month asc) + 1) as NumberOfMonths,
(select coalesce(sum(taxableDetail.ProjectedAmount),0) 
from vw_PayrollProcessPersonnelIncomeTaxDetailComponents as taxableDetail
where taxableDetail.ProcessId = finalizedProcess.ProcessId
and taxableDetail.PersonnelId = finalizedProcess.PersonnelId
and taxableDetail.ComponentId in (select Id from PayrollComponents
where TaxStatementGroup = 'Gaji')) as SalaryPensionJhtTht,
CASE
WHEN processType.TaxationMethodId = 'TAXMGUP'
    THEN 'Yes'
    ELSE 'No'
END as GrossUpOpt,
(select coalesce(sum(taxableDetail.ProjectedAmount),0) 
from vw_PayrollProcessPersonnelIncomeTaxDetailComponents as taxableDetail
where taxableDetail.ProcessId = finalizedProcess.ProcessId
and taxableDetail.PersonnelId = finalizedProcess.PersonnelId
and taxableDetail.ComponentId in (select Id from PayrollComponents
where TaxStatementGroup = 'Tunjangan PPh')) as IncomeTaxBenefit,

(select coalesce(sum(taxableDetail.ProjectedAmount),0) 
from vw_PayrollProcessPersonnelIncomeTaxDetailComponents as taxableDetail
where taxableDetail.ProcessId = finalizedProcess.ProcessId
and taxableDetail.PersonnelId = finalizedProcess.PersonnelId
and taxableDetail.ComponentId in (select Id from PayrollComponents
where TaxStatementGroup = 'Tunjangan Lainnya / Lembur')) as OtherBenefit,

(select coalesce(sum(taxableDetail.ProjectedAmount),0) 
from vw_PayrollProcessPersonnelIncomeTaxDetailComponents as taxableDetail
where taxableDetail.ProcessId = finalizedProcess.ProcessId
and taxableDetail.PersonnelId = finalizedProcess.PersonnelId
and taxableDetail.ComponentId in (select Id from PayrollComponents
where TaxStatementGroup = 'Honorarium')) as Honorarium,

(select coalesce(sum(taxableDetail.ProjectedAmount),0) 
from vw_PayrollProcessPersonnelIncomeTaxDetailComponents as taxableDetail
where taxableDetail.ProcessId = finalizedProcess.ProcessId
and taxableDetail.PersonnelId = finalizedProcess.PersonnelId
and taxableDetail.ComponentId in (select Id from PayrollComponents
where TaxStatementGroup = 'Asuransi')) as InsurancePaidByEmployer,

(select coalesce(sum(taxableDetail.ProjectedAmount),0) 
from vw_PayrollProcessPersonnelIncomeTaxDetailComponents as taxableDetail
where taxableDetail.ProcessId = finalizedProcess.ProcessId
and taxableDetail.PersonnelId = finalizedProcess.PersonnelId
and taxableDetail.ComponentId in (select Id from PayrollComponents
where TaxStatementGroup = 'Natura')) as Natura,

(select coalesce(sum(taxableDetail.ProjectedAmount),0) 
from vw_PayrollProcessPersonnelIncomeTaxDetailComponents as taxableDetail
where taxableDetail.ProcessId = finalizedProcess.ProcessId
and taxableDetail.PersonnelId = finalizedProcess.PersonnelId
and taxableDetail.ComponentId in (select Id from PayrollComponents
where TaxStatementGroup = 'Tantiem, Bonus, Gratifikasi, THR')) as TantiemBonusThr,

(select coalesce(sum(taxableDetail.ProjectedAmount),0) 
from vw_PayrollProcessPersonnelIncomeTaxDetailComponents as taxableDetail
where taxableDetail.ProcessId = finalizedProcess.ProcessId
and taxableDetail.PersonnelId = finalizedProcess.PersonnelId
and taxableDetail.ComponentId in (select Id from PayrollComponents
where TaxStatementGroup = 'Iuran Pensiun atau Biaya THT/JHT')) as PensionContributionJhtThtFee,

(select coalesce(sum(taxableDetail.ProjectedAmount),0) 
from vw_PayrollProcessPersonnelIncomeTaxDetailComponents as taxableDetail
where taxableDetail.ProcessId = finalizedProcess.ProcessId
and taxableDetail.PersonnelId = finalizedProcess.PersonnelId
and taxableDetail.ComponentId in (select Id from PayrollComponents
where TaxStatementGroup = 'Zakat')) as Zakat,

(SELECT 
    STRING_AGG(TaxSlipNumber, ', ') 
        WITHIN GROUP (ORDER BY PeriodStart ASC) AS TaxSlipNumbers
FROM PersonnelTaxStatements as taxStatement
where taxStatement.PersonnelId = finalizedProcess.PersonnelId
and taxStatement.Year = finalizedProcess.Year
) as PrevWhTaxSlip,
'N/A' as TaxCertificate,
0 as Article21IncomeTax,
finalizedProcess.PayDate as WithholdingDate,
personnel.ProfilePictureUrl

from vw_PayrollProcessPersonnels as finalizedProcess join
PayrollGroups as payrollGroup on payrollGroup.Id = finalizedProcess.GroupId join
Personnels as personnel on personnel.Id = finalizedProcess.PersonnelId join
HRDeskVariables as nationality on nationality.Id = personnel.NationalityId join
PayrollProcessTypes as processType on processType.Id = finalizedProcess.ProcessTypeId
where finalizedProcess.Annualized = 'True'
