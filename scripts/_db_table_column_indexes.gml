///_db_table_column_indexes(table,columns)
/*
    Given a string with comma separated column names, returns a ds_list of column indexes.
    INTERNAL USE ONLY.
*/

var table,columns,column_names,column_indexes;

table = _db_tables[? argument0];
columns = table[? "columns"];

column_indexes = ds_list_create();
column_names = string_parse(argument1,",",false);

for(var i=0; i<ds_list_size(column_names); i+=1) {
    ds_list_add(column_indexes,columns[? ds_list_find_value(column_names,i)]);
}

ds_list_destroy(column_names);

return column_indexes;
