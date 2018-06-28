///db_record_get(table,id,column)
/*
    Finds the record with the provided id and returns the contents of the provided column.
    Returns undefined if the records is not found.
*/

var table,data,index,columns;

table = _db_tables[? argument0];
data = table[? "data"];
columns = table[? "columns"];
index = table[? "index"];

if(data < 0) {
    return undefined;
}

if(db_record_exists(argument0,argument1)) {
    var row = index[| argument1];
    var col = columns[? argument2];
    return ds_grid_get(data,col,row);
}
else {
    return undefined;
}
