SELECT
    recordItem.Id,
    recordItem.EvaluationRecordId,
    recordItem.EvaluationItemId,
    recordItem.Score,
    recordItem.Value,
    recordItem.Comments,
    evaluationItem.Label,
    evaluationItem.SequenceOrder,
    evaluationItem.EvaluationCategoryId,
    evaluationItem.AnswerTypeId,
    evaluationItem.ValueOptions
FROM
    dbo.PersonnelEvaluationRecordItems AS recordItem
        INNER JOIN dbo.EvaluationItems AS evaluationItem ON evaluationItem.Id = recordItem.EvaluationItemId
