//type of card 0 unit 1 equip 2 spell
type = argument0;
//if the card/s being deleted is a unit give the script these variables
if(type == 0){
    tblIn = "tblUnitsInDeck";
    object = obj_unit;
}         
//find the id in the deck with the current deck id and chosen card id gotten from the mouse          
query = db_query_select_ids(tblIn);
db_cl_where(query,db_op_eq,"cardId,deckId",string(string(hoverCard.qId)+","+string(deckId)));
results = db_query_exec(query);
rowId = ds_list_find_value(results,0);
//get its quantity
quan = db_record_get(tblIn,rowId,"quantity");
//if it has 1 quantity it would be reduced to 0 so delete it from the database
if(quan = 1){
    db_record_delete(tblIn,rowId);
}else
if(quan > 1){
//if more than 1 reduce quantity by 1
    db_record_update(tblIn,rowId,"quantity",quan-1);
}
//destroy all of that type of card that is in the deck
with(object){
    if(position = "deckIn"){
        instance_destroy(id);
        }
    }
//recreate with the new quantity
scr_createCardsFromDeck(type);
