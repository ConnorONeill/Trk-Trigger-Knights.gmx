type = argument0;

if(type == 0){
    tbl = "tblUnits";
    obj = obj_unit;
    page = uPage;
    pages = uPages;
    pageStart = uPageStart;
    pageEnd = uPageEnd;
    ySpot = unitYSpot;
    
}

if(page < pages){
    with(obj){
        if(position == "deckBuilder"){
            instance_destroy(id);
        }
    }
    with(obj_blank){
        instance_destroy(id);
    }
    pageStart = pageStart + pageSize;
    pageEnd = pageEnd + pageSize;
    n = 1;
    for(i = uPageStart; i < uPageEnd; i += 1){
        BuilderArray[i] = noone;
        //if record exists create the card else create a blank also put in array
        if(db_record_exists(tbl,i+1)){
            name = db_record_get(tbl,n,"objName");
            builderArray[i] = asset_get_index(name);
            card = instance_create(deckBuildX+(n-1)*180,ySpot,builderArray[i]);
            card.position = "deckBuilder";
        }else{
            builderArray[i] = obj_blank;
            instance_create(deckBuildX+(n-1)*180,ySpot,builderArray[i])
        }
        n += 1;
    }
    
    
    
}    


