///db_record_first(table,column,value)
/*
    Returns the id of the first record having value at the specified column, 
    or 0 if no record found.
*/

var table,data,columns,column;

table = _db_tables[? argument0];
data = table[? "data"];
columns = table[? "columns"];
column = columns[? argument1];

if(data < 0) {
    return 0;
}

if(ds_grid_value_exists(data,column,0,column,ds_grid_height(data)-1,argument2)) {
    var row = ds_grid_value_y(data,column,0,column,ds_grid_height(data)-1,argument2);
    return data[# 0,row];
}
else {
    return 0;
}
