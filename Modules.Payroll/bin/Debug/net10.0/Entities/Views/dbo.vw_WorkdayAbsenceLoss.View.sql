SELECT
    a.Date,
    a.PersonnelId,
    a.WorkLocationId,
    a.OrganizationId,
    a.JobPositionId,
    a.ShiftId,
    a.AttendanceCodeId,
    a.Status,
    p.PayrollGroupId,
    p.EmploymentStatusId,
    p.ShiftPatternId,
    ac.Label AS AttendanceCodeLabel,
    ac.Description AS AttendanceCodeDescription,
    ac.SequenceOrder AS AttendanceCodeSequenceOrder,
    CASE
        WHEN ac.Description LIKE N'%Hadir%'
          OR ac.Description LIKE N'%Business Trip%'
          OR ac.Description LIKE N'%Lembur%'
            THEN N'WorkingDays'
        WHEN ac.Description LIKE N'%Family Visit%'
          OR ac.Description LIKE N'%Tahunan%'
          OR ac.Description LIKE N'%Annual%'
            THEN N'LeaveDays'
        WHEN ac.Description LIKE N'%Sakit%'
          OR ac.Description LIKE N'%Sick%'
            THEN N'SickPermit'
        WHEN ac.Description LIKE N'%Serikat%'
          OR ac.Description LIKE N'%Union%'
            THEN N'UnionPermit'
        WHEN ac.Description LIKE N'%Izin%'
          OR ac.Description LIKE N'%Permit%'
            THEN N'OtherPermit'
        WHEN ac.Description LIKE N'%Mangkir%'
          OR ac.Description LIKE N'%Absent%'
          OR ac.Description LIKE N'%Alpha%'
            THEN N'Absent'
        ELSE N'Other'
    END AS Category
FROM dbo.Attendances AS a
INNER JOIN dbo.AttendanceCodes AS ac ON ac.Id = a.AttendanceCodeId
INNER JOIN dbo.Personnels AS p ON p.Id = a.PersonnelId
