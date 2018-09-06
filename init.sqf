[] execVM "Key.sqf";
if (isServer) then {
    IndiCasualties = [];
	[] call compileFinal preprocessFile "SimTools_ForceDeploy.sqf";
};
