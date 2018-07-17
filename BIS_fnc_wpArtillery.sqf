//copyToClipboard str BIS_fnc_wpArtillery;
//Fire artillery on a position.
{
	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'BIS_fnc_wpArtillery'} else {_fnc_scriptName};
	private _fnc_scriptName = 'BIS_fnc_wpArtillery';
	scriptName _fnc_scriptName;
    #line 1 "A3\functions_f\Waypoints\fn_wpArtillery.sqf [BIS_fnc_wpArtillery]"

    private ["_group","_pos","_target","_count","_magazine","_wp"];
    _group = _this param [0,grpnull,[grpnull]];
    _pos = _this param [1,[],[[]],3];
    _target = _this param [2,objnull,[objnull]];
    _count = _this param [3,100,[0]];
    _magazine = _this param [4,"",[""]];
    _wp = [_group,currentwaypoint _group];
    _wp setwaypointdescription localize "STR_A3_CfgWaypoints_Artillery";

    private ["_vehsFire"];
    _vehsFire = [];

    waituntil {
    private ["_countReady","_vehsGroup"];
    _countReady = 0;
    _vehsGroup = [];
    
    {
        private ["_veh"];
        _veh = vehicle _x;
        if (_x == effectivecommander _x) then {
            private ["_vehMagazine","_vehArtilleryAmmo"];
            _vehMagazine = _veh getvariable ["bis_fnc_wpArtillery_magazine",_magazine];
            _vehArtilleryAmmo = getartilleryammo [_veh];
            if (_vehMagazine == "" && count _vehArtilleryAmmo > 0) then {_vehMagazine = _vehArtilleryAmmo select 0};
            if !(_veh in _vehsFire) then {
                _veh setvariable ["bis_fnc_wpArtillery_magazine",_vehMagazine];
                _veh doartilleryfire [_pos,_vehMagazine,_count];
                _vehsFire set [count _vehsFire,_veh];
                } else {
                    if (currentcommand _veh != "FIRE AT POSITION") then {
                        if ((_pos inRangeOfArtillery [[_veh],_vehMagazine]) && (_vehMagazine in _vehArtilleryAmmo)) then {
                            _vehsFire = _vehsFire - [_veh];
                            } else {
                                _countReady = _countReady + 1;
                            };
                        };
                    };
                    _vehsGroup set [count _vehsGroup,_veh];
                };
            } foreach units _group;
            _vehsObsolete = _vehsFire - _vehsGroup;
            _vehsFire = _vehsFire - _vehsObsolete;

            {
                _x setvariable ["bis_fnc_wpArtillery_magazine",nil];
                _x move position _x;
            } foreach _vehsObsolete;

        sleep 1;
        count _vehsGroup == _countReady
    };
    
    {
        _x setvariable ["bis_fnc_wpArtillery_magazine",nil];
        _x move position _x;
    } foreach _vehsFire;

true};