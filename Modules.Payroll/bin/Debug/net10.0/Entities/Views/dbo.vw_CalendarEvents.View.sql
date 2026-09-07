SELECT calendarEvent.Id, calendarEvent.Label, calendarEvent.EventType, calendarEvent.Date, calendarEvent.SubstractLeaveQuota, calendarEvent.LeaveTypeId, calendarEvent.Status, 
             calendarEvent.InsertStamp, calendarEvent.InsertedBy, calendarEvent.UpdateStamp, calendarEvent.UpdatedBy, calendarEvent.IsOffDay, calendarEvent.IsProcessing,
             calendarEvent.ProcessingDone, calendarEvent.ProcessingTotal
FROM   dbo.CalendarEvents AS calendarEvent
