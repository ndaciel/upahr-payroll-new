SELECT
    advanceSettlement.Id,
    advanceSettlement.RecordNumber,
    advanceSettlement.PersonnelId,
    advanceSettlement.WorkLocationId,
    advanceSettlement.OrganizationId,
    advanceSettlement.JobTitleId,
    advanceSettlement.JobGradeId,
    advanceSettlement.JobPositionId,
    advanceSettlement.BusinessTripId,
    advanceSettlement.Date,
    advanceSettlement.AdvanceAmount,
    advanceSettlement.ExpenseAmount,
    advanceSettlement.CoveredAmount,
    advanceSettlement.SettlementAmount,
    advanceSettlement.Notes,
    advanceSettlement.Status,
    advanceSettlement.InsertStamp,
    advanceSettlement.InsertedBy,
    advanceSettlement.UpdateStamp,
    advanceSettlement.UpdatedBy,
    workLocation.Name          AS WorkLocationLabel,
    organization.Name          AS OrganizationLabel,
    jobTitle.Name              AS JobTitleLabel,
    jobPosition.Name           AS JobPositionLabel,
    jobGrade.Name              AS JobGradeLabel,
    personel.EmployeeNumber,
    personel.Name              AS PersonnelName,
    personel.ProfilePictureUrl,
    businessTrip.RecordNumber  AS BusinessTripRecordNumber,
    personel.PayrollGroupId,
    (
        SELECT DISTINCT schemes.PrintOutTemplateId AS [value]
        FROM dbo.BusinessTripAllowanceSchemeTypes AS schemeTypes
            INNER JOIN dbo.BusinessTripAllowanceSchemes AS schemes
                ON schemes.Id = schemeTypes.AllowanceSchemeId
        WHERE schemeTypes.BusinessTripTypeId = businessTrip.BusinessTripTypeId
          AND schemes.Status = 'Active'
          AND schemes.PrintOutTemplateId IS NOT NULL
          AND schemes.PrintOutTemplateId <> ''
        FOR JSON PATH
    ) AS PrintOutTemplateIds

FROM dbo.BusinessTripAdvanceSettlements AS advanceSettlement
    INNER JOIN dbo.WorkLocations AS workLocation
        ON workLocation.Id = advanceSettlement.WorkLocationId
    INNER JOIN dbo.Organizations AS organization
        ON organization.Id = advanceSettlement.OrganizationId
    INNER JOIN dbo.JobTitles AS jobTitle
        ON jobTitle.Id = advanceSettlement.JobTitleId
    INNER JOIN dbo.JobPositions AS jobPosition
        ON jobPosition.Id = advanceSettlement.JobPositionId
    INNER JOIN dbo.JobGrades AS jobGrade
        ON jobGrade.Id = advanceSettlement.JobGradeId
    INNER JOIN dbo.Personnels AS personel
        ON personel.Id = advanceSettlement.PersonnelId
    INNER JOIN dbo.BusinessTrips AS businessTrip
        ON businessTrip.Id = advanceSettlement.BusinessTripId;