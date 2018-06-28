///db_record_fetch(table,id,[columns])
/*
    Finds the record with the provided id and returns it ds_map representation.
    If no record is found with the provided id, -1 is returned.
    columns (optional) tell which columns to return (others are ignored).
*/

var table,data,index,columns,column_names,row,record_map,rid;

table = _db_tables[? argument[0]];
data = table[? "data"];
index = table[? "index"];
columns = table[? "columns"]
rid = argument[1];

if(argument_count > 2 && argument[2] != "") {
    column_names = string_parse(argument[2],",",false);
}
else {
    column_names = db_table_column_names(argument[0]);
}

row = index[| rid];

if(!is_undefined(row) && row > -1) {
    record_map = ds_map_create();
    record_map[? "_table"] = argument[0];
    
    for(var i=0; i<ds_list_size(column_names);i++) {
        var name = column_names[| i];
        var col = columns[? column_names[| i]];
        record_map[? name] = data[# col,row ];
    }
    
    if(!ds_map_exists(record_map,"id")) {record_map[? "id"] = argument[1];}
    
    ds_list_destroy(column_names);
    return record_map;
}
else {
    ds_list_destroy(column_names);
    return -1;
}
