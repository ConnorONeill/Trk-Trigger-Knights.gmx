#define db_import
///db_import(filename,db_name)
/*
    Opens a new database with the data contained in the specified file (saved using db_export()).
    The current database gets closed in the process.
*/

var file,table,tables,data;

//if a database is open, close it
if(_db_info >= 0) {
    db_close();
}

//if database exists, load it
if(file_exists(argument0)) {
    file = file_text_open_read(argument0);
    
    //load database meta information
    _db_info = json_decode(file_text_read_string(file));
    _db_info[? "filename"] = argument1;
    _db_info[? "updated"] = true;
    file_text_readln(file);
    
    //read tables
    _db_tables = ds_map_create();
    while (!file_text_eof(file)) {
        //load table structure
        table = json_decode(file_text_read_string(file));
        
        //load table data
        file_text_readln(file);
        data = file_text_read_string(file);
        if(data != "") {
            table[? "data"] = ds_grid_create(1,1);
            ds_grid_read(table[? "data"],data);
        }
        else {
            table[? "data"] = -1;
        }
        
        ds_map_add_map(_db_tables,table[? "name"],table);
        table[? "updated"] = true;
        
        file_text_readln(file);
    }
    
    file_text_close(file);
    
    if(_db_settings[? "autosave"]) {db_save();}
    
    return true;
}
else {
    return false;
}

#define db_import_legacy
///db_import_legacy(filename,db_name)
/*
    Opens a new database with the data contained in the specified file saved from
    an older version of GMSDB (<= 3.1).
    The current database gets closed in the process.
*/

var file,table,data,index,old_index,columns,name,types;

//if a database is open, close it
if(_db_info >= 0) {
    db_close();
}

//create table map and database info
_db_info = ds_map_create();
_db_tables = ds_map_create();
_db_info[? "filename"] = argument1;
_db_info[? "updated"] = true;
ds_map_add_list(_db_info,"tables",ds_list_create());
ds_map_add_list(_db_info,"deleted_tables",ds_list_create());

file = file_text_open_read(argument0);
file_text_readln(file); //skip header line

while (!file_text_eof(file)) {
    table = ds_map_create();
    columns = ds_map_create();
    data = -1;
    old_index = ds_map_create();
    index = ds_list_create();
    types = ds_map_create();

    name = file_text_read_string(file);
    file_text_readln(file);
    ds_map_read(columns,file_text_read_string(file));
    file_text_readln(file);
    var table_data = file_text_read_string(file);
    if(table_data != "") {
        data = ds_grid_create(1,1);
        ds_grid_read(data,table_data);
    }
    file_text_readln(file);
    ds_map_read(old_index,file_text_read_string(file));
    file_text_readln(file);
    ds_map_read(types,file_text_read_string(file));

    //convert old index format to new
    index[| 0] = ds_map_size(old_index);
    key = ds_map_find_first(old_index);
    repeat (ds_map_size(old_index)) {
        index[| key] = old_index[? key];
        key = ds_map_find_next(old_index, key);
    }
    ds_map_destroy(old_index);
    
    ds_map_add(table,"data",data);
    ds_map_add_map(table,"types",types);
    ds_map_add_map(table,"columns",columns);
    ds_map_add_list(table,"index",index);

    table[? "name"] = name;
    table[? "updated"] = true;
    ds_map_add_map(_db_tables,name,table);
    ds_list_add(_db_info[? "tables"],name);

    file_text_readln(file);
}

file_text_close(file);

if(_db_settings[? "autosave"]) {db_save();}