//put a card to the bottom of the deck
//chosen card instance
var card = argument0;
//put it to the bottom of its origin deckList
ds_list_add(card.deck.deckList,card.objRef);
//if the card is in the hand
if (card.position = "hand"){
    //get rid of the card that was in the hand
    card.deck.hand = noone;
    cDeck = card.deck;
    instance_destroy(card);
    //get the top of the list, create it and put it in the hand
    cardDrawn =  ds_list_find_value(cDeck.deckList, 0);
    cDeck.hand = instance_create(cDeck.handX, cDeck.handY, cardDrawn);
    cDeck.hand.position = "hand";
    //make sure it knows where it came from
    cDeck.hand.deck = cDeck;
    //get rid of it from the decklist
    ds_list_delete(cDeck.deckList, 0);
}

