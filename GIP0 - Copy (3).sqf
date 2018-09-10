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

_PL = leader _HQ;

_pos = getpos _PL;
_range = 2000;
_blacklist = [];

private ["_prevpos"];
_prevpos = _pos;
for "_i" from 0 to (2 + (floor (random 3))) do
{
    private ["_wp", "_newPos"];
		params [["_checkPos",[]],["_minDistance",0],["_maxDistance",-1],["_objectProximity",0],["_waterMode",0],
		["_maxGradient",0],["_shoreMode",0],["_posBlacklist",[]],["_defaultPos",[]]
		];
    _newpos = [_prevpos, 50, _range, 1, 0, 60 * (pi / 180), 0, _blacklist] call BIS_fnc_findSafePos;
    _prevpos = _newpos;

    _wp = _HQ addwaypoint [_newpos, 0];
    _wp setwaypointtype "MOVE";
    _wp setwaypointcompletionradius 20;
};

private ["_wp"];
_wp = _HQ addwaypoint [_pos, 0];
_wp setwaypointtype "CYCLE";
_wp setwaypointcompletionradius 20;