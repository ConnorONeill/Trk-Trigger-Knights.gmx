///db_export(filename)
/*
    Exports the whole database to file. 
    The file can be imported later using db_import(file).
*/

var file,filename,orig_filename,table_name,data,table,tables;

filename = argument0;
file = file_text_open_write(filename);
tables = _db_info[? "tables"];

//write meta information
orig_filename = _db_info[? "filename"];
ds_map_delete(_db_info,"filename");
file_text_write_string(file,json_encode(_db_info));
_db_info[? "filename"] = orig_filename;

for(var i = 0; i < ds_list_size(tables); i++) {
    file_text_writeln(file);

    table_name = tables[| i];
    table = _db_tables[? table_name]
    data = table[? "data"];
    
    //write table structure
    ds_map_delete(table,"data");
    file_text_write_string(file,json_encode(table));
    file_text_writeln(file);
    
    //write table data
    if(data >= 0) {
        file_text_write_string(file,ds_grid_write(data));
    }
    
    table[? "data"] = data;
}

file_text_close(file);
