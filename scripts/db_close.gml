///db_close()
/*
    Closes the current database, freeing the memory from its data.
*/

var key,table,data;

key = ds_map_find_first(_db_tables);
repeat (ds_map_size(_db_tables)) {
    table = _db_tables[? key];
    data = table[? "data"];
    if(data >= 0) {ds_grid_destroy(data);}

    key = ds_map_find_next(_db_tables,key);
}

ds_map_destroy(_db_info);
ds_map_destroy(_db_tables);
_db_info = -1;
_db_tables = -1;
