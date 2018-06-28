///db_free()
/*
    Cloeses the current database and frees the database system.
    After this call, to use the database again you have to init the system again using db_init()
*/

db_close();
ds_map_destroy(_db_settings);
