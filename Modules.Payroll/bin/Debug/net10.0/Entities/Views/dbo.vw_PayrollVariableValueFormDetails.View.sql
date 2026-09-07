
SELECT variableValue.Id, variableValue.FormId, variableValue.VariableId, variableValue.VariableValue, variableDef.FormulationCode, variableDef.Label AS VariableLabel, variableForm.PersonnelId, variableForm.ReferenceType, variableSetType.Label AS ReferenceTypeLabel, variableForm.Date AS Date
FROM   dbo.PayrollVariableValueFormDetails AS variableValue INNER JOIN
             dbo.PayrollVariables AS variableDef ON variableDef.Id = variableValue.VariableId INNER JOIN
             dbo.PayrollVariableValueForms AS variableForm ON variableForm.Id = variableValue.FormId INNER JOIN
             dbo.HRDeskVariables AS variableSetType ON variableSetType.Id = variableForm.ReferenceType
