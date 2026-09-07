SELECT 
    extraQuota.Id, 
    extraQuota.LeaveTypeId, 
    leaveType.Label AS LeaveTypeLabel,
    extraQuota.ExtraQuota, 
    extraQuota.Description, 
    extraQuota.AppliedToAll, 
    extraQuota.Status,
    extraQuota.InsertStamp, 
    extraQuota.InsertedBy, 
    extraQuota.UpdateStamp, 
    extraQuota.UpdatedBy
FROM dbo.LeaveTypeExtraQuotas AS extraQuota
LEFT JOIN dbo.LeaveTypes AS leaveType ON leaveType.Id = extraQuota.LeaveTypeId
