///_db_qf_delete(table,rows)
/*
    INTERNAL USE ONLY. Helper function for db_query_exec. 
    Applies delete function to a set of record indexes.
*/

var table,table_name,rows,row,record_id,index,data;

table_name = argument0;
rows = argument1;

table = _db_tables[? table_name];
data = table[? "data"];
index = table[? "index"];

ds_list_sort(rows,true);

for(var i=0;i<ds_list_size(rows);i+=1) {
    row = rows[| i] - i;
    record_id = data[# 0,row];
    ds_grid_set_grid_region(data,data,0,row+1,ds_grid_width(data)-1,ds_grid_height(data)-1,0,row);
    if(ds_grid_height(data)-1 == 0) {
        ds_grid_destroy(data);
        ds_map_replace(table,"data",-1);
    }
    else {
        ds_grid_resize(data,ds_grid_width(data),ds_grid_height(data)-1);
    }
    index[| record_id] = -1; //set index for the id to -1
}

if(ds_list_size(rows) > 0) {
    _db_table_reindex(table_name); //reindex to keep track of grid changes
}

return ds_list_size(rows);
