#include "..\..\script_macros.hpp"
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

disableSerialization;
//Sanity Check
if(vehicle player != player) then {
	_ctrl = LIFEctrl(2222);
	_ctrl ctrlSetText "icons\Unbuckled.paa";
	_ctrl ctrlCommit 0;
	player addAction["Buckle Seatbelt", {
		_ctrl = LIFEctrl(2222);
		life_seatbelt = !life_seatbelt;
		if(life_seatbelt) then { //Check Bool to update action text
			player setUserActionText[_this select 2, "Unbuckle Seatbelt"];
			_ctrl ctrlSetText "icons\Buckled.paa";
			_ctrl ctrlCommit 0;
			playSound "Buckle";
		} else {
			player setUserActionText[_this select 2, "Buckle Seatbelt"];
			_ctrl ctrlSetText "icons\Unbuckled.paa";
			_ctrl ctrlCommit 0;
			playSound "Unbuckle";
		};
	}];	
	player addAction["Navigator", {
		[] call mav_gps_fnc_initNavigation;
	}];
};