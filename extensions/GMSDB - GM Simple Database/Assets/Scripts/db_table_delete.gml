///db_table_delete(table)
/*
    Deletes a table and all its data from the database.
*/

var table,data;

table = _db_tables[? argument0];
data = table[? "data"];

if(data >= 0) {
    ds_grid_destroy(data);
}

ds_map_destroy(table);
ds_map_delete(_db_tables,argument0);

//remove the table from the database metadata
var i = ds_list_find_index(_db_info[? "tables"],argument0);
if(i >= 0) {
    ds_list_delete(_db_info[? "tables"],i);
    _db_info[? "updated"] = true;
}

//add the table to the deleted list
if(ds_list_find_index(_db_info[? "deleted_tables"],argument0) < 0) {
    ds_list_add(_db_info[? "deleted_tables"],argument0);
}

if(_db_settings[? "autosave"]) {db_save();}
