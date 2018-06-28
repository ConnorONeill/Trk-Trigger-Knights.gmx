///_db_qf_sort(table,rows,sort_field,limit,offset)
/*
    INTERNAL USE ONLY. Sorts a ds_list of record indexes from a given set of parameters
*/

if(ds_list_empty(argument1)) {exit;}

if(argument2 == "RAND") {
    ds_list_shuffle(argument1);
    if(argument3 > 0 || argument4 > 0) { //limit list (offset ignored)
        var new_rows = ds_list_create();
        var top = min(argument3,ds_list_size(argument1));
        for(var i=0; i<top; i+=1) {
            new_rows[| i] = argument1[| i];
        }
        ds_list_copy(argument1,new_rows);
        ds_list_destroy(new_rows);
    }
    exit;
}

var table,data,columns,rows,sort_fields,sort_order,limit,offset,grid,params;

table = _db_tables[? argument0];
data = table[? "data"];
columns = table[? "columns"];


rows = argument1;
params = string_parse(argument2,",",false);
limit = argument3;
offset = argument4;
sort_fields = ds_list_create();
sort_order = ds_list_create();

//prepare fields
for(var i=0;i<ds_list_size(params);i++) {
    var p = params[| i];
    ds_list_add(sort_fields,columns[? pair_get(p,":",0)]);
    ds_list_add(sort_order,pair_get(p,":",1));
}

//create sortable row grid
grid = ds_grid_create(ds_list_size(sort_fields)+1,ds_list_size(rows));

for(var i=0;i<ds_list_size(rows);i+=1) {
    ds_grid_set(grid,0,i,rows[| i]);
    for(var c=0;c<ds_list_size(sort_fields);c+=1) {
        ds_grid_set(grid,c+1,i,data[# sort_fields[| c],rows[| i]]);
    }
}

switch(ds_list_size(sort_fields)) {
    case 1:     ds_grid_multisort(grid,1,sort_order[| 0]!="desc"); break;
    case 2:     ds_grid_multisort(grid,1,sort_order[| 0]!="desc",2,sort_order[| 1]!="desc"); break;
    case 3:     ds_grid_multisort(grid,1,sort_order[| 0]!="desc",2,sort_order[| 1]!="desc",3,sort_order[| 2]!="desc"); break;
    default:    ds_grid_multisort(grid,1,sort_order[| 0]!="desc",2,sort_order[| 1]!="desc",3,sort_order[| 2]!="desc",4,sort_order[| 3]!="desc");
}

ds_list_destroy(params);
ds_list_destroy(sort_fields);
ds_list_destroy(sort_order);

//reset rows list and apply limit and offset
ds_list_clear(rows);
var top = ds_grid_height(grid);
if(limit > 0) {top = min(limit+offset,ds_grid_height(grid));}

for(var i=offset;i<top;i+=1) {
    ds_list_add(rows,grid[# 0,i]);
}

//cleanup
ds_grid_destroy(grid);
