///db_table_clear(table)
/*
    Deletes all the records in a table, resetting the index but preserving the table structure.
*/

var table,data,index;


table = _db_tables[? argument0];
data = table[? "data"];
index = table[? "index"];

ds_list_clear(index);
index[| 0] = 0;

if(data >= 0) {
    ds_grid_destroy(data);
    ds_map_replace(table,"data",-1);
}

table[? "updated"] = true;
if(_db_settings[? "autosave"]) {db_save();}
