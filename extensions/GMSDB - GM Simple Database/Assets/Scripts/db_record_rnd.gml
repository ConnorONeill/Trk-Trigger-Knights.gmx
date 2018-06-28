///db_record_rnd(table,n)
/*
    Returns a ds_list of n random valid ids from the specified table.
    Note that the list may contain duplicate ids. If you need a list of
    unique records, perform a query with random sorting.
    If n == 1, and id is returned instead of a ds_list.
    If the table is empty 0 is returned.
*/

var table,data;

table = _db_tables[? argument0];
data = table[? "data"];

if(argument1 == 1) {
    if(data < 0) {return 0;}
    else {
        return data[# 0,irandom(ds_grid_height(data)-1)];
    }
}
else {
    var ids = ds_list_create();
    if(data >= 0) {
        repeat(argument1) {
            ds_list_add(ids,data[# 0,irandom(ds_grid_height(data)-1)]);   
        }
    }
    return ids;
}
