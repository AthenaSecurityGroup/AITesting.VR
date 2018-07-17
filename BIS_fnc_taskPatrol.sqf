//copyToClipboard str BIS_fnc_taskPatrol;
//Watch and Rest on a Position.
{
	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'BIS_fnc_taskPatrol'} else {_fnc_scriptName};
	private _fnc_scriptName = 'BIS_fnc_taskPatrol';
	scriptName _fnc_scriptName;

    #line 1 "A3\functions_f\spawning\fn_taskPatrol.sqf [BIS_fnc_taskPatrol]"

    if ((count _this) < 3) exitWith {debugLog "Log: [taskPatrol] Function requires at least 3 parameters!"; false};
    private ["_grp", "_pos", "_maxDist", "_blacklist"];

    _grp = _this select 0;
    _pos = _this select 1;
    _maxDist = _this select 2;
    _blacklist = [];

    if ((count _this) > 3) then {_blacklist = _this select 3};
    if ((typeName _grp) != (typeName grpNull)) exitWith {debugLog "Log: [taskPatrol] Group (0) must be a Group!"; false};
    if ((typeName _pos) != (typeName [])) exitWith {debugLog "Log: [taskPatrol] Position (1) must be an Array!"; false};
    if ((typeName _maxDist) != (typeName 0)) exitWith {debugLog "Log: [taskPatrol] Maximum distance (2) must be a Number!"; false};
    if ((typeName _blacklist) != (typeName [])) exitWith {debugLog "Log: [taskPatrol] Blacklist (3) must be an Array!"; false};

    _grp setBehaviour "SAFE";

    private ["_prevPos"];
    _prevPos = _pos;
    for "_i" from 0 to (2 + (floor (random 3))) do
    {
        private ["_wp", "_newPos"];
        _newPos = [_prevPos, 50, _maxDist, 1, 0, 60 * (pi / 180), 0, _blacklist] call BIS_fnc_findSafePos;
        _prevPos = _newPos;

        _wp = _grp addWaypoint [_newPos, 0];
        _wp setWaypointType "MOVE";
        _wp setWaypointCompletionRadius 20;
        if (_i == 0) then {
            _wp setWaypointSpeed "LIMITED";
            _wp setWaypointFormation "STAG COLUMN";
        };
    };
    
    private ["_wp"];
    _wp = _grp addWaypoint [_pos, 0];
    _wp setWaypointType "CYCLE";
    _wp setWaypointCompletionRadius 20;
true};