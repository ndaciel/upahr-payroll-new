SELECT
    ct.Id,
    ct.Label,
    ct.QuotaRequired,
    ct.QuotaTypeId,
    ct.QuotaFormula,
    ct.QuotaAmount,
    ct.QuotaReplenishmentMethodId,
    ct.QuotaDurationId,
    ct.CoverageFormula,
    ct.ExpenseItemsDetailed,
    ct.PayOnPayrollProcess,
    ct.ClaimComponentId,
    ct.RequireAttachment,
    ct.IsHiddenFromESS,
    ct.AppliedToAll,
    ct.Status,
    ct.InsertStamp,
    ct.InsertedBy,
    ct.UpdateStamp,
    ct.UpdatedBy,
    ct.CeilingSchemeId,
    ct.Prorate,
    ct.ProcessTypeId,
    ct.GroupLabel,
    ct.UsageLimitId,
    p.Id AS PersonnelId,
    p.ProfilePictureUrl,
    p.JoinedDate
FROM ClaimTypes ct
JOIN Personnels p       ON 1 = 1
JOIN Organizations org  ON org.Id = p.OrganizationId
WHERE
    ct.Status = 'Active'
    AND (
        ct.AppliedToAll = 'True'
        OR (
            ct.AppliedToAll = 'False'
            AND NOT EXISTS (
                SELECT 1
                FROM (
                    SELECT DISTINCT Type
                    FROM ClaimTypeEligibilityRequirements r
                    WHERE r.ClaimTypeId = ct.Id
                ) t
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM ClaimTypeEligibilityRequirements r
                    WHERE
                        r.ClaimTypeId = ct.Id
                        AND r.Type = t.Type
                        AND (
                            (r.Type = 'Gender'                    AND r.RequirementId = p.GenderId)
                            OR (r.Type = 'MaritalStatus'          AND r.RequirementId = p.MaritalStatusId)
                            OR (r.Type = 'Personnel'              AND r.RequirementId = p.Id)
                            OR (r.Type = 'Religion'               AND r.RequirementId = p.ReligionId)
                            OR (r.Type = 'Nationality'            AND r.RequirementId = p.NationalityId)
                            OR (r.Type = 'Ethnicity'              AND r.RequirementId = p.EthnicityId)
                            OR (r.Type = 'WorkLocation'           AND r.RequirementId = p.WorkLocationId)
                            OR (r.Type = 'PointOfHire'            AND r.RequirementId = p.PointOfHireId)
                            OR (r.Type = 'Organization'           AND r.RequirementId = p.OrganizationId)
                            OR (r.Type = 'JobTitle'               AND r.RequirementId = p.JobTitleId)
                            OR (r.Type = 'JobGrade'               AND r.RequirementId = p.JobGradeId)
                            OR (r.Type = 'JobPosition'            AND r.RequirementId = p.JobPositionId)
                            OR (r.Type = 'EmploymentStatus'       AND r.RequirementId = p.EmploymentStatusId)
                            OR (r.Type = 'PayrollGroup'           AND r.RequirementId = p.PayrollGroupId)
                            OR (r.Type = 'TaxStatus'              AND r.RequirementId = p.PayrollTaxStatusId)
                            OR (r.Type = 'ForTerminatePersonnel'  AND r.RequirementId = 'TERMINATE' AND p.Status = 'Terminated' )
                            OR (
                                r.Type = 'Tenure'
                                AND (
                                    (
                                        r.RequirementId = 'MONTH'
                                        AND DATEDIFF(MONTH, p.JoinedDate, GETDATE()) >= ISNULL(r.RangeMin, 0)
                                        AND (r.RangeMax = 0 OR r.RangeMax IS NULL)
                                    )
                                    OR (
                                        r.RequirementId = 'MONTH'
                                        AND DATEDIFF(MONTH, p.JoinedDate, GETDATE())
                                            BETWEEN ISNULL(r.RangeMin, 0) AND r.RangeMax
                                    )
                                    OR (
                                        r.RequirementId = 'YEAR'
                                        AND (r.RangeMax = 0 OR r.RangeMax IS NULL)
                                        AND DATEDIFF(YEAR, p.JoinedDate, GETDATE()) >= ISNULL(r.RangeMin, 0)
                                    )
                                    OR (
                                        r.RequirementId = 'YEAR'
                                        AND DATEDIFF(YEAR, p.JoinedDate, GETDATE())
                                            BETWEEN ISNULL(r.RangeMin, 0) AND r.RangeMax
                                    )
                                )
                            )
                            OR (
                                r.Type = 'FamilyRelation'
                                AND EXISTS (
                                    SELECT 1
                                    FROM PersonnelFamilies pf
                                    WHERE
                                        pf.PersonnelId = p.Id
                                        AND pf.RelationTypeId = r.RequirementId
                                )
                            )
                            OR (
                                r.Type = 'RelativeRange'
                                AND EXISTS (
                                   SELECT 1 FROM ClaimTypeEligibilityRequirements WHERE ClaimTypeId = ct.Id AND
                                    RequirementId IN ( SELECT RelationTypeId
                                    FROM PersonnelFamilies pf
                                    WHERE
                                        pf.PersonnelId = p.Id
                                        AND (
                                                (
                                                    (r.RangeMax = 0 OR r.RangeMax IS NULL)
                                                    AND DATEDIFF(YEAR, pf.BirthDate, GETDATE()) >= ISNULL(r.RangeMin, 0)
                                                )
                                                OR (
                                                     DATEDIFF(YEAR, pf.BirthDate, GETDATE())
                                                        BETWEEN ISNULL(r.RangeMin, 0) AND r.RangeMax
                                                )
                                            ))
                                )
                            )
                            OR (
                                r.Type = 'RelativeEligibleForAllowance'
                                AND EXISTS (
                                   SELECT 1 FROM ClaimTypeEligibilityRequirements WHERE ClaimTypeId =  ct.Id AND
                                    RequirementId = ( SELECT TOP 1 IsEligibleForAllowance
                                    FROM PersonnelFamilies pf
                                    WHERE
                                        pf.PersonnelId = p.Id AND IsEligibleForAllowance = 1
                                        )
                                )
                            )
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
                            OR (
                                r.Type = 'EducationLevel'
                                AND EXISTS (
                                    SELECT 1
                                    FROM PersonnelEducations pe
                                    WHERE
                                        pe.PersonnelId = p.Id
                                        AND pe.EducationLevelId = r.RequirementId
                                )
                            )


                        )
                )
            )
        )
    )