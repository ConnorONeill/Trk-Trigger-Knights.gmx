index = argument0;
//if the current amount of cards in deck is bigger than the allocated row size place it on the row above
if(deckSpot > rowSize){
            cardP = instance_create(xSpot + (deckSpot-rowSize-1)*90,ySpot - cHeight/4,index);
         
        }else{
            cardP = instance_create(xSpot + deckSpot*90, ySpot, index);
        
        }
