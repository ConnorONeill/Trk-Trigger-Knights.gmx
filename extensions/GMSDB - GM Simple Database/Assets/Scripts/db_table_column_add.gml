///db_table_column_add(table,column_name,type,default)
/*
    Adds a column to a table.
    type is either "real" or "string", telling the column type.
    default is the value to insert in the new column for all existing records.
*/

var columns,types,table,def,data;

table = _db_tables[? argument0];
data = table[? "data"];
columns = table[? "columns"];
types = table[? "types"];

if(argument2 == "real") {def = real(argument3);}
else {def = string(argument3);}

if(!ds_map_exists(columns,argument1)) {
    ds_map_add(columns,argument1,ds_map_size(columns));
    ds_map_add(types,argument1,argument2);
    if(data >= 0) {
        ds_grid_resize(data,ds_grid_width(data)+1,ds_grid_height(data));
        ds_grid_set_region(data,ds_grid_width(data)-1,0,ds_grid_width(data)-1,ds_grid_height(data)-1,def);
    }
    
    table[? "updated"] = true;
    if(_db_settings[? "autosave"]) {db_save();}
}
