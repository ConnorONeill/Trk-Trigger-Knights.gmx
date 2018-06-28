///db_init()
/*
    Initializes the database system creating the required data structures.
    Should be called only once per game run, unless db_free is used.
*/

globalvar _db_info,_db_tables,_db_settings;

_db_settings = ds_map_create();
_db_info = -1;
_db_tables = -1;

_db_settings[? "autosave"] = false;
