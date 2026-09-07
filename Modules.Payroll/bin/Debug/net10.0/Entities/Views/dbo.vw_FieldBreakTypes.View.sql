SELECT
    fbt.Id,
    fbt.Label,
    fbt.AttendanceCodeId,
    fbt.MaximumCombinedQuota,
    fbt.AllowCombinedQuota,
    fbt.PrintOutTemplateId,
    fbt.AppliedToAll,
    fbt.Status,
    fbt.ExtraDaysGranted,
    fbt.MonthsNotTakenInterval,
    fbt.InsertStamp,
    fbt.InsertedBy,
    fbt.UpdateStamp,
    fbt.UpdatedBy,
    fbt.LeaveTypeId,
    fbt.Mindays,
    fbt.MaxBackdateDays,
    ac.Label AS AttendanceCodeLabel,
    lt.Label AS LeaveTypeLabel,
    fbt.LeaveDeductionMethod,

    CASE fbt.LeaveDeductionMethod
        WHEN 1 THEN 'Follow Leave Rule'
        WHEN 2 THEN 'Use Field Break Rule'
        ELSE NULL
    END AS LeaveDeductionMethodLabel

FROM dbo.FieldBreakTypes AS fbt
LEFT JOIN dbo.AttendanceCodes AS ac
    ON fbt.AttendanceCodeId = ac.Id
LEFT JOIN dbo.LeaveTypes AS lt
    ON fbt.LeaveTypeId = lt.Id;
