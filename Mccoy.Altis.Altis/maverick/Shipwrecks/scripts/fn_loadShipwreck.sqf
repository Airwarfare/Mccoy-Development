/*
	Author: Maverick Applications
	Desc: Altis Life Shipwreck
*/

//Do not touch below
if (hasInterface) exitWith 
{
	if (isNil "life_wrecklooting") then 
	{
		player addEventHandler ["Respawn", {call mav_Shipwrecks_fnc_loadShipwreck} ];
	};
	
	life_wrecklooting = false;
    
	player addAction[getText(missionConfigFile >> "Maverick_Shipwrecks" >> "ShipLootText"),
	{
        [] spawn {
            if (life_wrecklooting) exitWith {};
            life_wrecklooting = true;
            private _allGood = true;
            sleep random(1.9);
			private _index = -1;
            private _lootArray = ((nearestObjects[player,["Land_Wreck_Traw_F"], 20]) select 0) getVariable["wreckloot", []];
            if (_lootArray isEqualTo []) exitWith {};
            {
                if ([true,_x,1] call life_fnc_handleInv) then {
                    _index = _forEachIndex;
                } else {
                    _allGood = false;
                };
                if (!_allGood) exitWith {hint getText(missionConfigFile >> "Maverick_Shipwrecks" >> "ShipLootFail");};
            } forEach _lootArray;
            if (_allGood) then {
                hint getText(missionConfigFile >> "Maverick_Shipwrecks" >> "ShipLootSuccess");
                ((nearestObjects[player,["Land_Wreck_Traw_F"], 20]) select 0) setVariable ["wreckloot", [], true];
            } else {
				for "_i" from 0 to _index do {_lootArray deleteAt 0;};
                ((nearestObjects[player,["Land_Wreck_Traw_F"], 20]) select 0) setVariable ["wreckloot", _lootArray, true];
            };
            life_wrecklooting = false;
        };
    },"",0,false,false,"",'!life_wrecklooting && ((count nearestObjects[player,["Land_Wreck_Traw_F"], 20]) != 0) && (count(((nearestObjects[player,["Land_Wreck_Traw_F"], 20]) select 0) getVariable["wreckloot", []]) != 0)'];
};
	
if (!isServer) exitWith {};

[] spawn mav_Shipwrecks_fnc_initShipwreck;