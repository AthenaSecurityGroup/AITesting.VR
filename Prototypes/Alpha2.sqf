/*
// Greek Assault Platoon Improved
if (isServer) then
{
    params ["_trigger"];
    _trigger spawn
    {
        private _pos2200m = (_this getPos [2200,(_this getdir (getMarkerPos "Origin"))]);
        private _bigGroupArray = ["I_Soldier_TL_F","I_soldier_F","I_soldier_F","I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_TL_F","I_soldier_F","I_Soldier_AR_F","I_soldier_F"];
        private _G1 = [_pos2200m, INDEPENDENT, _bigGroupArray,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
        sleep 1;
        private _G2 = [_pos2200m, INDEPENDENT, ["I_officer_F","I_soldier_UAV_F","I_medic_F","I_Soldier_SL_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
        sleep 1;
        private _G3 = [_pos2200m, INDEPENDENT, _bigGroupArray,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
        sleep 1;
        private _G4 = [_pos2200m, INDEPENDENT, _bigGroupArray,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
        sleep 1;
 
        {
            { _x execVM "Gear\FN_CentralGreen.sqf"; } forEach units _x;
            _x setBehaviour "COMBAT";
            _x setFormation "DIAMOND";
        } forEach [_G1,_G2,_G3,_G4];
 
        private _waypoint = _G1 addWaypoint [_this, 0];
        _waypoint setWaypointType "SAD";
        _waypoint setwaypointspeed "FULL";
        sleep 30;
 
        _G2 copyWaypoints _G1;
        _G3 copyWaypoints _G1;
        _G4 copyWaypoints _G1;
 
        {
            private _wpPosition = waypointPosition _x;
            _wpPosition = _wpPosition getPos [300, 270];
            _x setWPPos _wpPosition;
        } forEach waypoints _G3;
 
        {
            private _wpPosition = waypointPosition _x;
            _wpPosition = _wpPosition getPos [300, 90];
            _x setWPPos _wpPosition;
        } forEach waypoints _G4;
    };
};
*/



if (isServer) then {
private ['_Group2A'];
private ['_Group3A'];

_Group16 = [getmarkerpos "Spawner", independent, [
"I_officer_F","I_officer_F","I_medic_F",
"I_soldier_UAV_F","I_Soldier_AA_F","I_Soldier_AA_F"
],[],[],[],[],[],0] call BIS_fnc_spawnGroup;

_wp6 = _Group16 addWaypoint [getmarkerpos "Spawner", 0];
_wp6 setWaypointType "DISMISS";
_wp6 setWaypointSpeed "LIMITED";
_wp6 setWaypointBehaviour "SAFE";

_Group1A = [getpos leader _Group16, independent, [
"I_Soldier_SL_F","I_Soldier_LAT_F","I_Soldier_TL_F","I_Soldier_M_F","I_Soldier_F","I_Soldier_AR_F"],[],[],[],[],[],0] call BIS_fnc_spawnGroup;

_wp1A = _Group1A addWaypoint [getpos (leader _Group16) vectorAdd [-5,25,0], 0];
_wp1A setWaypointType "MOVE";
_wp1A setWaypointSpeed "LIMITED";
_wp1A setWaypointFormation "WEDGE";
_wp1A setWaypointBehaviour "AWARE";
_wp1A setWaypointTimeout [600, 600, 600];

_wp1A2 = _Group1A addWaypoint [getpos (leader _Group16) vectorAdd [0,30,0], 0];
_wp1A2 setWaypointType "DISMISS";
_wp1A2 setWaypointBehaviour "SAFE";

_Group1B = [getpos leader _Group16, independent, [
"I_Soldier_TL_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F",
"I_Soldier_TL_F","I_Soldier_F","I_Soldier_AR_F"],[],[],[],[],[],0] call BIS_fnc_spawnGroup;

_wp1B = _Group1B addWaypoint [getpos (leader _Group16) vectorAdd [5,-25,0], 0];
_wp1B setWaypointType "MOVE";
_wp1B setWaypointSpeed "LIMITED";
_wp1B setWaypointFormation "WEDGE";
_wp1B setWaypointBehaviour "AWARE";
_wp1B setWaypointTimeout [600, 600, 600];

_wp1B2 = _Group1B addWaypoint [getpos (leader _Group16) vectorAdd [0,-30,0], 0];
_wp1B2 setWaypointType "DISMISS";
_wp1B2 setWaypointBehaviour "SAFE";

_Group2 = [getpos leader _Group16, independent, [
"I_Soldier_SL_F","I_Soldier_TL_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F",
"I_Soldier_TL_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F",
"I_Soldier_TL_F","I_Soldier_F","I_Soldier_LAT_F","I_Soldier_AR_F"],[],[],[],[],[],0] call BIS_fnc_spawnGroup;

_wp2 = _Group2 addWaypoint [getpos (leader _Group16) vectorAdd [300,200,0], 0];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointSpeed "LIMITED";
_wp2 setWaypointBehaviour "SAFE";

_wp2A1 = _Group2 addWaypoint [getpos (leader _Group16) vectorAdd [300,-200,0], 0];
_wp2A2 = _Group2 addWaypoint [getpos (leader _Group16) vectorAdd [-20,0,0], 0];
_wp2A2 setWaypointTimeout [600, 600, 600];
_wp2A2 = _Group2 addWaypoint [getpos (leader _Group16) vectorAdd [0,0,0], 0];
_wp2A2 setWaypointType "CYCLE";

_Group3 = [getpos leader _Group16, independent, [
"I_Soldier_SL_F","I_Soldier_TL_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F",
"I_Soldier_TL_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F",
"I_Soldier_TL_F","I_Soldier_F","I_Soldier_LAT_F","I_Soldier_AR_F"],[],[],[],[],[],0] call BIS_fnc_spawnGroup;

_wp3 = _Group3 addWaypoint [getpos (leader _Group16) vectorAdd [-300,-200,0], 0];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointSpeed "LIMITED";
_wp3 setWaypointBehaviour "SAFE";

_wp3A1 = _Group3 addWaypoint [getpos (leader _Group16) vectorAdd [-300,200,0], 0];
_wp3A2 = _Group3 addWaypoint [getpos (leader _Group16) vectorAdd [20,0,0], 0];
_wp3A2 setWaypointTimeout [600, 600, 600];
_wp3A2 = _Group3 addWaypoint [getpos (leader _Group16) vectorAdd [0,0,0], 0];
_wp3A2 setWaypointType "CYCLE";
};

/*
[_Group2A,20,_Group2B] spawn {
    followWaypoint = param[2,_Group2A] addWaypoint [param[0,grpNull,[grpNull]]];
    while {TRUE} do {
        uiSleep param[1,5,[0]]
        param[2,_Group2A] addWaypoint [param[0,grpNull,[grpNull]],followWaypoint];
    };
};
*/