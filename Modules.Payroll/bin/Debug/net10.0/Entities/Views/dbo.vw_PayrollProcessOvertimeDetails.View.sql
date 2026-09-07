SELECT ProcessId, PersonnelId,
       CAST(NULL AS int)          AS OvertimeId,
       CAST(NULL AS nvarchar(50)) AS FormId,
       OvertimeDate,
       CAST(NULL AS datetime)     AS StartTime,
       CAST(NULL AS datetime)     AS EndTime,
       MandatoryHours,
       OvertimeHours,
       NetActHours,
       CalculatedHours,
       Amount                     AS CalculatedAmount,
       '~TOTAL'                   AS OvertimeReasonLabel
FROM dbo.PayrollProcessPersonnelOvertimeDetails;
