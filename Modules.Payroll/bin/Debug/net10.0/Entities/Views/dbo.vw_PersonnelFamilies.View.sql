SELECT employeeFamily.Id, employeeFamily.PersonnelId, employeeFamily.Name, employeeFamily.RelationTypeId, employeeFamily.GenderId, employeeFamily.BirthDate, employeeFamily.BirthPlace, employeeFamily.MaritalStatusId, employeeFamily.ReligionId, employeeFamily.NationalityId, 
             employeeFamily.MobilePhoneNumber, employeeFamily.IdType, employeeFamily.IdNumber, employeeFamily.Occupation, employeeFamily.Address, employeeFamily.AddressRemarksId, employeeFamily.IsEmergencyContact, employeeFamily.IsEligibleForAllowance, employeeFamily.IsTaxDependent, employeeFamily.Status, employeeFamily.InsertStamp, 
             employeeFamily.InsertedBy, employeeFamily.UpdateStamp, employeeFamily.UpdatedBy, relation.Label AS RelationLabel, gender.Label AS GenderLabel, maritalStatus.Label AS MaritalStatusLabel, religion.Label AS ReligionLabel, nationality.Label AS NationalityLabel,
             personel.WorkLocationId, personel.PayrollGroupId
FROM   dbo.PersonnelFamilies AS employeeFamily INNER JOIN
             dbo.Personnels AS personel ON personel.Id = employeeFamily.PersonnelId INNER JOIN
             dbo.HRDeskVariables AS relation ON relation.Id = employeeFamily.RelationTypeId INNER JOIN
             dbo.HRDeskVariables AS gender ON gender.Id = employeeFamily.GenderId INNER JOIN
             dbo.HRDeskVariables AS maritalStatus ON maritalStatus.Id = employeeFamily.MaritalStatusId INNER JOIN
             dbo.HRDeskVariables AS religion ON religion.Id = employeeFamily.ReligionId INNER JOIN
             dbo.HRDeskVariables AS nationality ON nationality.Id = employeeFamily.NationalityId