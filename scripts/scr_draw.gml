// The deck number 0 unit, 1 equip, 2 spell
var num = argument0;
// the name of the deck array eg rDeck or bDeck
var col = argument1;

// the decklist of the chosen deck
decklist = col[num].deckList;
// the size of that decklist
deckSize = ds_list_size(col[num].deckList);
// the handvariable of the deck
handC = col[num].hand;
// if there is nothing in the hand do thing
if (col[num].cardInHand == false && deckSize > 0){
// the top of the deckList
    var cardDrawn = ds_list_find_value(decklist, 0);
        if (col[num].colour = "red"){
        // checks what colour deck is so it can place the card in the correct position
        handC = instance_create(hand1X+cWidth*num, handRY, cardDrawn);
        handC.colour = "red";
        }else{
        handC = instance_create(hand1X+cWidth*num, 0, cardDrawn);
        handC.colour = "blue";
        }

    // changes the position of the drawn card to hand
    handC.position = "hand";
    // tells the drawn card where it came from
    handC.deck = col[num];
    // delete the top of the deck    
    ds_list_delete(decklist,0);
    col[num].cardInHand = true;
}

