///db_cl_limit(query,limit,offset)
/* 
    Adds or replaces a limit clause to a query, limiting and offsetting the affected records. 
    Setting limit or offset to 0 applies no limit or offset respectively.
*/
    
var query;

query = argument0;

query[? "limit"] = argument1;
query[? "offset"] = argument2;

return query;
