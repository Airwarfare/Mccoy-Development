/*
	Author: Maverick Applications
	Desc: Altis Life Shipwreck
*/

//Do not touch below
if(!isServer) exitWith {};

[] spawn {
	
	private["_positions","_position","_ship","_ship2","_createNewWreck","_deleteOldWreck","_lastCreateTime","_marker","_markerZone","_radius"];
	
	diag_log "asusfduwebupbfqeruibfqpbfqwibefuqiwubefqpwiubfequwibefqwuifb";
	
	sleep 360;
	
	diag_log "adolf";
	
	_positions = getArray(missionConfigFile >> "Maverick_Shipwrecks" >> "Positions");
	_ship = objNull;
	_ship2 = objNull;
	_lastCreateTime = time - 360;
	_radius = getNumber(missionConfigFile >> "Maverick_Shipwrecks" >> "Radius");

	_createNewWreck = {
		_position = selectRandom _positions;

		_marker = createMarker [ "shipwreck", _position ];
		_marker setMarkerColor "ColorBlack";
		_marker setMarkerType "mil_warning";
		_marker setMarkerText "Shipwreck";
		_marker setMarkerAlpha 0.95;

		_markerZone = createMarker [ "shipwreckzone",_position ];
		_markerZone setMarkerColor "ColorGreen";
		_markerZone setMarkerType "Empty";
		_markerZone setMarkerShape "ELLIPSE";
		_markerZone setMarkerSize [ _radius, _radius ];

		_ship = createVehicle ["Land_Wreck_Traw_F", _position, [], _radius, "None"];
		_ship allowDamage false;
		_ship setDamage 0;
		_ship enableSimulationGlobal false;
		_ship setVariable [ "wrecktime", time ];
		_ship setVariable [ "wreckloot", selectRandom(getArray(missionConfigFile >> "Maverick_Shipwrecks" >> "ShipLoot")), true];

		_ship2 = createVehicle [ "Land_Wreck_Traw2_F", ( getPos _ship ), [], 50, "None" ];
		_ship2 allowDamage false;
		_ship2 setDamage 0;
		_ship2 enableSimulationGlobal false;
		_ship2 setVariable [ "wrecktime", time ];

		getText(missionConfigFile >> "Maverick_Shipwrecks" >> "SpawnMSG") remoteExecCall ["hint",0];
	};

	_deleteOldWreck = {
		if(!isNull _ship) then {
			getText(missionConfigFile >> "Maverick_Shipwrecks" >> "DeleteMSG") remoteExecCall ["hint",0];
			sleep 5;
			deleteVehicle _ship;
			deleteVehicle _ship2;
			deleteMarker "shipwreck";
			deleteMarker "shipwreckzone";
		};
		_ship = objNull;
		_ship2 = objNull;
		_lastCreateTime = time;
	};

	while {true} do {
		if(isNull _ship) then {
			if((time - _lastCreateTime) >= (getNumber(missionConfigFile >> "Maverick_Shipwrecks" >> "ShipwreckInterval"))) then {
				[] call _deleteOldWreck;
				[] call _createNewWreck;
				_lastCreateTime = time + (getNumber(missionConfigFile >> "Maverick_Shipwrecks" >> "ShipwreckInterval"));
			};
		} else {
			if((_ship getVariable ["wreckloot", []]) isEqualTo []) then {
				[] call _deleteOldWreck;
			};
		};

		sleep 45;
	};
};
