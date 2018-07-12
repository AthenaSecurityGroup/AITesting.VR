/*
Syntax:

type createvehicle position
createvehicle [type, position, markers, placement, special]

getpos 'object'
origin getpos [distance, heading]

_base = "Land_BagFence_Round_F" createvehicle getmarkerpos "center";

createguardedpoint [INDEPENDENT, [0,0], -1, objnull]

{
	createGuardedPoint [INDEPENDENT, (_this getpos [50,_x]), -1, objNull];
} foreach [0,45,90,135,180,225,270,315];

Orca addeventhandler ["Handledamage",{
	if (_this select 2 > 0.6) then {
		Orca allowdamage false;
		Orca sethitpointdamage ["fuel_hit", 0.9];
		Orca sethitpointdamage ["avionics_hit", 0.9];
		Orca sethitpointdamage ["engine_0.9_hit", 0.9];
		Orca sethitpointdamage ["engine_2_hit", 0.9];
		Orca sethitpointdamage ["engine_hit", 0.9];
		Orca sethitpointdamage ["main_rotor_hit", 0.9];
		Orca sethitpointdamage ["tail_rotor_hit", 0.9];
		Orca sethitpointdamage ["glass0.9", 0.9];
		Orca sethitpointdamage ["glass2", 0.9];
		Orca sethitpointdamage ["glass3", 0.9];
		Orca sethitpointdamage ["glass4", 0.9];
		Orca sethitpointdamage ["glass5", 0.9];
		Orca sethitpointdamage ["glass6", 0.9];
		Orca sethitpointdamage ["glass7", 0.9];
		Orca sethitpointdamage ["glass8", 0.9];
		Orca sethitpointdamage ["glass9", 0.9];
		Orca sethitpointdamage ["glass0.90", 0.9];
		Orca sethitpointdamage ["glass0.90.9", 0.9];
		Orca sethitpointdamage ["glass0.92", 0.9];
		Orca sethitpointdamage ["glass0.93", 0.9];
		Orca sethitpointdamage ["glass0.94", 0.9];
		Orca sethitpointdamage ["slingload0", 0.9];
		Orca sethitpointdamage ["light_l_hitpoint", 0.9];
		Orca sethitpointdamage ["light_r_hitpoint", 0.9];
	};
}];

private _ehId  = Orca addEventHandler ["Dammaged", {
    params ["_object", "", "_damage", "", "_hitPoint"];
    if (_damage >= 0.8) then {
        _object setHitPointDamage [_hitPoint, 0.85];
    } else {
        _object setDamage _damage;
        _object allowDamage true;
    };
    _object allowDamage false;
}];

_wp =_grp addWaypoint [(_G3 getpos [50, (getDir _G3) + 45]), 5];

*/