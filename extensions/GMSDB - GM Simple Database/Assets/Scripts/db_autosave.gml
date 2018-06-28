///db_autosave([enabled])
/*
    If autosave is enabled, the database is saved to file every time its data
    or its structure changes.
    enabled (optional) can be either true or false. If no argument is provided instead, 
    the current value of autosave is returned.
*/

if(argument_count > 0) {
    _db_settings[? "autosave"] = argument[0];
    if(argument[0]) {db_save();}
}
else {
    return _db_settings[? "autosave"];
}
