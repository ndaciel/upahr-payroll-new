
select 
	a.* ,
	b.Label SchemeName
	, (select count(*) from (select distinct RowNumber from HRImportLogDetails where a.Id = LogId) tb) RowsCount
	, (select count(*) from (select distinct RowNumber from HRImportLogDetails where a.Id = LogId and Status='Valid' ) tb) ValidCount
	, (select count(*) from (select distinct RowNumber from HRImportLogDetails where a.Id = LogId and Status='Invalid') tb) InvalidCount
from HRImportLogs a
left join HRImportSchemes b on a.SchemeId = b.Id