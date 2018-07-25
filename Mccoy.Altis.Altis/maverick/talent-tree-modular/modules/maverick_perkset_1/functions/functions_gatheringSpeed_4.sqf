scriptName "functions_gatheringSpeed_4";
/**
 * Copyright © 2018 IEthanHD, IEthanHD Development Studios.
 * Created For Mccoy-Development.
 * All Rights Reserved.
 */
#define __filename "functions_gatheringSpeed_4.sqf"

_ownsDependency1 = [life_currentExpPerks, "perk_gathering_1"] call mav_ttm_fnc_hasPerk;
_ownsDependency2 = [life_currentExpPerks, "perk_gathering_2"] call mav_ttm_fnc_hasPerk;
_ownsDependency3 = [life_currentExpPerks, "perk_gathering_3"] call mav_ttm_fnc_hasPerk;
_ownsDependency4 = [life_currentExpPerks, "perk_gathering_4"] call mav_ttm_fnc_hasPerk;

if (_ownsDependency1 && _ownsDependency2 && _ownsDependency3 && _ownsDependency4) then {
	mav_ttm_var_gatheringMultiplier = 1.25;
};
