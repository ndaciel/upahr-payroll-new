SELECT payrollLock.Id, payrollLock.GroupId, payrollLock.StartDate, payrollLock.EndDate, payrollLock.Status, payrollLock.Notes,
       payrollLock.InsertStamp, payrollLock.InsertedBy, payrollLock.UpdateStamp, payrollLock.UpdatedBy,
       payrollGroup.Label AS GroupLabel
FROM dbo.PayrollLocks AS payrollLock INNER JOIN
     dbo.PayrollGroups AS payrollGroup ON payrollGroup.Id = payrollLock.GroupId
