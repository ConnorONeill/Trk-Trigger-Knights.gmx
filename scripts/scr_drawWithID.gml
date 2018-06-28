sDeck = argument0;
deckSize = ds_list_size(sDeck.deckList);

if (sDeck.cardInHand == false && deckSize>0){
//the top of the deckList
    var cardDrawn = ds_list_find_value(decklist,0);
        if (sDeck.colour = "red"){
//checks what colour deck is so it can place the card in the correct position
        sDeck.hand = instance_create(sDeck.handX, sDeck.handY, cardDrawn);
        sDeck.hand.colour = "red";
        }else{
        sDeck.hand = instance_create(sDeck.handX, sDeck.handY, cardDrawn);
        sDeck.hand.colour = "blue";
        }
     sDeck.hand.position = "hand";
     sDeck.hand.deck = sDeck;
     ds_list_delete(sDeck.deckList,0);
     sDeck.cardInHand = true;
}
