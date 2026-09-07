SELECT ur.Id, ur.UserId, ur.RoleId,
       u.Name AS UserName,
       u.UserName AS UserLogin,
       r.Name AS RoleName
FROM   dbo.AppUserRoles AS ur
       INNER JOIN dbo.AppUsers AS u ON u.Id = ur.UserId
       INNER JOIN dbo.AppRoles AS r ON r.Id = ur.RoleId
