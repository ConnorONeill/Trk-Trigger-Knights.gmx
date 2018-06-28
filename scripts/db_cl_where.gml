///db_cl_where(query,db_op_script,columns,args)
/*
    Adds or replaces a where clause to a query.
    Sets a filter condition to a query that will be applied to the result set on the specified fields.
    db_op_script is the name of one of the provided db_op_(name) scripts telling how the data is filtered.
    Example: db_cl_where(query,db_op_eq,"name,color","apple,green") //apply query only to green apples
*/

var query; 

query = argument0;

query[? "where_script"] = argument1;
query[? "where_fields"] = argument2;
query[? "where_args"] = argument3;

return query;
