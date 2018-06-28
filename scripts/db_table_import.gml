///db_table_import(path)
/*
    Imports a table from a file exported using db_table_export.
    If the table already exists, it is replaced.
*/

var file,data,table,name;

file = file_text_open_read(argument0);

    //load table structure
    table = json_decode(file_text_read_string(file));
    file_text_readln(file);
    
    //load table data
    data = file_text_read_string(file);
    if(data != "") {
        table[? "data"] = ds_grid_create(1,1);
        ds_grid_read(table[? "data"],data);
    }
    else {
        table[? "data"] = -1;
    }

file_text_close(file);

name = table[? "name"];

if(db_table_exists(name)) {db_table_delete(name);}

ds_map_add_map(_db_tables,name,table);
ds_list_add(_db_info[? "tables"],name);

_db_info[? "updated"] = true;
table[? "updated"] = true;

if(_db_settings[? "autosave"]) {db_save();}
