///db_record_save(record_ds_map)
/*
    Saves the data of the provided record ds_map (as obtained from db_record_fetch
    or db_record_build) to the database.
    If it's a new record, the data is insered, otherwise the record is just
    updated.
*/

var table_name,table,data,index,columns,types,record_map,record_id,row,new_record;

record_map = argument0;
record_id = record_map[? "id"];

table_name = record_map[? "_table"];

table = _db_tables[? table_name];
data = table[? "data"];
index = table[? "index"];
types = table[? "types"];

if(record_id > 0) { //if updating
    if(is_undefined(index[| record_id]) || index[| record_id] < 0) {
        return false; //record has been deleted or does not exists
    }
}

columns = db_table_column_names(table_name);

//fetch or create row
if(record_id <= 0) { //create record
    new_record = true;
    record_id = index[| 0]+1;
    record_map[? "id"] = record_id;
    row = db_table_size(table_name);
    
    if(data < 0) { //table empty, create it!
        data = ds_grid_create(ds_list_size(columns),1);
        table[? "data"] = data;
    }
    else {
        ds_grid_resize(data,ds_grid_width(data),ds_grid_height(data)+1);
    }
    
    index[| record_id] = row;
    index[| 0] += 1;
}
else {
    new_record = false;
    row = index[| record_id];
}

//insert data
for(var i=0; i<ds_list_size(columns);i++) {
    var col_name = columns[| i];
    if(ds_map_exists(record_map,col_name)) {
        var value = record_map[? col_name];
        if(types[? col_name] == "real") {value = real(value);}
        else {value = string(value);}
        data[# i,row] = value;
    }
}

ds_list_destroy(columns);

table[? "updated"] = true;
if(_db_settings[? "autosave"]) {db_save();}

return true;
