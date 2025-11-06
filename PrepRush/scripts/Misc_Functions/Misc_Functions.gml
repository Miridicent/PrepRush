// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SwitchRoom(new_room, Obj, xplace, yplace){
	room_goto(new_room);
	Obj.x = xplace;
	Obj.y = yplace;
}