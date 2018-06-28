//if the card/s being created is a unit give the script these variables
type = argument0;
if(type == 0){
    deckSize = unitDeckSize;
    xSpot = unitXSpot;
    ySpot = unitYSpot;
    tblIn = "tblUnitsInDeck";
    tbl = "tblUnits";
}

//the spot in the deck
deckSpot = 0;


//get the id of all the cards in the table where the deckId is equal to the current deck id
query = db_query_select_ids(tblIn);
db_cl_where(query,db_op_eq,"deckId",deckId);
cardIds = db_query_exec(query);

//get the size of deck deck and loop creating cards from the deck while i<decksize
for(i=0; i<deckSize; i+=1){
//find the value of the i id of the above query
    usedId = ds_list_find_value(cardIds, i);
//if the id exists
    if(!is_undefined(usedId)){
        if(db_record_exists(tblIn, usedId)){
            // ge the card id and quantity
            cardId = db_record_get(tblIn, usedId, "cardId");
            cardQ = db_record_get(tblIn, usedId, "quantity");
            //using the gotten id get the object name and get its gm index
            objIndex = asset_get_index(db_record_get(tbl, cardId, "objName"));
            for(q = 0; q < cardQ; q += 1){
            //create that card index in the appropriate position
                scr_cardToDeckBuild(objIndex);
            //let it know where it is
                cardP.position = "deckIn";
            //increase the deckspot
                deckSpot += 1;                
            }
        }       
    }

}
