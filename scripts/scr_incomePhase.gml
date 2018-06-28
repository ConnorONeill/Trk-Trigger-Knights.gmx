player = argument0;

//add gold mul and extra draw to player
player.gold = player.gold + 2;
player.mul = 2;
player.exDraw = 1;
//add moves and attacks to units on the field
with(obj_unit){
    if(position == "field"){
    moves = 1;
    attacks = 1;
    }
}



//place for players to do things goes here
global.phase = phases.main;



