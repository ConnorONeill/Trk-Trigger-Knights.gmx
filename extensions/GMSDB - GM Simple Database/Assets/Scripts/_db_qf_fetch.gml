///_db_qf_fetch(table,only,where_script,where_fields,where_args,limit,offset,sort_enabled);
/*
    INTERNAL USE ONLY. Iterates through the records to find all the rows matching the query criteria
*/

var table_name,table,columns,index,rows,data;

table_name = argument0;

table = _db_tables[? table_name];
data = table[? "data"];
columns = table[? "columns"];
index = table[? "index"];

rows = ds_list_create();
if(data < 0) {return rows;} //if table empty, return empty list

var where_script,where_fields,where_args,where_data,only,limit,offset,sort;

only = argument1;
where_script = argument2;
if (where_script >= 0) {
    where_fields = _db_table_column_indexes(table_name,argument3);
    where_args = csv_parse_line(argument4,",");
    where_data = ds_list_create();
}
limit = argument5;
offset = argument6;
sort = argument7;

if(only < 0 && where_script < 0) { //no filters applied, fetch all rows
        var top = ds_grid_height(data)-1;
        var bottom = 0;
        if(!sort) { //if not sorting, limit and offset the results
            if(limit > 0) {top = min(limit+offset-1,ds_grid_height(data)-1);}
            bottom = offset;
        }
        
        var size = top - bottom + 1;
        
        for(var i=0;i<size;i+=1) {
            ds_list_add(rows,bottom+i);
        }
        
        return rows;
}

var add_row,row,row_count;

if(only < 0) {row_count = ds_grid_height(data);}
else {row_count = ds_list_size(only);}
    
for(var i=0;i<row_count;i+=1) {
    if(only < 0) {row = i;} //loop through all records
    else { //loop only through specified ids
       var rid = ds_list_find_value(only,i);
       row = index[| rid];
       if(is_undefined(row) || row < 0) {continue;}
    }
    
    add_row = true;
    if(where_script >= 0) {
        for(var j=0;j<ds_list_size(where_fields);j+=1) {
            ds_list_add(where_data,ds_grid_get(data,where_fields[| j],row));
        }
        add_row = script_execute(where_script,where_data,where_args);
        ds_list_clear(where_data);
    }
    
    if(add_row) {
        if(sort) {
            ds_list_add(rows,row);
        }
        else {
            if(offset > 0) {
                offset -= 1; 
                continue;
            }
            else {
                ds_list_add(rows,row);
                if(limit > 0 && ds_list_size(rows) >= limit) {break;}
            }
        }
    }
}


if (where_script >= 0) {
    ds_list_destroy(where_data);
    ds_list_destroy(where_fields);
    ds_list_destroy(where_args);
}

return rows;
