/*
	File: fn_handleGetInMan.sqf
	Author: Airwarfare

	Description:
	Handles the GetInMan Event for when a unit enters a vehicle(Local to the computer)
*/
params [
	["_vehicle", objNull, [objNull]], //Vehicle the event handler is assigned to
	["_role", "", [""]],              //Can be either "driver", "gunner" or "cargo"
	["_unit", objNull, [objNull]],    //Unit that entered the vehicle
	["_turret", [], [[]]]             //turret path
];

//Sanity Check
if(vehicle player != player) then {
	player addAction["Buckle Seatbelt", {
		life_seatbelt = !life_seatbelt;
		if(life_seatbelt) then { //Check Bool to update action text
			player setUserActionText[_this select 2, "Unbuckle Seatbelt"];
		} else {
			player setUserActionText[_this select 2, "Buckle Seatbelt"];
		};
	}];	
};