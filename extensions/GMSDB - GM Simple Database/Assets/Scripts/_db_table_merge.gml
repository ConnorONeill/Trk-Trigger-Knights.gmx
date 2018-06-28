///_db_table_merge(t1,t2,name,foreign_key)
/*
    INTERNAL USE ONLY! Merges to tables into a new one. Needed by join query clause. 
*/

var t1,t1_data,t1_name,t1_columns,t1_types,t1_index;
t1_name = argument0;
t1 = _db_tables[? t1_name];
t1_data = t1[? "data"];
t1_index = t1[? "index"];
t1_columns = t1[? "columns"];
t1_types = t1[? "types"];

var t2,t2_data,t2_name,t2_columns,t2_types,t2_index;
t2_name = argument1;
t2 = _db_tables[? t2_name];
t2_data = t2[? "data"];
t2_index = t2[? "index"];
t2_columns = t2[? "columns"];
t2_types = t2[? "types"];

var t3,t3_data,t3_name,t3_columns,t3_types,t3_index;
t3_name = argument2;
t3 = ds_map_create();
t3[? "name"] = t3_name;
if(t1_data >= 0) {
    t3_data = ds_grid_create(ds_map_size(t1_columns)+ds_map_size(t2_columns),ds_grid_height(t1_data));
    ds_grid_clear(t3_data,undefined);
}
else {
    t3_data = -1;
}
t3_columns = ds_map_create(); ds_map_add_map(t3,"columns",t3_columns);
t3_types = ds_map_create(); ds_map_add_map(t3,"types",t3_types);
t3_index = ds_list_create(); ds_map_add_list(t3,"index",t3_index);
t3[? "data"] = t3_data;


//merge table values
if(t1_data >= 0) {
    var foreign_key 
    foreign_key = t1_columns[? argument3];
    ds_grid_set_grid_region(t3_data,t1_data,0,0,ds_grid_width(t1_data)-1,ds_grid_height(t1_data)-1,0,0);
    if(t2_data >= 0) {
        for(var t1_row=0;t1_row<ds_grid_height(t1_data);t1_row+=1) {
            if(db_record_exists(t2_name,t1_data[# foreign_key,t1_row])) {
                var t2_row = t2_index[| t1_data[# foreign_key,t1_row]];
                ds_grid_set_grid_region(t3_data,t2_data,0,t2_row,ds_grid_width(t2_data),t2_row,ds_grid_width(t1_data),t1_row);
            }
        }
    }
}

//merge column names
var t1_cnames,t2_cnames;
t1_cnames = db_table_column_names(t1_name);
t2_cnames = db_table_column_names(t2_name);
for(var i=0;i<ds_list_size(t1_cnames);i+=1) {
    var n = t1_cnames[| i];
    ds_map_add(t3_columns,t1_name+"."+n,i);
    ds_map_add(t3_types,t1_name+"."+n,t1_types[? n]);
}
for(var i=0;i<ds_list_size(t2_cnames);i+=1) {
    var n = t2_cnames[| i];
    ds_map_add(t3_columns,t2_name+"."+n,i+ds_list_size(t1_cnames));
    ds_map_add(t3_types,t2_name+"."+n,t2_types[? n]);
}
ds_list_destroy(t1_cnames);
ds_list_destroy(t2_cnames);

//copy index
ds_list_copy(t3_index,t1_index);

//add to tables
ds_map_add_map(_db_tables,t3_name,t3);
