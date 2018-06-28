///db_record_delete(table,id)
/*
    Deletes record with id from the database table.
    Returns false if record is not found, true otherwise.
    If you want to delete a record represented as a ds_map, see db_record_destroy()
*/

var table,data,index,record_id;

table = _db_tables[? argument0];
data = table[? "data"];
index = table[? "index"];

record_id = argument1;

if(data < 0) {
    return false;
}

if(db_record_exists(argument0,record_id)) {
    var row = index[| record_id];
    ds_grid_set_grid_region(data,data,0,row+1,ds_grid_width(data)-1,ds_grid_height(data)-1,0,row);
    if(ds_grid_height(data)-1 == 0) {
        ds_grid_destroy(data);
        ds_map_replace(table,"data",-1);
    }
    else {
        ds_grid_resize(data,ds_grid_width(data),ds_grid_height(data)-1);
    }
    index[| record_id] = -1; //set index for the id to -1
    _db_table_reindex(argument0);
    
    table[? "updated"] = true;
    if(_db_settings[? "autosave"]) {db_save();}
    
    return true;
}
else {
    return false;
}
