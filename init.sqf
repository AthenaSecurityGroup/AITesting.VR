[] execVM "Key.sqf";
if (isServer) then {
    IndiCasualties = [];
	[[
		["BN", [], []],
		["BN", [], []]
	]] call SimTools_ForceDeployment_fnc_deployForce;
};
