SELECT bt.Id,
        bt.Label,
        bt.NoticePeriod,
        bt.AttendanceCodeId,
        bt.AccommodationFacilities,
        bt.TransportFacilities,
        bt.AppliedToAll,
        bt.Status,
        bt.InsertStamp,
        bt.InsertedBy,
        bt.UpdateStamp,
        bt.UpdatedBy, 
       personel.Id AS PersonnelId, personel.ProfilePictureUrl, personel.JoinedDate
FROM     dbo.BusinesstripTypes AS bt
INNER JOIN dbo.Personnels AS personel ON 1 = 1
INNER JOIN dbo.Organizations AS org ON org.Id = personel.OrganizationId
WHERE  (bt.Status = 'Active') 
AND  (bt.AppliedToAll = 'True') 
OR  (bt.Status = 'Active') 
AND  (bt.AppliedToAll = 'False') 
AND  (NOT EXISTS
    (SELECT 1 AS Expr1
     FROM dbo.BusinesstripTypeEligibilityRequirements AS r
     WHERE (bt.Id = r.BusinessTripTypeId)
     AND (NOT EXISTS
          (SELECT 1 AS Expr1
           FROM dbo.BusinesstripTypeEligibilityRequirements AS r
           WHERE (bt.Id = r.BusinessTripTypeId)
           AND (r.Type = 'WorkLocation') AND (r.RequirementId = personel.WorkLocationId) 
           OR (r.Type = 'Organization') AND (r.RequirementId = personel.OrganizationId) 
           OR (r.Type = 'JobTitle') AND (r.RequirementId = personel.JobTitleId)
           OR (r.Type = 'JobGrade') AND (r.RequirementId = personel.JobGradeId)
           OR (r.Type = 'JobPosition') AND (r.RequirementId = personel.JobPositionId)
          )
     )
)) 
