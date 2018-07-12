If (!hasinterface) exitwith {}; //If you don't have an interface, do nothing.
Climb = "GetInHemttBack";
Getdown = "AcrgPknlMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon_getOutHigh";

FN_climb = {
	params ["_displaycode","_keycode","_isshift","_isctrl","_isalt"];
	_handled = false;
		if (_keycode in actionkeys "getover" && _isshift) then {
			C1 switchmove climb;
			C1 addeventhandler ["Animdone",{
				C1 removeeventhandler ["Animdone", _thiseventhandler];
				C1 setposatl (C1 modeltoworld [0,2,1]);
				C1 switchmove getdown;
			}];
		};
	_handled
};

waituntil {!(isnull (finddisplay 46))};
(finddisplay 46) displayaddeventhandler ["Keydown", "_this call FN_climb;"];

Cursortarget

/*
hintsilent str (getPosVisual cursortarget);
hint str (getpos GM select 2);

To do:
- Fetch climb criteria
- Freeze input during climb
- Add cancel for certain input

private _objectSize = sizeOf typeOf _object; //--- in meters

Player
GetInHemttBack
"FN_climbact" addpublicvariableeventhandler { //Create a public varable event handler.
	(_this select 1) spawn FN_doclimb; //This is the part that triggers the event.
};


AmovPercMstpSnonWnonDnon_Ease
AmovPercMstpSnonWnonDnon_exercisePushup
AmovPercMstpSnonWnonDnon_exercisekneeBendA

//Animations (Playmove)
gestureAdvance //Forward Fist Pump
gestureAttack //Switchmove Broken
gestureCeaseFire //Fast Window Washing
gestureCover //Big Wave Right Hand
gestureFollow
gestureFreeze
gestureGo //Single Forward Slow Chop
gestureGoB //Wonky "Ladies First"
gestureHi
gestureHiB
gestureHiC
GestureLegPush //Levitate
gestureNo //Headshake
gestureNod //Nod
gesturePoint //Forward Fist Pump
gestureUp //Wonky Resume Formation
gestureYes //Nod

//Wounded
GestureAgonyCargo //Stomache Ache
GestureSpasm0
GestureSpasm0weak
GestureSpasm1
GestureSpasm1weak
GestureSpasm2
GestureSpasm2weak
GestureSpasm3
GestureSpasm3weak
GestureSpasm4
GestureSpasm4weak
GestureSpasm5
GestureSpasm5weak
GestureSpasm6
GestureSpasm6weak

//Climbing
GetInHemttBack //Switchmove High Climb
GetInHigh
GetInLow
GetInMantis
GetInMedium
GetInMortar
GetInMRAP_01
GetInMRAP_01_cargo
GetInMRAP_03
GetInOffroad
GetInOffroadBack
GetInOffroadCargo
GetInQuadbike
GetInQuadbike_cargo
GetInSDV
GetInSpeedboat
GetOutAssaultBoat
GetOutHeli_Attack_01Gunner
GetOutHeli_Attack_01Pilot
GetOutHeli_Light_01bench
GetOutHelicopterCargo
GetOutHigh
GetOutHighHemtt
GetOutHighZamak
GetOutLow
GetOutMantis
GetOutMedium
GetOutMortar
GetOutMRAP_01
GetOutMRAP_01_cargo
GetOutPara
GetOutQuadbike
GetOutQuadbike_cargo
GetOutSDV
GetOutSpeedboat
GetOver
grabCarried
grabCarry
grabDrag
grabDragged