scriptName "functions_med_bb1";
/**
 * Copyright © 2018 IEthanHD, IEthanHD Development Studios.
 * Created For Mccoy-Development.
 * All Rights Reserved.
 */
#define __filename "functions_med_bb1.sqf"
_ownsDependency = [life_currentExpPerks, "perk_bb_amount_2"] call mav_ttm_fnc_hasPerk;

if (!_ownsDependency) then {
	mav_ttm_var_bb_a = .2;
};
