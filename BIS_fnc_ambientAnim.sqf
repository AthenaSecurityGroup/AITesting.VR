//copytoclipboard str BIS_fnc_ambientAnim;
//Off watch, unresponsive.

{
	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'BIS_fnc_ambientAnim'} else {_fnc_scriptName};
	private _fnc_scriptName = 'BIS_fnc_ambientAnim';
	scriptName _fnc_scriptName;
    private["_fnc_log_disable"];_fnc_log_disable = false;

    if (isNil "BIS_fnc_ambientAnim__group") then {
        BIS_fnc_ambientAnim__group = createGroup west;
    };

    private["_unit","_animset","_gear","_anims","_anim","_linked","_xSet","_azimutFix","_interpolate","_canInterpolate","_attach"];
    private["_attachOffset","_attachObj","_attachSpecsAuto","_attachSpecs","_attachSnap","_noBackpack","_noWeapon","_randomGear","_weapon","_forcedSnapPoint","_params"];

    _unit  	 	 = _this param [0, objNull, [objNull]];
    _animset 	 = _this param [1, "STAND", [""]];
    _gear    	 = _this param [2, "RANDOM", [""]];
    _forcedSnapPoint = _this param [3, objNull, [objNull]];
    _interpolate	 = _this param [4, false, [true]];
    _attach		 = _this param [5, true, [true]];

    if (isNull _unit) exitWith {};

    if (isNil "_forcedSnapPoint") then {
        ["Forced snappoint doesn't exist!"] call BIS_fnc_error;
        _forcedSnapPoint = objNull;
    };

    if ((_unit getVariable ["BIS_fnc_ambientAnim__animset",""]) != "") exitWith {
        ["[%1] Trying to play an ambient animation [%3] while another [%2] is already playing!",_unit,_unit getVariable ["BIS_fnc_ambientAnim__animset",""],_animset] call BIS_fnc_logFormat;
    };

    {_unit disableAI _x} forEach ["ANIM","AUTOTARGET","FSM","MOVE","TARGET"];

    detach _unit;
    _weapon = primaryWeapon _unit;

    if (_weapon != "") then {
        _unit setVariable ["BIS_fnc_ambientAnim__weapon",_weapon];
    };

    _params = _animset call BIS_fnc_ambientAnimGetParams;

    _anims		= _params select 0;
    _azimutFix 	= _params select 1;
    _attachSnap 	= _params select 2;
    _attachOffset 	= _params select 3;
    _noBackpack 	= _params select 4;
    _noWeapon 	= _params select 5;
    _randomGear 	= _params select 6;
    _canInterpolate = _params select 7;
    
    if (count _anims == 0) exitWith {};

    if (_gear == "RANDOM") then {
        _gear = _randomGear call BIS_fnc_selectRandom;
    };

    [_unit,_gear,_noWeapon,_noBackpack,_weapon] spawn {
        private["_unit","_gear","_noWeapon","_noBackpack","_weapon"];

        _unit 		= _this select 0;
        _gear 		= _this select 1;
        _noWeapon 	= _this select 2;
        _noBackpack 	= _this select 3;
        _weapon		= _this select 4;

        sleep 1;

        switch (_gear) do {
            case "NONE":
            {
                removeGoggles _unit;
                removeHeadgear _unit;
                removeVest _unit;
                removeAllWeapons _unit;
                
                _noBackpack = true;
                _noWeapon = true;
            };

            case "LIGHT":
            {
                removeGoggles _unit;
                removeHeadgear _unit;
                removeVest _unit;
                
                _noBackpack = true;
            };

            case "MEDIUM":
            {
                removeGoggles _unit;
                removeHeadgear _unit;
            };
            
            case "FULL":
            {
                removeGoggles _unit;
            };
            
            default
            {};
        };
        
        if (_gear != "ASIS") then {
            { _unit unassignItem _x } forEach
            [
                "NVGogglesB_grn_F",
                "NVGoggles_tna_F",
                "NVGogglesB_gry_F",
                "NVGoggles_ghex_F",
                "NVGoggles_hex_F",
                "NVGoggles_urb_F",
                "nvgoggles", 
                "nvgoggles_opfor",
                "nvgoggles_indep"
            ];
        };
        
        if (_noBackpack) then {
            removeBackpack _unit;
        };
        
        if (_noWeapon) then {
            _unit removeWeapon _weapon;
        } else {
            private["_storedWeapon"];
            _storedWeapon = _unit getVariable ["BIS_fnc_ambientAnim__weapon",""];

            if (primaryWeapon _unit == "" && _storedWeapon != "") then {
                _unit addWeapon _storedWeapon;
                _unit selectWeapon _storedWeapon;
            };
        };
    };
    
    _linked = _unit nearObjects ["man",5];
    _linked = _linked - [_unit];
    
    {
        _xSet = _x getVariable ["BIS_fnc_ambientAnim__animset",""];
        if (_xSet != _animset || _xSet == "") then {
            _linked set [_forEachIndex,objNull];
        } else {
            _xLinked = _x getVariable ["BIS_fnc_ambientAnim__linked",[]];
            
            if !(_unit in _xLinked) then {
                _xLinked = _xLinked + [_unit];
                _x setVariable ["BIS_fnc_ambientAnim__linked",_xLinked];
            };
        };
    } forEach _linked; _linked = _linked - [objNull];

    _attachSpecsAuto = switch (_animset) do {
        case "SIT_AT_TABLE": {
            [
                ["Land_CampingChair_V2_F",[0,0.08,-0.02],-180],
                ["Land_ChairPlastic_F",[0,0.08,-0.02],90],
                ["Land_ChairWood_F",[0,0.02,-0.02],-180]
            ];
        };
        
        case "SIT";
        case "SIT1";
        case "SIT2";
        case "SIT3";
        case "SIT_U1";
        case "SIT_U2";
        case "SIT_U3":
        
        {
            [
                ["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
                ["Land_ChairPlastic_F",[0,0.08,0.05],90],
                ["Land_ChairWood_F",[0,0.02,0.05],-180]
            ];
        };
        
        case "SIT_SAD1": {
            [
                ["Box_NATO_Wps_F",[0,-0.27,0.03],0]
            ];
        };

        case "SIT_SAD2": {
            [
                ["Box_NATO_Wps_F",[0,-0.3,0.05],0]
            ];
        };

        case "SIT_HIGH1": {
            [
                ["Box_NATO_Wps_F",[0,-0.23,0.03],0]
            ];
        };
        
        case "SIT_HIGH";
        case "SIT_HIGH2": {
            [
                ["Box_NATO_Wps_F",[0,-0.12,-0.20],0]
            ];
        };
        
        default {
            [];
        };
    };
    
    if ((count _attachSpecsAuto > 0) && !(_gear in ["NONE","LIGHT"])) then {
        private["_attachPoint","_attachGearFix","_vest"];
        _attachGearFix = 0.06;
        _vest = toLower (vest _unit);
        
        if (_vest in ["v_platecarrier1_rgr"]) then {
            _attachGearFix = _attachGearFix + 0.08;
        };
        
        {
            _attachPoint = _x select 1;
            _attachPoint set [1, (_attachPoint select 1) + _attachGearFix];
            _x set [1, _attachPoint];
        } forEach _attachSpecsAuto;
    };
    
    _attachSpecsAuto = _attachSpecsAuto + [["Sign_Pointer_Cyan_F",[0,0,_attachOffset],0]];
    
    if !(isNull _forcedSnapPoint) then {
        _attachObj = _forcedSnapPoint;
        _attachSpecs = [typeOf _forcedSnapPoint,[0,0,_attachOffset],0];
        
        {
            if ((_x select 0) == typeOf _forcedSnapPoint) exitWith {
                _attachSpecs = _x;
            };
        } forEach _attachSpecsAuto;
    } else {
        _attachSpecs = [typeOf _unit,[0,0,_attachOffset],0];
        _attachObj = _unit;
        
        private["_obj"];
        
        {
            _obj = nearestObject [_unit, _x select 0];
            
            if (([_obj,_unit] call BIS_fnc_distance2D) < _attachSnap) exitWith {
                _attachSpecs = _x;
                _attachObj = _obj;
            };
        } forEach _attachSpecsAuto;
    };
    
    _unit setVariable ["BIS_fnc_ambientAnim__linked",_linked];
    _unit setVariable ["BIS_fnc_ambientAnim__anims",_anims];
    _unit setVariable ["BIS_fnc_ambientAnim__animset",_animset];
    _unit setVariable ["BIS_fnc_ambientAnim__interpolate",_interpolate && _canInterpolate];
    _unit setVariable ["BIS_fnc_ambientAnim__time",0];
    _attachObj disableCollisionWith _unit;
    _unit disableCollisionWith _attachObj;
    
    [_unit,_attachObj,_attachSpecs,_azimutFix,_attach] spawn {
        private["_unit","_attachObj","_attachSpecs","_azimutFix","_group","_attach"];
        private["_attachPos","_logic","_ehAnimDone","_ehKilled"];
        
        _unit = _this select 0;
        _attachObj = _this select 1;
        _attachSpecs = _this select 2;
        _azimutFix = (_this select 3) + (_attachSpecs select 2);
        _attach	= _this select 4;
        
        waitUntil{time > 0};
        
        if (isNil "_unit") exitWith {};
        if (isNull _unit) exitWith {};
        if !(alive _unit && canMove _unit) exitWith {};
        
        _attachPos = getPosASL _attachObj;
        _group = BIS_fnc_ambientAnim__group;
        _logic = _group createUnit ["Logic", [_attachPos select 0,_attachPos select 1,0], [], 0, "NONE"];
        if (isNull _logic) exitWith {
            _unit call BIS_fnc_ambientAnim__playAnim;
            if (count units _group == 0) then {
                deleteGroup _group;
            };
        };
        
        _logic setPosASL _attachPos;
        _logic setDir ((getDir _attachObj) + _azimutFix);
        _unit setVariable ["BIS_fnc_ambientAnim__logic",_logic];
        _unit setVariable ["BIS_fnc_ambientAnim__helper",_attachObj];
        if (_attach) then {
            _unit attachTo [_logic,_attachSpecs select 1];
            _unit setVariable ["BIS_fnc_ambientAnim__attached",true];
        };
        
        _unit call BIS_fnc_ambientAnim__playAnim;
        _ehAnimDone = _unit addEventHandler ["AnimDone", {
            private["_unit","_anim","_pool"];
            _unit = _this select 0;
            _anim = _this select 1;
            _pool = _unit getVariable ["BIS_fnc_ambientAnim__anims",[]];
            
            if (alive _unit) then {
                _unit call BIS_fnc_ambientAnim__playAnim;
            } else {
                _unit call BIS_fnc_ambientAnim__terminate;
            };
        }];
    
        _unit setVariable ["BIS_EhAnimDone", _ehAnimDone];
        _ehKilled = _unit addEventHandler ["Killed", {
            (_this select 0) call BIS_fnc_ambientAnim__terminate;
        }];
    
       _unit setVariable ["BIS_EhKilled", _ehKilled];
    };
    
    BIS_fnc_ambientAnim__playAnim = { 
        private["_unit","_anims","_anim","_available","_time","_linkedUnits","_linkedAnims","_xTime","_interpolate"];
        
        if (isNull _this) exitWith {};
        if !(alive _this && canMove _this) exitWith {};
        _unit = _this;
        _anims = _unit getVariable ["BIS_fnc_ambientAnim__anims",[]];
        if (count _anims == 0) exitWith {
            ["Unit '%1' doesn't have defined ambient anims!",_unit,_anims] call BIS_fnc_logFormat;
        };
        
        _linkedUnits = _unit getVariable ["BIS_fnc_ambientAnim__linked",[]];
        _linkedAnims = [];
        _time = time - 10;
        
        {
            _xTime = _x getVariable ["BIS_fnc_ambientAnim__time",_time];
            if (_xTime > _time) then {
                _linkedAnims = _linkedAnims + [animationState _x];
            };
        } forEach _linkedUnits;
        
        _available = _anims - _linkedAnims;
        if (count _available == 0) then {
            ["Unit '%1' doesn't have an available/free animation to play",_unit] call BIS_fnc_logFormat;
            
            _available = _anims;
        };
        
        _anim = _available call BIS_fnc_selectRandom;
        _interpolate = _unit getVariable ["BIS_fnc_ambientAnim__interpolate",false];
        if (_interpolate) then {
            _unit playMoveNow _anim;
        } else {
            _unit switchMove _anim;
        };
    };
    
    BIS_fnc_ambientAnim__terminate = {
        private["_unit","_ehAnimDone","_ehKilled","_fnc_log_disable","_detachCode"];
        _fnc_log_disable = false;
        if (typeName _this == typeName []) exitWith {
            {
                _x call BIS_fnc_ambientAnim__terminate;
            } forEach _this;
        };
        
        if (typeName _this != typeName objNull) exitWith {};
        if (isNull _this) exitWith {};
        
        _unit = _this;
        
        {_unit enableAI _x} forEach ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"];
        _ehAnimDone = _unit getVariable ["BIS_EhAnimDone",-1];
        _ehKilled = _unit getVariable ["BIS_EhKilled",-1];
        if (_ehAnimDone != -1) then {
            _unit removeEventHandler ["AnimDone",_ehAnimDone];
            _unit setVariable ["BIS_EhAnimDone",-1];
        };
        
        if (_ehKilled != -1) then {
            _unit removeEventHandler ["Killed",_ehKilled];
            _unit setVariable ["BIS_EhKilled",-1];
        };
        
        _detachCode = {
            private["_logic"];
            if (isNull _this) exitWith {};
            _logic = _this getVariable ["BIS_fnc_ambientAnim__logic",objNull];
            if !(isNull _logic) then {
                deleteVehicle _logic;
            };
            
            _this setVariable ["BIS_fnc_ambientAnim__attached",nil];
            _this setVariable ["BIS_fnc_ambientAnim__animset",nil];
            _this setVariable ["BIS_fnc_ambientAnim__anims",nil];
            _this setVariable ["BIS_fnc_ambientAnim__interpolate",nil];
            _this setVariable ["BIS_fnc_ambientAnim__time",nil];
            _this setVariable ["BIS_fnc_ambientAnim__logic",nil];
            _this setVariable ["BIS_fnc_ambientAnim__helper",nil];
            _this setVariable ["BIS_fnc_ambientAnim__linked",nil];
            
            detach _this;
            
            if (alive _this) then {
                _this switchMove "";
            };
        };
        
        if (time > 0) then {
            _unit call _detachCode;
        } else {
            [_unit,_detachCode] spawn {
                sleep 0.3; (_this select 0) call (_this select 1);
            };
        };
    };
};