SELECT
    attendance.Date,
    attendance.PersonnelId,
    attendance.WorkLocationId,
    attendance.OrganizationId,
    attendance.JobTitleId,
    attendance.JobGradeId,
    attendance.JobPositionId,
    attendance.ShiftId,
    attendance.ShiftClockIn,
    attendance.ShiftClockOut,
    attendance.ShiftBreakStart,
    attendance.ShiftBreakEnd,
    attendance.BreakStartTimeRangeFrom,
    attendance.BreakStart,
    attendance.BreakStartTimeRangeUntil,
    attendance.BreakEndTimeRangeFrom,
    attendance.BreakEnd,
    attendance.BreakEndTimeRangeUntil,
    attendance.ClockInTimeRangeFrom,
    attendance.ClockIn,
    attendance.ClockInTimeRangeUntil,
    attendance.ClockOutTimeRangeFrom,
    attendance.ClockOut,
    attendance.ClockOutTimeRangeUntil,
    attendance.AttendanceCodeId,
    attendance.LateClockInInMinutes,
    attendance.EarlyClockOutMinutes,
    attendance.EarlyBreakStartMinutes,
    attendance.LateBreakEndMinutes,
    attendance.OverClockOutMinutes,
    attendance.TotalDurationMinutes,
    attendance.MandatoryOvertimeHours,
    attendance.TotalHours,
    attendance.LeaveRequestId,
    attendance.BusinessTripId,
    businessTripType.AllowAttendanceRevision,
    attendance.ShiftAssignmentId,
    attendance.TimeRevisionId,
    attendance.ShiftRevisionId,
    attendance.CalendarEventId,
    attendance.TimeRevisionReason,
    attendance.TimeRevisionNotes,
    attendance.ShiftRevisionReason,
    COALESCE(shiftRevisionReason.Label, attendance.ShiftRevisionReason) AS ShiftRevisionReasonLabel,
    attendance.ShiftRevisionNotes,
    attendance.Verified,
    attendance.Status,
    attendance.InsertStamp,
    attendance.InsertedBy,
    attendance.UpdateStamp,
    attendance.UpdatedBy,
    attendance.OvertimeId,
    workLocation.Name AS WorkLocationLabel,
    organization.Name AS OrganizationLabel,
    jobTitle.Name AS JobTitleLabel,
    jobPosition.Name AS JobPositionLabel,
    jobGrade.Name AS JobGradeLabel,
    personel.EmployeeNumber,
    personel.Name AS PersonnelName,
    personel.ProfilePictureUrl,
    shift.Label AS ShiftLabel,
    attendanceCode.Label AS AttendanceCodeLabel,
    shift.IsOffDay,
    shift.HolidayNotApplicable,
    personel.PayrollGroupId,
    attendance.VerifiedOverClockOutMinutes,
    personel.EmploymentStatusId,
    COALESCE(spaById.Notes, spaByDate.Notes) AS ShiftPatternAssignmentNotes,
    shiftPattern.Id AS ShiftPatternId,
    shiftPattern.Label AS ShiftPatternLabel,
    shiftPattern.CollectiveLeaveNotApplicable,
    ISNULL(verifiedOvertime.TotalHours, 0) AS OvertimeHours,
    0 AS OvertimeIndex
FROM
    dbo.Attendances AS attendance
        INNER JOIN dbo.Personnels AS personel ON personel.Id = attendance.PersonnelId
        INNER JOIN dbo.WorkLocations AS workLocation ON workLocation.Id = personel.WorkLocationId
        INNER JOIN dbo.Organizations AS organization ON organization.Id = personel.OrganizationId
        INNER JOIN dbo.JobTitles AS jobTitle ON jobTitle.Id = personel.JobTitleId
        INNER JOIN dbo.JobPositions AS jobPosition ON jobPosition.Id = personel.JobPositionId
        INNER JOIN dbo.JobGrades AS jobGrade ON jobGrade.Id = personel.JobGradeId
        INNER JOIN dbo.Shifts AS shift ON shift.Id = attendance.ShiftId
        INNER JOIN dbo.AttendanceCodes AS attendanceCode ON attendanceCode.Id = attendance.AttendanceCodeId
        LEFT JOIN dbo.BusinessTrips AS businessTrip ON businessTrip.Id = attendance.BusinessTripId
        LEFT JOIN dbo.BusinessTripTypes AS businessTripType ON businessTripType.Id = businessTrip.BusinessTripTypeId
        LEFT JOIN dbo.HRDeskVariables AS shiftRevisionReason
            ON shiftRevisionReason.Id = attendance.ShiftRevisionReason
            AND shiftRevisionReason.VariableType = 'ShiftRevisionReason'
        -- Prefer stored ShiftPatternAssignmentId: exact-match lookup on PK (index seek)
        OUTER APPLY (
            SELECT spa2.ShiftPatternId, spa2.Notes
            FROM dbo.ShiftPatternAssignments spa2
            WHERE spa2.Id = attendance.ShiftPatternAssignmentId
        ) spaById
        -- Otherwise resolve active assignment for personnel + date
        OUTER APPLY (
            SELECT TOP 1 spa2.ShiftPatternId, spa2.Notes
            FROM dbo.ShiftPatternAssignments spa2
            WHERE NULLIF(attendance.ShiftPatternAssignmentId, '') IS NULL
              AND spa2.PersonnelId = attendance.PersonnelId
              AND spa2.EffectiveDate <= attendance.Date
              AND (spa2.ExpiredDate IS NULL OR spa2.ExpiredDate >= attendance.Date)
              AND spa2.Status IN ('Verified', 'Active')
            ORDER BY spa2.EffectiveDate DESC
        ) spaByDate
        LEFT JOIN dbo.ShiftPatterns shiftPattern
            ON shiftPattern.Id = ISNULL(COALESCE(spaById.ShiftPatternId, spaByDate.ShiftPatternId), personel.ShiftPatternId)
        LEFT JOIN (
            SELECT o.PersonnelId, o.Date, SUM(o.TotalHours) AS TotalHours
            FROM dbo.Overtimes o
            WHERE o.Status = 'Verified'
            GROUP BY o.PersonnelId, o.Date
        ) verifiedOvertime
            ON verifiedOvertime.PersonnelId = attendance.PersonnelId
            AND verifiedOvertime.Date = attendance.Date
