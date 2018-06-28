///db_record_fetch_all(table,ids_list,[columns])
/*
    Returns a ds_list of records matching the provided ids. 
    Each record is a ds_map representation of its data.
    Deleting the returned ds_list automatically deletes also the records ds_maps.
    columns (optional) tells which specific columns to return (others are ignored).
*/

var table,data,index,column_names,columns,ids,records;

table = _db_tables[? argument[0]];
data = table[? "data"];
index = table[? "index"];
columns = table[? "columns"];

if(argument_count > 2 && argument[2] != "") {
    column_names = string_parse(argument[2],",",false);
}
else {
    column_names = db_table_column_names(argument[0]);
}

ids = argument[1];
records = ds_list_create();

for(var i=0; i<ds_list_size(ids);i++) {
    var rid = ids[| i];
    var row = index[| rid];
    if(!is_undefined(row) && row > -1) {
        var record_map = ds_map_create();
        record_map[? "_table"] = argument[0];
       
        for(var j=0; j<ds_list_size(column_names);j++) {
            var name = column_names[| j];
            var col = columns[? name];
            record_map[? name] = data[# col,row ];
        }
    
        if(!ds_map_exists(record_map,"id")) {record_map[? "id"] = rid;}
         
        ds_list_add(records,record_map);
        ds_list_mark_as_map(records,ds_list_size(records)-1);
    }
}

ds_list_destroy(column_names);
return records;
