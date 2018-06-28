///db_record_destroy(record_map)
/*
    Deletes the specified record from the database, and destroys its ds_map representation.
    If you just want to delete the record form the database, see db_record_delete
*/

var record = argument0;

db_record_delete(record[? "_table"],record[? "id"]);
ds_map_destroy(record);
