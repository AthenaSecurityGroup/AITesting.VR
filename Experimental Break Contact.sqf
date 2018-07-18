/* Break Contact
If AI elements are being beaten, they will return to their parent base.

Patrol leader gets total count of patrol.
If over twenty five percent of the patrol has been injured,
then the patrol leader considers breaking contact.

By the time fifty percent of the patrol is wounded,
the chance of breaking contact is 100%.
*/

params ['_group'];

//	DEBUG SWITCHES
#define AAW_DEBUG true
#define AAW_DEBUG_LOG if (AAW_DEBUG) then {systemChat _debugMsg; diag_log _debugMsg}

//	note --------- REGROUP IS DISABLED
//	break contact is test high
//	remaining check is moderately high
{
	_x params ["_unit"];
	//	AI BREAK CONTACT OR SURRENDER.
	if (!(isPlayer _unit)) then {
		_x addEventHandler ["Killed", {
			params ["_unit","_killer", "_insti"];
		
			//	REMOVE DEAD UNIT FROM ORIGINAL GROUP.
			_origGroup = (group _unit);
			[_unit] join grpNull;
			
			//	CONDITIONALS.
			_remaining = (count units _origGroup <= 5);
			_chanceBreakContact = (random 10 > 2);
			_chanceRegroup = (random 10 > 10);
			
			//	IF IN CLOSE CONTACT, SURRENDER
			_nearest = leader _origGroup findNearestEnemy position leader _origGroup;
			_nearDistance = leader _origGroup distance _nearest <= 125;
			private ["_chanceSurrender"];
			if (!isNil '_nearest' && {_nearDistance}) then {_chanceSurrender = true};
			
			//	ORDER BREAK CONTACT.
			if (_remaining && _chanceBreakContact) exitWith {
				//	DELETE ALL WAYPOINTS
				[_origGroup] call ASG_fnc_clearWaypoints;

				//	FALL BACK TO FRIENDLY FORCES IF AVAILABLE.
				if (_chanceRegroup) exitWith {
					{
						_x params ["_fallbackUnit"];
						_fallbackGroup = group _fallbackUnit;
						
						if ((side _x == side leader _origGroup) && (group _x != _origGroup)) exitWith {
							_debugMsg = format ["[AI]:	Regrouping with:	%1", group _x]; AAW_DEBUG_LOG;
							{
								[_x] join grpNull;
								[_x] join _fallbackGroup;
							} forEach units _origGroup;
							deleteGroup _origGroup;
							_fallbackGroup setFormation "WEDGE";
							_x move (getPos leader _fallbackGroup);
							_x doMove (getPos leader _fallbackGroup);
							_x commandFollow leader _fallbackGroup;
						};
					} forEach (leader _origGroup nearEntities [["Man","Car"], 250]);
				};
				
				//	GENERATE BREAK CONTACT RENDEZVOUS.
				_bcDir = (_killer getDir _unit);
				_bcRV = _unit getPos [25, _bcDir];

				//	ON EACH UNIT IN THE KILLED UNITS GROUP.
				{
					_x params ["_unit"];
					//	POP SMOKE.
					_unit forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"];
					_x commandWatch objNull;

					//	DELETE ALL WAYPOINTS
					[(group _x)] call ASG_fnc_clearWaypoints;
				} forEach (units _origGroup);
			
				//	BREAK CONTACT WAYPOINTS
				_bcWP = _origGroup addWaypoint [_bcRV, 0];
				_bcWP setWaypointBehaviour "AWARE";		//	AWARE
				_bcWP setWaypointCombatMode "GREEN";	//	GREEN
				_bcWP setWaypointSpeed "FULL";			//	NORMAL
				_bcWP setWaypointForceBehaviour true;
				_bcWP2 = _origGroup addWaypoint [_bcRV getPos [100, _bcDir], 50];
				_bcWP3 = _origGroup addWaypoint [_bcRV getPos [250, _bcDir], 50];
				_bcWP3 setWaypointStatements ["true", "
					_locGroup = group this;
				"];
			};
			
			//	ORDER SURRENDER.
			if (_remaining && _chanceSurrender) then {
				_debugMsg = format ["[AI]:	%1 surrendering.", _origGroup]; AAW_DEBUG_LOG;
				{
					_x params ["_unit"];
					missionNamespace setVariable [format ["%1Surrender", _unit],
						[_unit] spawn {
							params ['_unit'];
							
							//	SET CAPTIVE
							_unit setCaptive true;
							
							//	KNEEL.
							_unit setUnitPos "Middle";
							
							uiSleep 1;
							
							//	DROP PRI WEAPON INTO GROUND HOLDER.
							_grWepHolder = createVehicle ["groundWeaponHolder", (position _unit), [], 0, "CAN_COLLIDE"];
							_grWepHolder addMagazineCargoGlobal [(currentMagazine _unit), 1];

							//	DROP ITEMS.
							{
								if (_forEachindex > 2) then {
									_unit action ["DropBag", _grWepHolder, _x];
								} else {
									if (_x != "") then {
										_unit action ["DropWeapon", _grWepHolder, _x];
										uiSleep 3;
									};
								};
							} forEach [
								(primaryWeapon _unit),
								(secondaryWeapon _unit),
								(handgunWeapon _unit),
								(backPack _unit)
							];

							sleep 2;
							_unit switchMove "amovpknlmstpsnonwnondnon";
							
							//	DISABLE UNIT.
							_unit stop true;
							{_unit disableAI _x} forEach ["MOVE", "AUTOTARGET", "TARGET", "ANIM", "CHECKVISIBLE"];
							
							//	SURRENDER ANIMATION.
							_unit playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
							
							//	SURRENDER ADDACTION.
							[_unit] call ASG_fnc_powTakeAction;
							
							//	NULLIFY
							missionNamespace setVariable [format ["%1Surrender", _unit], nil];
						}
					];
				} forEach (units _origGroup);
				
				//	CLEAR WAYPOINTS
				[] call ASG_fnc_clearWaypoints;
			};
		}];
	};
} forEach units _group;

//	DELETE ALL WAYPOINTS.
ASG_fnc_clearWaypoints = {
	params ["_origGroup"];
	while {(count (waypoints _origGroup)) > 0} do {
		deleteWaypoint ((waypoints _origGroup) select 0)
	};
};

//	ADD TAKE P.O.W. ADDACTION TO A UNIT.
ASG_fnc_powTakeAction = {
	params ['_unit'];
	_unit addAction [
		"Take Prisoner",
		"
			params ['_target','_caller','_ID','_args'];
			_this call ASG_fnc_powTake;
		",
		nil,
		6,
		false,
		true,
		"",
		"
			_this == leader group _this
		",
		2,
		false
	];
};

//	ADDACTION CODE FOR TAKING P.O.W.
ASG_fnc_powTake = {
	params ['_target','_caller','_ID','_args'];
	
	//	RESET STATES AND JOIN TARGET GROUP
	{_target enableAI _x} forEach ["MOVE", "AUTOTARGET", "TARGET", "ANIM", "CHECKVISIBLE"];
	_target stop false;
	[_target] join group _caller;
	_target setUnitPos "Auto";
	group _caller setFormation 'FILE';

	//	ADDACTION HANDLING
	_target removeAction _ID;
	[_target] call ASG_fnc_powRelAction;
};

//	ADD RELEASE P.O.W. ADDACTION TO A UNIT.
ASG_fnc_powRelAction = {
	params ['_unit'];
	_unit addAction [
		"Release Prisoner",
		"
			params ['_target','_caller','_ID','_args'];
			_this call ASG_fnc_powRel;
		",
		nil,
		6,
		false,
		true,
		"",
		"
			_this == leader group _this
		",
		2,
		false
	];
};

//	ADDACTION CODE FOR RELEASING P.O.W.
ASG_fnc_powRel = {
	params ['_target','_caller','_ID','_args'];
	
	//	SET STATES AND ANIMS
	[_target] join grpNull;
	{_target disableAI _x} forEach ["MOVE", "AUTOTARGET", "TARGET", "ANIM", "CHECKVISIBLE"];
	_target playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";	
	
	//	ADDACTION HANDLING
	_target removeAction _id;
	[_target] call ASG_fnc_powTakeAction;
};