///_db_table_reindex(table)
/*
    Rebuils the index of the table. Used internally.
*/

var index,data,table,t_id;

table = _db_tables[? argument0];
data = table[? "data"];
index = table[? "index"];

if(data >= 0) {
    for(var i=0;i<ds_grid_height(data);i+=1) {
        t_id = data[# 0,i];
        index[| t_id] = i;
    }
}
