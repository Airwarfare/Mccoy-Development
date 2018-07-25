scriptName "functions_repair_1";
/**
 * Copyright © 2018 IEthanHD, IEthanHD Development Studios.
 * Created For Mccoy-Development.
 * All Rights Reserved.
 */
#define __filename "functions_repair_1.sqf"

_ownsDependency = [life_currentExpPerks, "perk_repair_2"] call mav_ttm_fnc_hasPerk;
_ownsDependency2 = [life_currentExpPerks, "perk_repair_3"] call mav_ttm_fnc_hasPerk;
_ownsDependency3 = [life_currentExpPerks, "perk_repair_4"] call mav_ttm_fnc_hasPerk;

if (!_ownsDependency && !_ownsDependency2 && !_ownsDependency3) then {
	mav_ttm_var_repair_speed = 0.85;
};
