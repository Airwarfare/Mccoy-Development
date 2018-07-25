/*--------------------------------------------------------------------------
    Author:		Maverick Applications
    Website:	https://maverick-applications.com

    You're not allowed to use this file without permission from the author!
---------------------------------------------------------------------------*/

if (isServer) exitWith {
	
	mav_var_speedcams = [];
	
	{
        private _object = createSimpleObject [ ( ( str missionConfigFile select [0, count str missionConfigFile - 15] ) + "Maverick\SpeedCameras\Models\maverick_speedCamera.p3d" ), ( _x select 0 ) ];
        _object setPosATL ( _x select 0 );
        _object setDir ( _x select 1 );
		mav_var_speedcams pushBack _object;
    } forEach ( getArray(missionConfigFile >> "Maverick_SpeedCameras" >> "SpeedCameras") );
	
	publicVariable "mav_var_speedcams";
};

if (
	( count ( getArray(missionConfigFile >> "Maverick_SpeedCameras" >> "SpeedCameras" ) ) < 1 ) || 
	( ( tolower( str( playerSide ) ) ) in ( getArray(missionConfigFile >> "Maverick_SpeedCameras" >> "SideWhitelist") ) )
) exitWith {};
    
[] spawn {

	mav_var_speedcam_triggered = false;
	
	for "_i" from 0 to 1 step 0 do {

		waitUntil { 
			( ( vehicle player ) != ( player ) ) && 
			( ( driver( vehicle player ) ) == ( player ) ) && 
			( !( ( vehicle player ) isKindOf "Air" ) ) && 
			( !( ( vehicle player ) isKindOf "Ship" ) ) 
		};
		
		{	
			private _position = ( _x select 0 );
			private _speed = ( _x select 2 );

			if (
				!mav_var_speedcam_triggered 
				&& 
				{ 
					( ( getPosATL( vehicle player ) ) distance2D ( _position ) ) <= (getNumber(missionConfigFile >> "Maverick_SpeedCameras" >> "Radius") ) 
				} 
				&& 
				{ 
					( ( ( vehicle player ) getRelDir ( _position ) ) > 1 ) && 
					( ( ( vehicle player ) getRelDir ( _position ) ) < 135  )
				} 
				&&
				{
					( ( ( mav_var_speedcams select _ForEachIndex ) getRelDir ( vehicle player ) ) < 135 ) && 
					( ( ( mav_var_speedcams select _ForEachIndex ) getRelDir ( vehicle player ) ) > 35 )
				}				
			   ) then {

				if ( ( ( speed ( vehicle player ) ) > _speed ) && ( _speed > 0 ) ) then {

					mav_var_speedcam_triggered = true;
					private _iOverLimit = round( ( speed( vehicle player ) ) - _speed );
										
					"colorCorrections" ppEffectEnable true;
					"colorCorrections" ppEffectAdjust [1, 15, 0, [0.5, 0.5, 0.5, 0], [0.0, 0.5, 0.0, 1],[0.3, 0.3, 0.3, 0.05]];
					"colorCorrections" ppEffectCommit 0;
					"colorCorrections" ppEffectAdjust [1, 1, 0, [1, 1, 1, 0.0], [1, 1, 1, 1],  [1, 1, 1, 1]];
					"colorCorrections" ppEffectCommit 0.05;
					
					sleep 0.14;
                    
					"colorCorrections" ppEffectAdjust [1, 1, 0, [139, 0, 0, 0.1], [0.0, 0.5, 0.0, 0],[0.3, 0.3, 0.3, 0]];
					"colorCorrections" ppEffectCommit 0;
					"colorCorrections" ppEffectAdjust [1, 1, 0, [1, 1, 1, 0.0], [1, 1, 1, 1],  [1, 1, 1, 1]];
					"colorCorrections" ppEffectCommit 0.05;
					
					sleep 0.22;
					
					"colorCorrections" ppEffectEnable false;

					_text = "<t color='#cc1f00'><t size='2'><t align='center'>"+( getText(missionConfigFile >> "Maverick_SpeedCameras" >> "localization" >> "msgSpeedCamera") )+"</t></t><t color='#ffffff'><br/><br/>";
					_text = _text + format[ ( getText( missionConfigFile >> "Maverick_SpeedCameras" >> "localization" >> "msgInfo" ) ), _iOverLimit ];
					
					{
						if( _iOverLimit > ( _x select 2 ) ) then {
							
							[] call compile ( ( _x select 1 ) + " = false" );
							
							_text = _text + "<br/>" + format[ ( getText(missionConfigFile >> "Maverick_SpeedCameras" >> "localization" >> "msgRemoveLicense") ), ( _x select 0 ) ];
						};
					} forEach ( getArray(missionConfigFile >> "Maverick_SpeedCameras" >> "RemoveLicenses") );
					
					if ( (getNumber(missionConfigFile >> "Maverick_SpeedCameras" >> "AddPlayerToWanted") ) > 0 ) then {
						[ 
							getPlayerUID player, 
							profileName, 
							( getText(missionConfigFile >> "Maverick_SpeedCameras" >> "WantedCase") ) 
						] remoteExecCall [
							( getText(missionConfigFile >> "Maverick_SpeedCameras" >> "WantedFunction") ),
							2 //You might need to ajust this from sending to the SERVER '2' to your custom remoteexec receiver
						];
						_text = _text + "<br/>" + (getText(missionConfigFile >> "Maverick_SpeedCameras" >> "localization" >> "msgWantedAdd"));
					};
					
					if ( ( getNumber(missionConfigFile >> "Maverick_SpeedCameras" >> "SpeedingFee") ) > 0 ) then {
						
						private _strApplyFee = ( getText(missionConfigFile >> "Maverick_SpeedCameras" >> "BankVariable") ) + " = " + getText(missionConfigFile >> "Maverick_SpeedCameras" >> "BankVariable") + " - ";
						
						if( getNumber(missionConfigFile >> "Maverick_SpeedCameras" >> "EnableFactor") > 0 ) then {
							
							_strApplyFee = _strApplyFee + str( getNumber(missionConfigFile >> "Maverick_SpeedCameras" >> "SpeedingFee") * ( _iOverLimit ) ) + ";";
						
							_text = _text + "<br/>" + format [
								( getText(missionConfigFile >> "Maverick_SpeedCameras" >> "localization" >> "msgSpeedingFee") ), 
								( getNumber(missionConfigFile >> "Maverick_SpeedCameras" >> "SpeedingFee") * ( _iOverLimit ) )
							];
						} else {
							
							_strApplyFee = _strApplyFee + str( getNumber(missionConfigFile >> "Maverick_SpeedCameras" >> "SpeedingFee") ) + ";";
						
							_text = _text + "<br/>" + format [
								( getText(missionConfigFile >> "Maverick_SpeedCameras" >> "localization" >> "msgSpeedingFee") ), 
								( getNumber(missionConfigFile >> "Maverick_SpeedCameras" >> "SpeedingFee") )
							];
						};
						
						_strApplyFee = _strApplyFee + "if ("+( getText(missionConfigFile >> "Maverick_SpeedCameras" >> "BankVariable") )+" < 0 ) then {"+( getText(missionConfigFile >> "Maverick_SpeedCameras" >> "BankVariable") )+" = 0; };";
						
						[] call compile _strApplyFee;
					};

					hint parseText _text;
					
					[] spawn {
						uiSleep 5;
						mav_var_speedcam_triggered = false;
					};
				};
			};
		} forEach ( getArray(missionConfigFile >> "Maverick_SpeedCameras" >> "SpeedCameras") );

		uiSleep 0.6;
	};
};