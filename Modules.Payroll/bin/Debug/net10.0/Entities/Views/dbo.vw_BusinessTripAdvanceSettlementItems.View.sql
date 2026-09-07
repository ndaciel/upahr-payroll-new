SELECT BusinessTripAdvanceSettlementItem.Id, BusinessTripAdvanceSettlementItem.SettlementId, BusinessTripAdvanceSettlementItem.ExpenseItemId, BusinessTripAdvanceSettlementItem.Number, 
                  BusinessTripAdvanceSettlementItem.Amount, BusinessTripAdvanceSettlementItem.CoveredAmount, BusinessTripAdvanceSettlementItem.Notes, HRDeskVariable.Label, BusinessTripAdvanceSettlementItem.BudgetAmount,
                  BusinessTripAdvanceSettlementItem.Terms
FROM     dbo.BusinessTripAdvanceSettlementItems AS BusinessTripAdvanceSettlementItem LEFT OUTER JOIN
                  dbo.HRDeskVariables AS HRDeskVariable ON BusinessTripAdvanceSettlementItem.ExpenseItemId = HRDeskVariable.Id