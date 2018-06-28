///db_record_update(table,id,columns,values)
/*
    Updates the value in the specified column(s) of record id.
    Returns true if successful, false otherwise.
    You can specify multiple columns (and values) to update by using a comma
    separated string of columns and values.
    Example: db_record_update("fruits",record_id,"color,weight","green,30")
*/

var table,data,index,types,columns;


table = _db_tables[? argument[0]];
data = table[? "data"];
columns = table[? "columns"];
index = table[? "index"];
types = table[? "types"];


if(data < 0) {return false;}
if(!db_record_exists(argument[0],argument[1])) {return false;}


var fields,values,row;

fields = string_parse(argument[2],",",false);
row = index[| argument[1]];

if(ds_list_size(fields) == argument_count - 3) { //values passed as arguments
    values = ds_list_create();
    for(var i=3;i<argument_count;i+=1) {
        ds_list_add(values,argument[i]);
    }
}
else { //values passed as string
    values = csv_parse_line(argument[3],",");
}

for(var i=0;i<ds_list_size(fields);i+=1) {
    var field = fields[| i];
    var value = values[| i];
    var col = columns[? field];
        
    if(types[? field] == "real") {
        data[# col,row] = real(value);
    }
    else {
        data[# col,row] = string(value);
    }
}

ds_list_destroy(values);
ds_list_destroy(fields);

table[? "updated"] = true;
if(_db_settings[? "autosave"]) {db_save();}

return true;
