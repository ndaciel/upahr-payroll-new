SELECT 
    ct.*,
    ccs.Label AS CeilingSchemeLabel,
    hv.Label AS UsageLimitLabel,
    hv2.Label AS BaseClaimPeriodLabel
FROM ClaimTypes ct
LEFT JOIN ClaimCeilingSchemes ccs  ON ct.CeilingSchemeId = ccs.Id
LEFT JOIN HRDeskVariables hv ON ct.UsageLimitId = hv.Id AND hv.VariableType = 'ClaimUsageType'
LEFT JOIN HRDeskVariables hv2 ON ct.BaseClaimPeriodId = hv2.Id AND hv2.VariableType = 'BaseClaimPeriod'