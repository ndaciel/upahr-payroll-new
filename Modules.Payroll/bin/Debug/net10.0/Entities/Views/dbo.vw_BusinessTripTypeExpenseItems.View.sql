WITH Ranked AS (
    SELECT
        BTT.Id AS BusinessTripTypeId,
        BTT.Label AS BusinessTripTypeLabel,
        HRDV.Id AS ExpenseItemId,
        HRDV.VariableType,
        HRDV.Label,
        HRDV.SequenceOrder,
        HRDV.Status,
        HRDV.InsertStamp,
        HRDV.InsertedBy,
        HRDV.UpdateStamp,
        HRDV.UpdatedBy,
        ROW_NUMBER() OVER (
            PARTITION BY BTT.Id, HRDV.Label
            ORDER BY HRDV.SequenceOrder, HRDV.Id
        ) AS rn
    FROM dbo.BusinessTripTypes BTT
    INNER JOIN dbo.BusinessTripAllowanceSchemeTypes BTAST
            ON BTAST.BusinessTripTypeId = BTT.Id
    INNER JOIN dbo.BusinessTripAllowanceSchemes BTAS
            ON BTAS.Id = BTAST.AllowanceSchemeId
    INNER JOIN dbo.BusinessTripAllowanceItems BTAI
            ON BTAI.SchemeId = BTAST.AllowanceSchemeId
    INNER JOIN dbo.HRDeskVariables HRDV
            ON HRDV.Id = BTAI.ExpenseItemId
    WHERE HRDV.VariableType = 'BusinessTripExpenseItems'
      AND HRDV.Status = 'Active'
      AND BTAS.Status = 'Active'
)
SELECT
    BusinessTripTypeId,
    BusinessTripTypeLabel,
    ExpenseItemId,
    VariableType,
    Label,
    SequenceOrder,
    Status,
    InsertStamp,
    InsertedBy,
    UpdateStamp,
    UpdatedBy
FROM Ranked
WHERE rn = 1;