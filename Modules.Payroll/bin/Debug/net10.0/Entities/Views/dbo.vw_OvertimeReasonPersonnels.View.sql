SELECT 
    otr.*,
    p.Id AS PersonnelId,
    p.ProfilePictureUrl,
	p.JoinedDate
FROM OvertimeReasons otr
JOIN Personnels p ON 1=1
JOIN Organizations org ON org.Id = p.OrganizationId
WHERE 
    otr.Status = 'Active'
    AND (
        otr.AppliedToAll = 'True'
        -- Empty applicable criteria is treated the same as AppliedToAll
        OR NOT EXISTS (
            SELECT 1
            FROM OvertimeReasonEligibilityRequirements r
            WHERE r.OvertimeReasonId = otr.Id
        )
        OR
        (
            otr.AppliedToAll = 'False'
            AND NOT EXISTS (
                SELECT 1
                FROM (
                    SELECT DISTINCT r.Type
                    FROM OvertimeReasonEligibilityRequirements r
                    WHERE r.OvertimeReasonId = otr.Id
                ) t
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM OvertimeReasonEligibilityRequirements r
                    WHERE r.OvertimeReasonId = otr.Id
                      AND r.Type = t.Type
                      AND
                      (
                          (r.Type = 'Gender' AND r.RequirementId = p.GenderId)
                          OR (r.Type = 'MaritalStatus' AND r.RequirementId = p.MaritalStatusId)
                          OR (r.Type = 'Religion' AND r.RequirementId = p.ReligionId)
                          OR (r.Type = 'Nationality' AND r.RequirementId = p.NationalityId)
                          OR (r.Type = 'Ethnicity' AND r.RequirementId = p.EthnicityId)
                          OR (r.Type = 'WorkLocation' AND r.RequirementId = p.WorkLocationId)
                          OR (r.Type = 'Organization' AND r.RequirementId = p.OrganizationId)
                          OR (r.Type = 'JobTitle' AND r.RequirementId = p.JobTitleId)
                          OR
                          (
                              r.Type = 'Tenure'
                              AND (
                                  (r.RequirementId = 'MONTH' AND DATEDIFF(MONTH, p.JoinedDate, GETDATE()) >= ISNULL(r.RangeMin, 0) AND (r.RangeMax = 0 OR r.RangeMax IS NULL OR DATEDIFF(MONTH, p.JoinedDate, GETDATE()) <= r.RangeMax))
                                  OR
                                  (r.RequirementId = 'YEAR' AND DATEDIFF(YEAR, p.JoinedDate, GETDATE()) >= ISNULL(r.RangeMin, 0) AND (r.RangeMax = 0 OR r.RangeMax IS NULL OR DATEDIFF(YEAR, p.JoinedDate, GETDATE()) <= r.RangeMax))
                              )
                          )
                          OR (r.Type = 'JobGrade' AND r.RequirementId = p.JobGradeId)
                          OR (r.Type = 'JobPosition' AND r.RequirementId = p.JobPositionId)
                          OR (r.Type = 'EmploymentStatus' AND r.RequirementId = p.EmploymentStatusId)
                          OR (r.Type = 'PayrollGroup' AND r.RequirementId = p.PayrollGroupId)
                          OR
                          (
                              r.Type = 'PersonnelClassificationType'
                              AND EXISTS (
                                  SELECT 1
                                  FROM PersonnelClassifications pc
                                  WHERE pc.PersonnelId = p.Id
                                    AND pc.ClassificationId = r.RequirementId
                                    AND pc.Allow = 'True'
                              )
                          )
                      )
                )
            )
        )
    )
