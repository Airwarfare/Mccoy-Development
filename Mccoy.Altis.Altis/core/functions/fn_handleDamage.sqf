#include "..\..\script_macros.hpp"
/*
    File: fn_handleDamage.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Handles damage, specifically for handling the 'tazer' pistol and nothing else.
*/
params [
    ["_unit",objNull,[objNull]],
    ["_part","",[""]],
    ["_damage",0,[0]],
    ["_source",objNull,[objNull]],
    ["_projectile","",[""]],
    ["_index",0,[0]],
    ["_instigator", objNull, [objNull]],
    ["_hitPoint", "", [""]]
];
//Handle the tazer first (Top-Priority).
if (!isNull _source) then {
    if (_source != _unit) then {
        if (currentWeapon _source in ["hgun_P07_snds_F","arifle_SDAR_F"] && _projectile in ["B_9x21_Ball","B_556x45_dual"]) then {
            if (side _source isEqualTo west && playerSide isEqualTo civilian) then {
                _damage = 0;
                if (alive player && !life_istazed && !life_isknocked && !(_unit getVariable ["restrained",false])) then {
                    private ["_distance"];
                    _distance = 35;
                    if (_projectile == "B_556x45_dual") then {_distance = 100;};
                    if (_unit distance _source < _distance) then {
                        if !(isNull objectParent player) then {
                            if (typeOf (vehicle player) == "B_Quadbike_01_F") then {
                                player action ["Eject",vehicle player];
                                [_unit,_source] spawn life_fnc_tazed;
                            };
                        } else {
                            [_unit,_source] spawn life_fnc_tazed;
                        };
                    };
                };
            };

            //Temp fix for super tasers on cops.
            if (side _source isEqualTo west && (playerSide isEqualTo west || playerSide isEqualTo independent)) then {
                _damage = 0;
            };
        };
    };
} else {
    if(vehicle player != player) then { // Then they must be in a vehicle!
        if(life_seatbelt) then {
            _damage = _damage * 0.25;
        } else {
            if(_damage > 0.35) then {
                _r = random[0,50,100] / 100;
                if(_r <= .40) then {
                    player setUnconscious true;
                    [] spawn {
                        _handle = ppEffectCreate["RadialBlur", 2010]; 
                        _handle ppEffectEnable true; 
                        _handle ppEffectAdjust [0.01, 0.01, 0.06, 0.06];  
                        _handle ppEffectCommit 0;
                        player playMoveNow "kia_driver_mid01";
                        sleep 180; //3 Mins
                        player setUnconscious false;
                        ppEffectDestroy _handle;
                        player switchMove "driver_offroad01";
                    };
                };  
            };
        };
    };
};

[] spawn life_fnc_hudUpdate;
_damage;