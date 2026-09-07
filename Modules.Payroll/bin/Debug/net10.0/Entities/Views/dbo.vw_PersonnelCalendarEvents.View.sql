
-- mangkir
select attendance.PersonnelId, 
attendance.Date, 
'Attendance' as EventType, 
ws.Label as EventLabel,
attendance.ShiftClockIn as EventFromPlan,
attendance.ShiftClockOut as EventUntilPlan,
attendance.ClockIn as EventFromActual,
attendance.ClockOut as EventUntilActual,
'' as ColorLabel,
'' as Notes,
personnel.ProfilePictureUrl
from Attendances as attendance join
AttendanceCodes as attendanceCode on attendanceCode.Id = attendance.AttendanceCodeId join
Shifts as ws on ws.Id = attendance.ShiftId join
Personnels as personnel on personnel.Id = attendance.PersonnelId
where ws.IsOffDay = 'False' and attendance.ClockIn is null and attendance.ClockOut is null
and attendance.Date < GETDATE()
union
-- on leave
select leave.PersonnelId, 
leaveDay.Date, 
'Leave' as EventType, 
leaveType.Label as EventLabel,
leave.StartDate as EventFromPlan,
leave.EndDate as EventUntilPlan,
null as EventFromActual,
null as EventUntilActual,
'' as ColorLabel,
leave.Notes as Notes,
personnel.ProfilePictureUrl
from LeaveDays as leaveDay join
Leaves as leave on leave.Id = leaveDay.LeaveId join
LeaveTypes as leaveType on leaveType.Id = leave.LeaveTypeId join
AttendanceCodes as attendanceCode on attendanceCode.Id = leaveType.AttendanceCodeId join
Personnels as personnel on personnel.Id = leave.PersonnelId
where leave.Status != 'Canceled'
union
-- overtime

select overtime.PersonnelId, 
overtime.Date, 
'Overtime' as EventType, 
reason.Label as EventLabel,
overtime.StartTime as EventFromPlan,
overtime.EndTime as EventUntilPlan,
overtime.ActualStartTime as EventFromActual,
overtime.ActualEndTime as EventUntilActual,
'' as ColorLabel,
overtime.Notes as Notes,
personnel.ProfilePictureUrl
from Overtimes as overtime join
OvertimeReasons as reason on reason.Id = overtime.ReasonId join
Personnels as personnel on personnel.Id = overtime.PersonnelId
where reason.Status != 'Canceled'
union
-- calendar event
select personnel.Id, 
calendarEvent.Date, 
'CalendarEvent' as EventType, 
calendarEvent.Label as EventLabel,
calendarEvent.Date as EventFromPlan,
calendarEvent.Date as EventUntilPlan,
null as EventFromActual,
null as EventUntilActual,
'' as ColorLabel,
'' as Notes,
personnel.ProfilePictureUrl
from CalendarEvents as calendarEvent cross join
Personnels as personnel
