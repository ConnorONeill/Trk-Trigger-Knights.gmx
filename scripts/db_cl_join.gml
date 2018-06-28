///db_cl_join(query,join_table,foreign_key)
/* 
    Adds or replaces a join clause to a query.
    This merges the queried table data with another table, based on a column
    holding the join table id.
    join_table is the name of the table to join. 
    foreign_key is the column in the main table holding the id of the join table record.
*/

var query;
query = argument0;

query[? "join_table_name"] = argument1;
query[? "foreign_key"] = argument2;

return query;
