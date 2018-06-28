///db_query_delete(table)
/*
    Prepares a query to perform a deletion of records from the database.
*/

var query;

query = _db_query_init();

query[? "table_name"] = argument0;
query[? "function"] = "delete";

return query;
