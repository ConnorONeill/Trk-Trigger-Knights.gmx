///db_list_tables()
/*
    Returns a ds_list of all the tables (as table names) in the database
*/

var tables = ds_list_create();
ds_list_copy(tables,_db_info[? "tables"]);

return tables;
