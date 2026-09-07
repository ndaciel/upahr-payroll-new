SELECT organization.Id, organization.TypeId, organization.ParentId, organization.CodeLabel, organization.Name, organization.Description, organization.Status, organization.InsertStamp, organization.InsertedBy, organization.UpdateStamp, organization.UpdatedBy, 
             organizationType.SequenceOrder AS OrganizationLevel,
             parentOrg.Name AS ParentName,
             parentOrg.CodeLabel AS ParentCode
FROM   dbo.Organizations AS organization INNER JOIN
             dbo.HRDeskVariables AS organizationType ON organizationType.Id = organization.TypeId LEFT OUTER JOIN
             dbo.Organizations AS parentOrg ON parentOrg.Id = organization.ParentId
