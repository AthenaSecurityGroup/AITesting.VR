/* Greek Infantry Platoon Security Patrol (AWARE or SAFE)
Infantry platoon conducts a close security sweep of their parent combat out post.
The patrol withdraws to combat out post if defeated.

AI action "chain,"
Secure (Secure local area, prepare)
Supply (Logistics)
Survey (Reconnaissance)
Seek (Move to Contact)
Seize (Attack)
Secure (Repeat)

Three levels of resistance;
Discovered means element knows its location is known to other factions.
Challenged means element has been engaged.
Defeated means element has been forced to break contact.
*/

If (!isServer) exitwith {};
Params ["_trigger"];
_trigger spawn {
	_Base = (getmarkerpos "Origin");
	_HQ = [_Base, INDEPENDENT, ["I_officer_F","I_medic_F","I_Soldier_SL_F","I_soldier_UAV_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	Sleep 1;
	_G1 = [_Base, INDEPENDENT, ["I_Soldier_TL_F","I_Soldier_AR_F","I_soldier_F","I_soldier_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	Sleep 1;
	_G2 = [_Base, INDEPENDENT, ["I_Soldier_SL_F","I_soldier_F","I_Soldier_AR_F","I_Soldier_M_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	Sleep 1;
	_G3 = [_Base, INDEPENDENT, ["I_Soldier_TL_F","I_Soldier_AR_F","I_soldier_F","I_soldier_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	Sleep 1;
	_G4 = [_Base, INDEPENDENT, ["I_Soldier_SL_F","I_Soldier_AR_F","I_soldier_F","I_Soldier_LAT_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	Sleep 1;
	_G5 = [_Base, INDEPENDENT, ["I_Soldier_TL_F","I_soldier_F","I_Soldier_AR_F","I_soldier_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	Sleep 1;
	_G6 = [_Base, INDEPENDENT, ["I_Soldier_SL_F","I_soldier_F","I_Soldier_AR_F","I_Soldier_LAT_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	Sleep 1;

	{
		{
//			_x execVM "Gear\AAF.sqf";
		} foreach units _x;
	} foreach [_HQ, _G1, _G2, _G3, _G4, _G5, _G6];

	_G1 addwaypoint [_this, 2400];
	_G1 addwaypoint [_this, 2400];
	_G1 addwaypoint [_this, 2400];
	_G1 addwaypoint [_this, 2400];
	_G1 addwaypoint [_this, 2400];
	_G1 addwaypoint [_this, 2400];
	_G1 addwaypoint [_this, 2400];

	[_G1, 1] setwaypointbehaviour (selectrandom ["AWARE", "SAFE"]);
	[_G1, 1] setwaypointtype "MOVE";
	[_G1, 1] setwaypointspeed "LIMITED";
	[_G1, 6] setwaypointtype "CYCLE";
	Sleep 45;

	_G2 copywaypoints _G1;
	Sleep 45;

	_HQ copywaypoints _G1;
	Sleep 45;

	_G3 copywaypoints _G1;
	Sleep 45;

	_G4 copywaypoints _G1;
	Sleep 45;

	_G5 copywaypoints _G1;
	Sleep 45;

	_G6 copywaypoints _G1;
};