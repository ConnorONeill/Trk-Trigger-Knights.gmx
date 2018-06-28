///db_table_export_csv(table,path,separator)
/*
    Exports the table to a CSV file at the specified path. 
    Fields are separated by the separator character (usually ",").
*/

var table,data,csv,col,row,elem,columns;

table = _db_tables[? argument0];
data = table[? "data"];
columns = db_table_column_names(argument0);

csv = file_text_open_write(argument1);

//write column names
file_text_write_string(csv,csv_compose_line(columns,argument2));
file_text_writeln(csv);
ds_list_destroy(columns);

//write data if present
if(data >= 0) {
    elem = ds_list_create();
    for(row=0;row<ds_grid_height(data);row+=1) {
        ds_list_clear(elem);
        for(col=0;col<ds_grid_width(data);col+=1) {
            ds_list_add(elem,data[# col,row]);    
        }
        file_text_write_string(csv,csv_compose_line(elem,argument2));
     file_text_writeln(csv);
    }
    ds_list_destroy(elem);
}
file_text_close(csv);
