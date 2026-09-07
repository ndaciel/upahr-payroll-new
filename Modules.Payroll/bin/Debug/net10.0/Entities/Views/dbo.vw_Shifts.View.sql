
SELECT shft.Id, shft.Label, shft.ClockInHourRangeFrom, shft.ClockInMinuteRangeFrom, shft.ClockInHour, shft.ClockInMinute, shft.ClockInHourRangeUntil, shft.ClockInMinuteRangeUntil, shft.ClockInRange, shft.BreakStartHourRangeFrom, shft.BreakStartMinuteRangeFrom, 
             shft.BreakStartHour, shft.BreakStartMinute, shft.BreakStartHourRangeUntil, shft.BreakStartMinuteRangeUntil, shft.BreakStartRange, shft.BreakEndHourRangeFrom, shft.BreakEndMinuteRangeFrom, shft.BreakEndHour, shft.BreakEndMinute, shft.BreakEndHourRangeUntil, 
             shft.BreakEndMinuteRangeUntil, shft.BreakEndRange, shft.ClockOutHourRangeFrom, shft.ClockOutMinuteRangeFrom, shft.ClockOutHour, shft.ClockOutMinute, shft.ClockOutHourRangeUntil, shft.ClockOutMinuteRangeUntil, shft.ClockOutRange, shft.WorkAttendanceCodeId, 
             shft.OffAttendanceCodeId, shft.IncompleteAttendanceCodeId, shft.HldWorkAttendanceCodeId, shft.HldOffAttendanceCodeId, shft.HldIncompleteAttendanceCodeId, shft.CLWorkAttendanceCodeId, shft.CLOffAttendanceCodeId, shft.CLIncompleteAttendanceCodeId, shft.OverrideCalendarEventCode, shft.SequenceNumber, shft.OverNightShift, shft.Status, shft.InsertStamp, shft.InsertedBy, shft.UpdateStamp, shft.UpdatedBy, 
             workAttendanceCode.Label AS WorkAttendanceCodeLabel, offAttendanceCode.Label AS OffAttendanceCodeLabel, icAttendanceCode.Label AS IncompleteAttendanceCodeLabel, shft.IsOffDay, shft.HolidayNotApplicable, hldWorkAttendanceCode.Label AS HldWorkAttendanceCodeLabel, hldOffAttendanceCode.Label AS HldOffAttendanceCodeLabel, hldIcAttendanceCode.Label AS HldIncompleteAttendanceCodeLabel, clWorkAttendanceCode.Label AS CLWorkAttendanceCodeLabel, clOffAttendanceCode.Label AS CLOffAttendanceCodeLabel, clIcAttendanceCode.Label AS CLIncompleteAttendanceCodeLabel
FROM   dbo.Shifts AS shft INNER JOIN
             dbo.AttendanceCodes AS workAttendanceCode ON workAttendanceCode.Id = shft.WorkAttendanceCodeId INNER JOIN
             dbo.AttendanceCodes AS offAttendanceCode ON offAttendanceCode.Id = shft.OffAttendanceCodeId INNER JOIN
             dbo.AttendanceCodes AS icAttendanceCode ON icAttendanceCode.Id = shft.IncompleteAttendanceCodeId LEFT JOIN
             dbo.AttendanceCodes AS hldWorkAttendanceCode ON hldWorkAttendanceCode.Id = shft.HldWorkAttendanceCodeId LEFT JOIN
             dbo.AttendanceCodes AS hldOffAttendanceCode ON hldOffAttendanceCode.Id = shft.HldOffAttendanceCodeId LEFT JOIN
             dbo.AttendanceCodes AS hldIcAttendanceCode ON hldIcAttendanceCode.Id = shft.HldIncompleteAttendanceCodeId LEFT JOIN
             dbo.AttendanceCodes AS clWorkAttendanceCode ON clWorkAttendanceCode.Id = shft.CLWorkAttendanceCodeId LEFT JOIN
             dbo.AttendanceCodes AS clOffAttendanceCode ON clOffAttendanceCode.Id = shft.CLOffAttendanceCodeId LEFT JOIN
             dbo.AttendanceCodes AS clIcAttendanceCode ON clIcAttendanceCode.Id = shft.CLIncompleteAttendanceCodeId
