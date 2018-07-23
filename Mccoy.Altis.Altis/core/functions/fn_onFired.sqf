#include "..\..\script_macros.hpp"
/*
    File: fn_onFired.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Handles various different ammo types being fired.
*/
private ["_ammoType","_projectile"];
_weapon = _this select 1; 
_muzzle = _this select 2;
_ammoType = _this select 4;
_projectile = _this select 6;

if("hgun_P07_snds_F" == _weapon) then {
    if(side player == west) then {
        _ammoAmount = player ammo _weapon;
        player setAmmo[currentWeapon player, _ammoAmount + 1];

        playercanFire = true;
        [] spawn {
            sleep 10;
            playercanFire = false;
        };
    };
};

if (_ammoType isEqualTo "GrenadeHand_stone") then {
    _projectile spawn {
        private "_position";
        while {!isNull _this} do {
            _position = ASLtoATL (visiblePositionASL _this);
            sleep 0.1;
        };
        [_position] remoteExec ["life_fnc_flashbang",RCLIENT];
    };
};
