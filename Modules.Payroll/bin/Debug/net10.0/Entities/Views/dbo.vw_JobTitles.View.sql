SELECT
    j.*,
    p.Name AS ParentName
FROM JobTitles j
LEFT JOIN JobTitles p ON j.ParentId = p.Id
