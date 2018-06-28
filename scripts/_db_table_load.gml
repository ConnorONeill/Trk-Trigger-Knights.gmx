///_db_table_load(table_name)
/*
    Loads an existing table data into the database, if not already loaded.
    
*/

var file,path,data,table,index,columns,name,types;

if(db_table_exists(argument0)) {return false;}

path = _db_table_get_path(argument0);
file = file_text_open_read(path);

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
table[? "updated"] = false;

ds_map_add_map(_db_tables,name,table);

return true;
