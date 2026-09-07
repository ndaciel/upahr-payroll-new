SELECT leave.*, workLocation.Name AS WorkLocationLabel, organization.Name AS OrganizationLabel, jobTitle.Name AS JobTitleLabel, jobPosition.Name AS JobPositionLabel, jobGrade.Name AS JobGradeLabel, personel.EmployeeNumber, personel.Name AS PersonnelName, personel.ProfilePictureUrl, leaveType.Label AS LeaveTypeLabel, leaveType.PrintOutTemplateId, '' AS ReplacementEmployeeNumber, '' AS ReplacementName, 
         personel.PayrollGroupId
FROM  dbo.Leaves AS leave INNER JOIN
         dbo.WorkLocations AS workLocation ON workLocation.Id = leave.WorkLocationId INNER JOIN
         dbo.Organizations AS organization ON organization.Id = leave.OrganizationId INNER JOIN
         dbo.JobTitles AS jobTitle ON jobTitle.Id = leave.JobTitleId INNER JOIN
         dbo.JobPositions AS jobPosition ON jobPosition.Id = leave.JobPositionId INNER JOIN
         dbo.JobGrades AS jobGrade ON jobGrade.Id = leave.JobGradeId INNER JOIN
         dbo.Personnels AS personel ON personel.Id = leave.PersonnelId INNER JOIN
         dbo.LeaveTypes AS leaveType ON leaveType.Id = leave.LeaveTypeId
WHERE leave.ReplacementId IS NULL
UNION
SELECT leave.*, workLocation.Name AS WorkLocationLabel, organization.Name AS OrganizationLabel, jobTitle.Name AS JobTitleLabel, jobPosition.Name AS JobPositionLabel, jobGrade.Name AS JobGradeLabel, personel.EmployeeNumber, personel.Name AS PersonnelName, personel.ProfilePictureUrl, leaveType.Label AS LeaveTypeLabel, leaveType.PrintOutTemplateId, replacement.EmployeeNumber AS ReplacementEmployeeNumber, 
         replacement.Name AS ReplacementName, personel.PayrollGroupId
FROM  dbo.Leaves AS leave INNER JOIN
         dbo.WorkLocations AS workLocation ON workLocation.Id = leave.WorkLocationId INNER JOIN
         dbo.Organizations AS organization ON organization.Id = leave.OrganizationId INNER JOIN
         dbo.JobTitles AS jobTitle ON jobTitle.Id = leave.JobTitleId INNER JOIN
         dbo.JobPositions AS jobPosition ON jobPosition.Id = leave.JobPositionId INNER JOIN
         dbo.JobGrades AS jobGrade ON jobGrade.Id = leave.JobGradeId INNER JOIN
         dbo.Personnels AS personel ON personel.Id = leave.PersonnelId INNER JOIN
         dbo.LeaveTypes AS leaveType ON leaveType.Id = leave.LeaveTypeId JOIN
         Personnels AS replacement ON replacement.Id = leave.ReplacementId
WHERE leave.ReplacementId IS NOT NULL
