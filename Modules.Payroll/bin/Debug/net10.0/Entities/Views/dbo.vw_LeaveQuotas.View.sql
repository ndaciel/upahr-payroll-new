SELECT leaveQuota.Id, leaveQuota.PersonnelId, leaveQuota.LeaveTypeId, leaveQuota.Quota, leaveQuota.CarriedForwardQuota, leaveQuota.CarriedForwardPending, leaveQuota.CarriedForwardUsed, leaveQuota.CarriedForwardBalance, leaveQuota.Pending, leaveQuota.Used, leaveQuota.Encashed, 
             leaveQuota.Balance, leaveQuota.EffectiveDate, leaveQuota.CarriedForwardExpiredDate, leaveQuota.ExpiredDate, leaveQuota.ForwardExpiredDate, leaveQuota.Status, leaveQuota.InsertStamp, leaveQuota.InsertedBy, leaveQuota.UpdateStamp, leaveQuota.UpdatedBy, 
             personel.WorkLocationId, personel.OrganizationId, personel.JobTitleId, personel.JobGradeId, personel.JobPositionId, workLocation.Name AS WorkLocationLabel,   organization.Name as OrganizationLabel, 
             jobTitle.Name AS JobTitleLabel, jobPosition.Name AS JobPositionLabel, jobGrade.Name AS JobGradeLabel, personel.EmployeeNumber, personel.Name AS PersonnelName, personel.ProfilePictureUrl, personel.PayrollGroupId, leaveType.Label AS LeaveTypeLabel
FROM   dbo.LeaveQuotas AS leaveQuota INNER JOIN
             dbo.Personnels AS personel ON personel.Id = leaveQuota.PersonnelId INNER JOIN
             dbo.WorkLocations AS workLocation ON workLocation.Id = personel.WorkLocationId INNER JOIN
             dbo.Organizations AS organization ON organization.Id = personel.OrganizationId INNER JOIN
             
             dbo.JobTitles AS jobTitle ON jobTitle.Id = personel.JobTitleId INNER JOIN
             dbo.JobPositions AS jobPosition ON jobPosition.Id = personel.JobPositionId INNER JOIN
             dbo.JobGrades AS jobGrade ON jobGrade.Id = personel.JobGradeId INNER JOIN
             dbo.LeaveTypes AS leaveType ON leaveType.Id = leaveQuota.LeaveTypeId
