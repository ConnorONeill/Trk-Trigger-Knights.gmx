//check if there is noone in the units supporting node
if (selNode.support == hoverNode && hoverNode.occupant == noone && selNode.occupant.moves >= 1){
//make the occupant of the supporting node the occupant of the selected
    selNode.support.occupant = selNode.occupant;
//remove the occupant from selected node
    selNode.occupant = noone;
//give the unit its new location
    selNode.support.occupant.gridX = selNode.support.gridX;
    selNode.support.occupant.gridY = selNode.support.gridY;
//move the unit to its new location
    selNode.support.occupant.x = selNode.support.x;
    selNode.support.occupant.y = selNode.support.y;
//expend a move from the unit
    selNode.support.occupant.moves = selNode.support.occupant.moves - 1;
}

