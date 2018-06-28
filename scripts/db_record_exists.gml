///db_record_exists(table,id)
/*
    Returns true if the record with id is present into the database
*/

var table,index,row;

table = _db_tables[? argument0];
index = table[? "index"];
row = index[| argument1];

return !is_undefined(row) && row > -1;
