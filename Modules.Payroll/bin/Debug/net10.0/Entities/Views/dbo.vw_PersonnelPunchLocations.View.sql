
SELECT personnelPunchLocation.LocationId, personnelPunchLocation.PersonnelId, personnelPunchLocation.Allow, location.Label AS LocationLabel, personnel.AdmsUserId, personnel.ProfilePictureUrl
FROM   dbo.PersonnelPunchLocations AS personnelPunchLocation INNER JOIN
             dbo.PunchLocations AS location ON location.Id = personnelPunchLocation.LocationId INNER JOIN
             dbo.Personnels AS personnel ON personnel.Id = personnelPunchLocation.PersonnelId
