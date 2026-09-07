SELECT u.Id, u.AuthId, u.UserName, u.Name, u.EmailAddress, u.MobileNumber, u.PersonnelId, u.Status, u.InsertStamp, u.InsertedBy, u.UpdateStamp, u.UpdatedBy,
       COALESCE(p.Name, '') AS PersonnelName,
       COALESCE(p.EmployeeNumber, '') AS EmployeeNumber
FROM   dbo.AppUsers AS u
       LEFT OUTER JOIN dbo.Personnels AS p ON p.Id = u.PersonnelId
