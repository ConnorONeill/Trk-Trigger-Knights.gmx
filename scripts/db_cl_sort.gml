///db_cl_sort(query,column:order,[column:order],...)
/*
    Adds or replaces a sort clause to a query.
    You can specify a maximum of 4 sorting criteria, in order of priority. 
    If you pass RAND as first argument1, results are sorted randomly.
    Example 1: db_cl_sort(query,"name:desc")
    Example 2: db_cl_sort(query,"name:desc","weight:asc")
    Example 3: db_cl_sort(query,"RAND")
*/

var query; 

query = argument[0];

if(argument_count > 2) {
    var args = ds_list_create();
    for(var i=1;i<argument_count;i+=1) {
        ds_list_add(args,argument[i]);
    }
    query[? "sort_field"] = csv_compose_line(args,",");
    ds_list_destroy(args);
}
else {
    query[? "sort_field"] = argument[1];
}

return query;
