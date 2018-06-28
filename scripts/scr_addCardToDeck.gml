//type of the card (unit equip spell)
type = argument0;
//if type of card added is a unit
if(type == types.unit){
    tblIn = "tblUnitsInDeck";
    tbl = "tblUnits";
    xSpot = unitXSpot;
    ySpot = unitYSpot;
    deckSize = unitDeckSize;
}
//get the card in deck id
query = db_query_select_ids(tblIn);
db_cl_where(query,db_op_eq,"cardId,deckId",string(string(hoverCard.qId)+","+string(deckId)));
results = db_query_exec(query);
usedId = ds_list_find_value(results, 0);
//if it doesn't exist create it
if(is_undefined(usedId)){
    //create the record
    usedId = db_record_create(tblIn,"cardId",hoverCard.qId);
    db_record_update(tblIn,usedId,"cardId",hoverCard.qId);
    db_record_update(tblIn,usedId,"deckId",deckId);
    db_record_update(tblIn,usedId,"quantity",1);
    //create it on the screen
    scr_cardToDeckBuild(hoverCard.objIndex);
    cardP.position = "deckIn";
    deckSpot += 1;

}else 
//if it does exist add 1 to quantity
if(!is_undefined(usedId)){
    quan = db_record_get(tblIn,usedId,"quantity");
    maxQuan = db_record_get(tbl,hoverCard.qId,"maxQuan");
    //if quantity is less than the max amount of copies you can have in a deck
    if(quan<maxQuan){
    //increase quantity
        db_record_update(tblIn,usedId,"quantity",quan+1);
        //create and instance
        scr_cardToDeckBuild(hoverCard.objIndex);
        //put it in the deck
        cardP.position = "deckIn";
        deckSpot += 1;
        }
}



/*    
query = db_query_select_ids(tblIn);
db_cl_where(query,db_op_eq,"cardId",hoverCard.qId);
db_cl_where(query,db_op_eq,"deckId",deckId);
results = db_query_exec(query);
usedId = ds_list_find_value(results, 0);

if(!is_undefined(usedId)){
    usedId = db_record_create(tblIn,"cardId","deckId","quantity",hoverCard.qId,deckId,1);
}
query = db_query_select_ids(tblIn);
results = db_query_exec(query);
size = ds_list_size(results);
if(size<deckSize){
    quan = db_record_get(tblIn, usedId, "quantity");
    //change dis later
    if(quan <= 4){
        db_record_update(tblIn,usedId,"quantity",quan+1);
        if(deckSpot >= rowSize){
            cardP = instance_create(xSpot + (deckSpot-rowSize)*90,ySpot + cHeight,hoverCard.objIndex);
        }else{
            cardP = instance_create(xSpot + (deckSpot)*90,ySpot,hoverCard.objIndex);
        }
        cardP.position = "deckIn";
        deckSpot += 1;
    }
}


    
    
    
    
    
