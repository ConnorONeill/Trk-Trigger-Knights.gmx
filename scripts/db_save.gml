///db_save()
/*
    Saves the current database to file, so that it can be opened later with db_open.
*/

var file,filename,tables,deleted_tables,data,table;

filename = _db_info[? "filename"];
tables = _db_info[? "tables"];
deleted_tables = _db_info[? "deleted_tables"];

//create database directory if not present
if(!directory_exists(filename)) {
    directory_create(filename);
}

//check if a table has been deleted
for(var i = 0; i < ds_list_size(deleted_tables); i++) {
    var table_file = _db_table_get_path(deleted_tables[| i]);
    if(file_exists(table_file)) {file_delete(table_file);}
}
ds_list_clear(deleted_tables);

//write info file
if(_db_info[? "updated"]) {
    file = file_text_open_write(filename+"/_db_info.json");
    file_text_write_string(file,json_encode(_db_info));
    file_text_close(file);
    _db_info[? "updated"] = false;
}

//write data files
for(var i = 0; i < ds_list_size(tables); i++) {
    table = tables[|i];
    var t = _db_tables[? table];
    if(t[? "updated"]) {
        _db_table_save(table);
        t[? "updated"] = false;
    }
}
