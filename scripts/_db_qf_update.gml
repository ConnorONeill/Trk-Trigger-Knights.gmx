///_db_qf_update(table,columns,values,rows)
/*
    INTERNAL USE ONLY. Helper function for db_query_exec. 
    Applies update function to a set of record indexes.
*/

var table,data,table_name,fields,values,rows,types,columns,row,col,field,value;

table_name = argument0
fields = string_parse(argument1,",",false);
values = csv_parse_line(argument2,",");
rows = argument3;
table = _db_tables[? table_name];
data = table[? "data"];
columns = table[? "columns"];
types = table[? "types"];

for(var i=0;i<ds_list_size(rows);i+=1) {
    row = rows[| i];
    for(var j=0;j<ds_list_size(fields);j+=1) {
        field = fields[| j];
        value = values[| j];
        col = columns[? field];
        if(types[? field] == "real") {
            data[# col,row] = real(value);
        }
        else {
            data[# col,row] = string(value);
        }
    }
}

ds_list_destroy(fields);
ds_list_destroy(values);

return ds_list_size(rows);
