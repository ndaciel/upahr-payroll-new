
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Name AS RequirementLabel, 'EmploymentStatus' AS RequirementCategory
FROM   PersonnelEmploymentStatuses AS requirementVariable
WHERE requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Label AS RequirementLabel, requirementVariable.VariableType AS RequirementCategory
FROM   HRDeskVariables AS requirementVariable
WHERE requirementVariable.VariableType IN ('Ethnicity', 'Gender', 'MaritalStatus', 'Nationality', 'Religion', 'PersonnelClassificationType','EducationLevel','FamilyRelation','PayrollTaxStatus') AND requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Name AS RequirementLabel, 'JobGrade' AS RequirementCategory
FROM   JobGrades AS requirementVariable
WHERE requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Name AS RequirementLabel, 'JobTitle' AS RequirementCategory
FROM   JobTitles AS requirementVariable
WHERE requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Name AS RequirementLabel, 'JobPosition' AS RequirementCategory
FROM   JobPositions AS requirementVariable
WHERE requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Name AS RequirementLabel, 'Organization' AS RequirementCategory
FROM   Organizations AS requirementVariable
WHERE requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Label AS RequirementLabel, 'PayrollGroup' AS RequirementCategory
FROM   PayrollGroups AS requirementVariable
WHERE requirementVariable.Status = 'Active'
UNION
SELECT wl.Id AS RequirementId, wl.Name AS RequirementLabel, 'WorkLocation' AS RequirementCategory
FROM WorkLocations AS wl
WHERE wl.Status = 'Active' AND wl.Type = 'WL'
UNION
SELECT wl.Id AS RequirementId, wl.Name AS RequirementLabel, 'PointOfHire' AS RequirementCategory
FROM WorkLocations AS wl
WHERE wl.Status = 'Active' AND wl.Type = 'POH'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Label AS RequirementLabel, 'Tenure' AS RequirementCategory
FROM   PersonnelEmploymentAgeRanges AS requirementVariable
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Label AS RequirementLabel, 'AttendanceCode' AS RequirementCategory
FROM   AttendanceCodes AS requirementVariable
WHERE requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Label AS RequirementLabel, 'WorkShift' AS RequirementCategory
FROM   Shifts AS requirementVariable
WHERE requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Label AS RequirementLabel, 'OvertimeReason' AS RequirementCategory
FROM     OvertimeReasons AS requirementVariable
WHERE  requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Label AS RequirementLabel, 'ShiftPattern' AS RequirementCategory
FROM   ShiftPatterns AS requirementVariable
WHERE requirementVariable.Status = 'Active'
UNION
SELECT requirementVariable.Id AS RequirementId, requirementVariable.Label AS RequirementLabel, 'DisciplinaryType' AS RequirementCategory
FROM   DisciplinaryRecordTypes AS requirementVariable
WHERE requirementVariable.Status = 'Active'