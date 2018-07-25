scriptName "functions_lockpickSpeed_4";
/**
 * Copyright © 2018 IEthanHD, IEthanHD Development Studios.
 * Created For Mccoy-Development.
 * All Rights Reserved.
 */
#define __filename "functions_lockpickSpeed_4.sqf"

_ownsDependency = [life_currentExpPerks, "perk_repair_4"] call mav_ttm_fnc_hasPerk;

if (!_ownsDependency) then {
	mav_ttm_var_repair_speed = 0.55;
};
