///db_query_free(query)
/*
    Destroys a query freeing the memory used (only for queries where keep_query is set to true)
*/

var query;

query = argument0;

if(query[? "only"] >= 0) {
    ds_list_destroy(query[? "only"]);
}

ds_map_destroy(query);
