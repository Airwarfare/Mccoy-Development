/*
	File: fn_handleGetOutMan.sqf
	Author: Airwarfare

	Description:
	Handles the GetOutMan Event for when a unit exits a vehicle(Local to the computer)
*/

params [
	["_vehicle", objNull, [objNull]], //Vehicle the event handler is assigned to
	["_role", "", [""]],              //Can be either "driver", "gunner" or "cargo"
	["_unit", objNull, [objNull]],    //Vehicle that the unit left
	["_turret", [], [[]]]             //turret path
];

_actions = actionIDs player;
{
	_action = player actionParams _x;
	if((_action select 0) find "Seatbelt" >= 0) then {
		player removeAction _x;
		life_seatbelt = false;
	};
} forEach _actions