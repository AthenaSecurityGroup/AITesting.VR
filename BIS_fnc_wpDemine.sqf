//copytoclipboard str BIS_fnc_wpDemine;
//Mine Sweep.
{
	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'BIS_fnc_wpDemine'} else {_fnc_scriptName};
	private _fnc_scriptName = 'BIS_fnc_wpDemine';
	scriptName _fnc_scriptName;

    #line 1 "A3\functions_f_orange\Waypoints\fn_wpDemine.sqf [BIS_fnc_wpDemine]"
    "Start of demining" call bis_fnc_log;

    _group = _this param [0,grpnull,[grpnull]];
    _pos = _this param [1,[],[[]],3];
    _target = _this param [2,objnull,[objnull]];
    _clearUnknown = _this param [3,true,[true]];

    _wp = [_group,currentwaypoint _group];
    _wp setwaypointdescription localize "STR_A3_Functions_F_Orange_Demine";
    _wpRadius = waypointCompletionRadius _wp;
    if (_wpRadius == 0) then {_wpRadius = 50;};
    _side = side _group;

    {
        _x setvariable ["BIS_fnc_wpDemine_mine",nil];
        _x setvariable ["BIS_fnc_wpDemine_counter",nil];
    } foreach units _group;

    _noMines = false;

    waituntil {
        _units = units _group;
        _specialists = _units select {
            ((_x getunittrait "explosiveSpecialist") || (_x getunittrait "engineer"))
            &&
            {"ToolKit" in items _x}
        };

        if (count _specialists == 0) exitwith {"No specialists found" call bis_fnc_log;}; 

        _mines = if (_clearUnknown) then {allmines} else {detectedmines _side};
        _mines = _mines select {_x distance _pos < _wpRadius};
        _minesAssigned = _units apply {_x getvariable ["BIS_fnc_wpDemine_mine",objnull]};
        _minesAvailable = _mines - _minesAssigned;

        {
            _unit = _x;
            if !(isplayer _unit) then {
                _mine = _unit getvariable ["BIS_fnc_wpDemine_mine",objnull];
                _counter = _unit getvariable ["BIS_fnc_wpDemine_counter",0];

                if ({_unit distance _x < 8} count _mines > 0) then {
                    _unit setunitpos "down";
                } else {
                    _unit setunitpos "auto";
                };

                if !(isnull _mine) then {
                    if (unitready _unit || speed _unit == 0) then {
                        if (_unit distance _mine < 2 || _counter > 	10) then {
                            _unit action ["Deactivate",_unit,_mine];
                            _unit setvariable [	"BIS_fnc_wpDemine_mine",nil];
                            ["4: %1 deactivating mine %2",_unit,_mine] call bis_fnc_logFormat;
                        } else {
                            _unit domove position _mine;
                            _unit setvariable [	"BIS_fnc_wpDemine_counter", if (speed _unit == 0) then {_counter + 1} else {0}];
                            ["3: %1 moving to mine %2",_unit,_mine] call bis_fnc_logFormat;
                        };
                    };
                } else {
                    if (_unit distance _pos <= _wpRadius) then {
                        if (count _minesAvailable > 0) then {
                            _minesNear = _minesAvailable apply {[_unit distance _x,_x]};
                            _minesNear sort true;
                            _mine = _minesNear select 0 select 1;
                            _minesAvailable = _minesAvailable - [_mine];
                            _unit dowatch _mine;
                            _unit setvariable [	"BIS_fnc_wpDemine_mine",_mine];
                            _unit setvariable [	"BIS_fnc_wpDemine_counter",0];
                            _unit domove position _unit;
                            unassignvehicle _unit;
                            [_unit] allowgetin false;
                            ["2: %1 has been assigned mine %2",_unit,_mine] call bis_fnc_logFormat;
                        };
                    } else {
                        if ((expecteddestination _unit select 0) distance _pos > _wpRadius) then {
                            _unit domove _pos;
                            ["1: %1 moving to waypoint",_unit] call bis_fnc_logFormat;
                        };
                    };
                };
            };
        } foreach _specialists;
        
        {
            _unit = _x;
            if (_unit distance _pos <= _wpRadius) then {
                if ((expecteddestination _unit select 0) distance _unit > 1) then {
                    _unit domove position _unit;
                    ["2: %1 stopped, because it's not a specialist",_unit] call bis_fnc_logFormat;
                };
            } else {
                if ((expecteddestination _unit select 0) distance _pos > _wpRadius) then {
                    _unit domove _pos;
                    ["1: %1 moving to waypoint",_unit] call bis_fnc_logFormat;
                };
            };
        } foreach (_units - _specialists);
        sleep 		1;
        count _mines == 0 || count _units == 0
    };

    {
        _x domove _pos;
        _x dowatch objnull;
        _x setvariable ["BIS_fnc_wpDemine_mine",nil];
        _x setvariable ["BIS_fnc_wpDemine_counter",nil];
        [_x] allowgetin true;
    } foreach units _group;
    "End of demining" call bis_fnc_log;
};