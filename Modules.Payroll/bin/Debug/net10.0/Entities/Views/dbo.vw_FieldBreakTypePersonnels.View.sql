SELECT
    fbt.Id,
    fbt.Label,
    fbt.AttendanceCodeId,
    fbt.MaximumCombinedQuota,
    fbt.AllowCombinedQuota,
    fbt.PrintOutTemplateId,
    fbt.LeaveTypeId,
    fbt.AppliedToAll,
    fbt.Status,
    fbt.ExtraDaysGranted,
    fbt.MonthsNotTakenInterval,
    fbt.MaxBackdateDays,
    fbt.InsertStamp,
    fbt.InsertedBy,
    fbt.UpdateStamp,
    fbt.UpdatedBy,
    p.Id AS PersonnelId,
    p.JoinedDate
FROM FieldBreakTypes fbt
JOIN Personnels p       ON 1 = 1
JOIN Organizations org  ON org.Id = p.OrganizationId
WHERE
    fbt.Status = 'Active'
    AND (
        fbt.AppliedToAll = 'True'
        OR (
            fbt.AppliedToAll = 'False'
            AND NOT EXISTS (
                SELECT 1
                FROM (
                    SELECT DISTINCT Type
                    FROM FieldBreakTypeEligibilityRequirements r
                    WHERE r.FieldBreakTypeId = fbt.Id
                ) t
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM FieldBreakTypeEligibilityRequirements r
                    WHERE
                        r.FieldBreakTypeId = fbt.Id
                        AND r.Type = t.Type
                        AND (
                             (r.Type = 'WorkLocation' AND r.RequirementId = p.WorkLocationId) OR 
                             (
                                r.Type = 'FieldBreakScheme'
                                AND EXISTS (
                                    SELECT fbsc.* 
                                        FROM FieldBreakSchedules fbsc 
	                                        INNER JOIN FieldBreakAssignments fba ON fbsc.FieldBreakAssignmentId = fba.Id
	                                        INNER JOIN FieldBreakSchemes fbs ON fba.FieldBreakSchemeId = fbs.Id 
                                        WHERE fbsc.PersonnelId = p.Id AND fbsc.ScheduleType = 'OnBreak' AND fbs.Id = r.RequirementId AND fbsc.Status = 'Verified'
                                )
                             ) OR
                             (
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