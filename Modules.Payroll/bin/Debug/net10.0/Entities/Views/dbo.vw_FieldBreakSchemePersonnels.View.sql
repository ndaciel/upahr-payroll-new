SELECT
    fbs.Id
    ,fbs.Label
    ,fbs.OnSiteDuration
    ,fbs.OnSiteDurationUnit
    ,fbs.OnBreakDuration
    ,fbs.OnBreakDurationUnit
    ,fbs.RenewalMethod
    ,fbs.Status
    ,fbs.AppliedToAll
    ,p.Id AS PersonnelId
    ,p.JoinedDate
FROM FieldBreakSchemes fbs
JOIN Personnels p       ON 1 = 1
JOIN Organizations org  ON org.Id = p.OrganizationId
WHERE
    fbs.Status = 'Active'
    AND (
        fbs.AppliedToAll = 'True'
        OR (
            fbs.AppliedToAll = 'False'
            AND NOT EXISTS (
                SELECT 1
                FROM (
                    SELECT DISTINCT Type
                    FROM FieldBreakSchemeEligibilityRequirements r
                    WHERE r.FieldBreakSchemeId = fbs.Id
                ) t
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM FieldBreakSchemeEligibilityRequirements r
                    WHERE
                        r.FieldBreakSchemeId = fbs.Id
                        AND r.Type = t.Type
                        AND (
                             (r.Type = 'WorkLocation' AND r.RequirementId = p.WorkLocationId) 
                             OR (r.Type = 'JobTitle'               AND r.RequirementId = p.JobTitleId)
                             OR (r.Type = 'JobPosition'            AND r.RequirementId = p.JobPositionId)
                             OR (
                                r.Type = 'PersonnelClassificationType'
                                AND EXISTS (
                                    SELECT 1
                                    FROM PersonnelClassifications pc
                                    WHERE
                                        pc.PersonnelId = p.Id
                                        AND pc.ClassificationId = r.RequirementId
                                        AND pc.Allow = 'True'
                                )
                            )
                        )
                )
            )
        )
    )