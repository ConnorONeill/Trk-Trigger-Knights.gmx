player = argument0;
//Do main phase
//All the events that take place when pressing rmb
if(mouse_check_button_pressed(mb_right)){
//Events that happen with selected card
if(selCard != noone){
//Events with cards in the hand
    if(selCard.position == "hand" && selCard.deck.colour == player.colour){
    //do a mulligan
        if(selCard == hoverCard){
            if(player.mul>0){
            scr_mulligan(selCard);
            player.mul = player.mul - 1;
            selCard = noone;
            }else if(player.mul == 0 && player.exDraw > 0 && player.gold > 0){
            scr_mulligan(selCard);
            player.exDraw = player.exDraw - 1;
            player.gold = player.gold - 1
            selCard = noone;
            }      
        }
    //play unit from hand onto field
        if(hoverNode != noone && hoverNode.colour == player.colour && selCard.type == types.unit && hoverNode.occupant == noone && player.gold - selCard.cost >= 0){
           selCard.gridX = hoverNode.gridX;
           selCard.gridY = hoverNode.gridY;
           selCard.x = hoverNode.x;
           selCard.y = hoverNode.y;
           selCard.deck.hand = noone;
           selCard.deck.cardInHand = false;
           hoverNode.occupant = selCard;
           player.gold = player.gold - selCard.cost;
           selCard.position = "field";       
        }   
    }
}
if(selDeck != noone && selDeck == hoverDeck && selDeck.colour == player.colour && player.exDraw >= 1 && player.gold >= 1 && selDeck.cardInHand == false){
        scr_drawWithID(selDeck);
        player.gold = player.gold - 1;
        player.exDraw = player.exDraw;
    }
if(selNode != noone && hoverNode != noone && selNode.colour == player.colour){
    scr_moveUnit();
}
}

if(mouse_check_button_pressed(mb_left)){
    
    if(hoverEndTurn != noone){
        scr_endTurn();
    }
    
    
}








