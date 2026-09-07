
SELECT announcement.Id AS AnnouncementId, recipient.Id AS RecipientId, 'False' AS Opened, announcement.Subject, announcement.Body, recipient.ProfilePictureUrl
FROM   dbo.Announcements AS announcement CROSS JOIN
             dbo.Personnels AS recipient
