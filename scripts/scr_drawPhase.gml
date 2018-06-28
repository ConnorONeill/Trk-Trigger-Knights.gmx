deck = argument0;

//up the turn counter
turnCount += 1;

//draw cards from the red decks if hand is empty
for(i=0; i<3; i+=1){
scr_draw(i,deck);
}

//add chance for player and opp to respond here later

global.phase = phases.income;
