///db_open(name)
/*
    Opens a database, creating a new one if no such database exists, 
    or loading the database data otherwise.
    IMPORTANT: The name of the database can not contain spaces or special 
    characters other than _ (underscore).
*/

var file,tables,table,data;

//if a database is open, close it
if(_db_info >= 0) {
    db_close();
}

//if database exists, load it
if(file_exists(argument0+"/_db_info.json")) {

    //load database meta information
    file = file_text_open_read(argument0+"/_db_info.json");
    _db_info = json_decode(file_text_read_string(file));
    _db_info[? "filename"] = argument0;
    file_text_readln(file);
    file_text_close(file);

    //read tables
    _db_tables = ds_map_create();
    tables = _db_info[? "tables"];
    for(var i = 0; i < ds_list_size(tables); i++) {
        table = tables[|i];
        _db_table_load(table);
    }
}
//create new database
else { 
    _db_info = ds_map_create();
    _db_tables = ds_map_create();
    
    ds_map_add(_db_info,"filename",argument0);
    ds_map_add(_db_info,"updated",true);
    ds_map_add_list(_db_info,"tables",ds_list_create());
    ds_map_add_list(_db_info,"deleted_tables",ds_list_create());
}
