///db_table_import_csv(table,path,separator)
/*
    Adds the contents of a CSV file into the specified table.
    The CSV file has to be formatted as in the result of db_table_export_csv, where
    the first row (containing labels) and the first column (ids) are ignored.
    Note that existing contents in the table are left untouched.
*/

var csv,values,autosave;

//disable autosave
autosave = db_autosave();
db_autosave(false);

csv = file_text_open_read(argument1);
file_text_readln(csv); //skip labels
while(!file_text_eof(csv)) {
    //parse the line and recompose it (deleting the id value)
    values = csv_parse_line(file_text_read_string(csv),argument2);
    ds_list_delete(values,0); //remove id value
    
    db_record_create(argument0,csv_compose_line(values,","));
    
    ds_list_destroy(values);
    file_text_readln(csv);
}
file_text_close(csv);

db_autosave(autosave);

