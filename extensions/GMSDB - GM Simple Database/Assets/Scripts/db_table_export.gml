///db_table_export(table,path)
/*
    Saves a table to file. The file can be later imported with db_table_import.
*/

var file,data,table;

table = _db_tables[? argument0];
data = table[? "data"];

file = file_text_open_write(argument1);
    
    //write table structure
    ds_map_delete(table,"data");
    file_text_write_string(file,json_encode(table));
    file_text_writeln(file);
    
    //write table data
    if(data >= 0) {
        file_text_write_string(file,ds_grid_write(data));
    }
    
    table[? "data"] = data;

file_text_close(file);
