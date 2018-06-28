#define db_query_select
///db_query_select(table,[columns])
/*
    Prepares a query for selecting values in the specified columns of a table.
    If only id is provided as column, the query will return a ds_list of ids.
    Returns: query
*/

var query;

query = _db_query_init();

query[? "table_name"] = argument[0];
query[? "function"] ="select";
if(argument_count > 1) {
    query[? "fields"] = argument[1];
}
else {
    query[? "fields"] = "";
}

return query;

#define db_query_select_ids
///db_query_select_ids(table)
/*
    Prepares a query for selecting values in the specified columns of a table.
    If only id is provided as column, the query will return a ds_list of ids.
    Returns: query
*/

var query;

query = _db_query_init();

query[? "table_name"] = argument[0];
query[? "function"] ="select_ids";
query[? "fields"] = "";

return query;

#define db_query_select_records
///db_query_select_records(table,[columns])
/*
    Prepares a query for selecting values in the specified columns of a table.
    If only id is provided as column, the query will return a ds_list of ids.
    Returns: query
*/

var query;

query = _db_query_init();

query[? "table_name"] = argument[0];
query[? "function"] ="select_records";
if(argument_count > 1) {
    query[? "fields"] = argument[1];
}
else {
    query[? "fields"] = "";
}

return query;