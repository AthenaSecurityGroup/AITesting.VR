//copytoclipboard str BIS_fnc_ambientAnimCombat;
//Off watch, on guard.

{
	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'BIS_fnc_ambientAnimCombat'} else {_fnc_scriptName};
	private _fnc_scriptName = 'BIS_fnc_ambientAnimCombat';
	scriptName _fnc_scriptName;
    private["_unit","_animset","_gear","_cond","_behaviour"];
    private["_acceptableStates","_acceptableGear","_transAnim"];
    _unit = _this param [0, objNull, [objNull]];
    _animset = _this param [1, "STAND", [""]];
    _gear = _this param [2, "ASIS", [""]];
    _cond = _this param [3, {false}, ["",{}]];
    _behaviour = _this param [4, "COMBAT", [""]];

    _acceptableStates = [
        "STAND",
        "STAND_IA",
        "SIT_LOW",
        "KNEEL",
        "LEAN",
        "WATCH",
        "WATCH1",
        "WATCH2"
    ];

    _acceptableGear = [
        "NONE",
        "LIGHT",
        "MEDIUM",
        "FULL",
        "ASIS",
        "RANDOM"
    ];

    if !(_animset in _acceptableStates) exitWith {
        format["Definition of animset '%1' dosn't exist. Possible animsets are %2.",_animset,_acceptableStates] call BIS_fnc_error;
    };

    if !(_gear in _acceptableGear) exitWith {
        format["Definition of gearset '%1' dosn't exist. Possible gearsets are %2.",_gear,_acceptableGear] call BIS_fnc_error;
    };

    if (typeName _cond == typeName "") then {
        _cond = compile _cond;
    };

    [_unit,_animset,_gear,nil,nil,false] call BIS_fnc_ambientAnim;
    _transAnim = "AmovPercMstpSrasWrflDnon";
    [_unit,_cond,_transAnim,_behaviour] spawn {
        private["_unit","_cond","_transAnim","_animHandle","_behaviour","_unitPos"];
        _unit = _this select 0;
        _cond = _this select 1;
        _transAnim = _this select 2;
        _behaviour = _this select 3;

        waitUntil {
            sleep 0.1;
            _animHandle = _unit getVariable ["BIS_EhAnimDone", -1];
            (_animHandle > -1)
        };

        waitUntil {
            sleep 0.1;
            (behaviour _unit == "COMBAT") || {(damage _unit > 0) || {(_unit call _cond) || {(_unit call BIS_fnc_enemyDetected)}}}
        };

        _unitPos = unitPos _unit;

        {_unit enableAI _x} forEach ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"];
        _unit setBehaviour _behaviour;
        _unit setUnitPos "UP";
        detach _unit;
        _unit removeEventHandler ["AnimDone",_animHandle];
        _unit playMoveNow _transAnim;
        sleep ((random 3) + 3);
        _unit setUnitPos _unitPos;
    };
};