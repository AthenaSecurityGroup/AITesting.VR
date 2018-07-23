/* Greek Infantry Platoon Security Patrol (AWARE or SAFE)
Infantry platoon conducts a close security sweep of their parent combat out post.
The patrol withdraws to combat out post if defeated.

Design:
Spawn groups;
Generate random waypoints with a minimum and maximum radius of original position;
Return to original position;
Go off duty;
Random sleep time;
Repeat;

*/



























If (!isServer) exitwith {};
Params ["_trigger"];
_Base = (getmarkerpos "Origin");
_HQ = [_Base, INDEPENDENT, ["I_officer_F","I_medic_F","I_officer_F","I_soldier_UAV_F"],[],["LIEUTENANT","PRIVATE","SERGEANT","PRIVATE"],[],[],[],180] call BIS_fnc_spawnGroup;
Sleep 1;
_G1 = [_Base, INDEPENDENT, ["I_Soldier_TL_F","I_Soldier_AR_F","I_soldier_F","I_soldier_F"],[],["CORPORAL","PRIVATE","PRIVATE","PRIVATE"],[],[],[],180] call BIS_fnc_spawnGroup;
Sleep 1;
_G2 = [_Base, INDEPENDENT, ["I_Soldier_SL_F","I_Soldier_M_F","I_Soldier_AR_F","I_soldier_F"],[],["SERGEANT","PRIVATE","PRIVATE","PRIVATE"],[],[],[],180] call BIS_fnc_spawnGroup;
Sleep 1;
_G3 = [_Base, INDEPENDENT, ["I_Soldier_TL_F","I_soldier_F","I_Soldier_AR_F","I_soldier_F"],[],["CORPORAL","PRIVATE","PRIVATE","PRIVATE"],[],[],[],180] call BIS_fnc_spawnGroup;
Sleep 1;
_G4 = [_Base, INDEPENDENT, ["I_Soldier_SL_F","I_Soldier_GL_F","I_Soldier_AR_F","I_soldier_F"],[],["SERGEANT","PRIVATE","PRIVATE","PRIVATE"],[],[],[],180] call BIS_fnc_spawnGroup;
Sleep 1;
_G5 = [_Base, INDEPENDENT, ["I_Soldier_TL_F","I_Soldier_AR_F","I_soldier_F","I_soldier_F"],[],["CORPORAL","PRIVATE","PRIVATE","PRIVATE"],[],[],[],180] call BIS_fnc_spawnGroup;
Sleep 1;
_G6 = [_Base, INDEPENDENT, ["I_Soldier_SL_F","I_Soldier_AR_F","I_Soldier_GL_F","I_soldier_F"],[],["SERGEANT","PRIVATE","PRIVATE","PRIVATE"],[],[],[],180] call BIS_fnc_spawnGroup;
Sleep 1;

{
	{
		_gearhandle = _x execvm "Gear\AAF.sqf";
		waitUntil {scriptDone _gearhandle};

		if ((_x getunittrait "medic") && {"Medikit" in items _x}) then {
			[_x, IndiCasualties] execVM "Combat Medic.sqf";
		};

		_x addeventhandler ["Handledamage",{
			if (_this select 2 > 0.8) then {
				_unit = _this select 0;
				_unit setunconscious true;
				IndiCasualties pushbackunique _unit;
			};
		}];
	} foreach units _x;
	_x deletegroupwhenempty true;
} foreach [_HQ, _G1, _G2, _G3, _G4, _G5, _G6];
Sleep 1;

_G1 addwaypoint [_Base, 2400];
_G1 addwaypoint [_Base, 2400];
_G1 addwaypoint [_Base, 2400];
_G1 addwaypoint [_Base, 2400];
_G1 addwaypoint [_Base, 2400];
_G1 addwaypoint [_Base, 2400];
_G1 addwaypoint [_Base, 2400];

[_G1, 1] setwaypointbehaviour (selectrandom ["AWARE", "SAFE"]);
[_G1, 1] setwaypointtype "MOVE";
//[_G1, 1] setwaypointformation (selectrandom ["COLUMN","FILE","WEDGE"]);
[_G1, 1] setwaypointspeed "LIMITED";
[_G1, 6] setwaypointtype "CYCLE";
Sleep 45;

_G2 copywaypoints _G1;
Sleep 45;

_HQ copywaypoints _G1;
_G3 copywaypoints _G1;
_G4 copywaypoints _G1;

{
	private _waypoint = _x;
	private _wpposition = waypointposition _waypoint;
	_wpposition = _wpposition getpos [200, (getdir leader (_G1)) + 240];
	_waypoint setWPPos _wpposition;
} foreach waypoints _G3;

{
	private _waypoint = _x;
	private _wpposition = waypointposition _waypoint;
	_wpposition = _wpposition getpos [200, (getdir leader (_G1)) + 120];
	_waypoint setwppos _wpposition;
} foreach waypoints _G4;
Sleep 45;

_G5 copywaypoints _G1;
Sleep 45;

_G6 copywaypoints _G1;