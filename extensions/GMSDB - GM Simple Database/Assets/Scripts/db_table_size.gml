///db_table_size(table)
/*
    Returns the number of records in a table
*/

var table,data;

table = _db_tables[? argument0];
data = table[? "data"];

if(data < 0) {
    return 0;
}
else {
    return ds_grid_height(data);
}
