if (isServer) then {
Group2 = [getmarkerpos "Spawner", independent, [
"I_Soldier_SL_F","I_Soldier_TL_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F"],[],[],[],[],[],0] call BIS_fnc_spawnGroup;

_wp2 = Group2 addWaypoint [getmarkerpos "Spawner" vectorAdd [300,200,0], 0];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointSpeed "LIMITED";
_wp2 setWaypointBehaviour "SAFE";

_wp2A1 = Group2 addWaypoint [getmarkerpos "Spawner" vectorAdd [300,-200,0], 0];
_wp2A2 = Group2 addWaypoint [getmarkerpos "Spawner" vectorAdd [-20,0,0], 0];
_wp2A2 setWaypointTimeout [600, 600, 600];
_wp2A2 = Group2 addWaypoint [getmarkerpos "Spawner" vectorAdd [0,0,0], 0];
_wp2A2 setWaypointType "CYCLE";

Group2B = [getmarkerpos "Spawner", independent, [
"I_Soldier_TL_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F"],[],[],[],[],[],0] call BIS_fnc_spawnGroup;

[group2, 20, group2B] spawn {
    params ['_groupA', '_waitTime', '_groupB'];
    followWaypoint = _groupB addWaypoint [_groupA, 0];
    while {true} do {
        uiSleep _waitTime;
        _groupA addWaypoint [_groupA, followWaypoint];
    };
};
};

if (isServer) then {
	params ["_trigger"];
	_trigger spawn {
		_G1 = [(getPos _this), INDEPENDENT, ["I_Soldier_TL_F","I_soldier_F","I_soldier_F","I_Soldier_AR_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		Sleep 1;
		_G2 = [(getPos _this), INDEPENDENT, ["I_Soldier_SL_F","I_Soldier_TL_F","I_soldier_F","I_soldier_F","I_Soldier_AR_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		Sleep 1;
		_G3 = [(getPos _this), INDEPENDENT, ["I_officer_F","I_soldier_UAV_F","I_medic_F","I_Soldier_SL_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		Sleep 1;
		_G4 = [(getPos _this), INDEPENDENT, ["I_Soldier_TL_F","I_Soldier_M_F","I_soldier_F","I_Soldier_AR_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		Sleep 1;
		_G5 = [(getPos _this), INDEPENDENT, ["I_Soldier_SL_F","I_Soldier_TL_F","I_soldier_F","I_soldier_F","I_Soldier_AR_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		Sleep 1;
		_G6 = [(getPos _this), INDEPENDENT, ["I_Soldier_TL_F","I_soldier_F","I_soldier_F","I_Soldier_AR_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		Sleep 1;
		_G7 = [(getPos _this), INDEPENDENT, ["I_Soldier_SL_F","I_Soldier_TL_F","I_soldier_F","I_soldier_F","I_Soldier_AR_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
			{
				{
//					_x execVM "Gear\FN_CentralGreen.sqf";
					_x setBehaviour "SAFE";
					_x setFormation "WEDGE";
				} forEach units _x;
			} forEach [_G1,_G2,_G3,_G4,_G5,_G6,_G7];
		_G1 addwaypoint [_this, 2400];
		[_G1, 1] setWaypointType "MOVE";
		[_G1, 1] setwaypointspeed "LIMITED";
		Sleep 30;
		_G1 addwaypoint [_this, 2400];
		_G1 addwaypoint [_this, 2400];
		_G1 addwaypoint [_this, 2400];
		[_G1, 4] setWaypointType "CYCLE";
		_G2 copyWaypoints _G1;
		Sleep 30;
		_G3 copyWaypoints _G1;
		Sleep 30;
		_G4 copyWaypoints _G1;
		Sleep 30;
		_G5 copyWaypoints _G1;
		Sleep 30;
		_G6 copyWaypoints _G1;
		Sleep 30;
		_G7 copyWaypoints _G1;
//		deleteVehicle _this
	};
};

/*
I_officer_F
I_soldier_UAV_F
I_medic_F
I_Soldier_SL_F
I_Soldier_TL_F
I_Soldier_M_F
I_Soldier_GL_F
I_soldier_F
I_Soldier_AR_F


					_x setFormation (selectRandom ["COLUMN","STAG COLUMN","WEDGE","LINE","FILE","DIAMOND"]);
					_x setFormation "WEDGE";

{
    private _waypoint = _x;

    private _wpPosition = waypointPosition _waypoint;
    _wpPosition = _wpPosition getPos [90, 1000]; // move position 1000 meters east
    _waypoint setWPPos _wpPosition;
} forEach waypoints _group;

*/