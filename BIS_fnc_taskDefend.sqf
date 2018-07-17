//copyToClipboard str BIS_fnc_taskDefend;
//Watch and Rest on a Position.
{
	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'BIS_fnc_taskDefend'} else {_fnc_scriptName};
	private _fnc_scriptName = 'BIS_fnc_taskDefend';
	scriptName _fnc_scriptName;
    #line 1 "A3\functions_f\spawning\fn_taskDefend.sqf [BIS_fnc_taskDefend]"

    if ((count _this) < 2) exitWith {debugLog "Log: [taskDefend] Function requires at least 2 parameters!"; false};

    private ["_grp", "_pos"];
    _grp = _this select 0;
    _pos = _this select 1;

    if ((typeName _grp) != (typeName grpNull)) exitWith {debugLog "Log: [taskDefend] Group (0) must be a Group!"; false};
    if ((typeName _pos) != (typeName [])) exitWith {debugLog "Log: [taskDefend] Position (1) must be an Array!"; false};

    _grp setBehaviour "SAFE";

    private ["_list", "_units"];
    _list = _pos nearObjects ["StaticWeapon", 100];
    _units = (units _grp) - [leader _grp]; 
    _staticWeapons = [];

    {
        if ((_x emptyPositions "gunner") > 0) then 
        {
            _staticWeapons = _staticWeapons + [_x];	
        };
    } forEach _list;

    {
        if ((count _units) > 0) then 
        {
            if ((random 1) > 0.2) then 
            {
                private ["_unit"];
                _unit = (_units select ((count _units) - 1));
                _unit assignAsGunner _x;
                [_unit] orderGetIn true;
                _units resize ((count _units) - 1);
            };
        };
    } forEach _staticWeapons;

    private ["_wp"];
    _wp = _grp addWaypoint [_pos, 10];
    _wp setWaypointType "GUARD";

    private ["_handle"];
    _handle = _units spawn 

    {
        sleep 5;
        {
            if ((random 1) > 0.4) then 
            {
                doStop _x;
                sleep 0.5;
                _x action ["SitDown", _x];
            };
        } forEach _this;
    };
    true
};