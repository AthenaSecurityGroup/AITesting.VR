//AI Medic Script

/*	Every AI Unit:
	Chuck addEventHandler ["HandleDamage",{
		if (_this select 2 > 0.8) then {
			Chuck setunconscious true;
			Chuck setdamage 0.9;
		};
	}];
*/

//	Every AI Medic:
	If (damage Chuck > 0.8) then {
		Ralph domove (position Chuck);
		Waituntil {Ralph distance Chuck < 2};
		Dostop Ralph;
		Ralph action ["Heal", Chuck];
		If (!alive Chuck) then {
			Ralph dofollow leader Ralph;
		} else {
			Sleep 10;
			Chuck setdamage 0;
			Chuck setunconscious false;
			Waituntil {damage Chuck < 0.2};
			Sleep 5;
			Ralph dofollow leader Ralph;
		};
	};








	If (damage Chuck > 0.3) then {
		Ralph domove (position Chuck);
		Waituntil {Ralph distance Chuck < 2};
		Dostop Ralph;
		Ralph action ["Heal", Chuck];
		Sleep 10;
		Chuck setdamage 0;
		Chuck setunconscious false;
		Waituntil {damage Chuck < 0.3};
		Sleep 5;
		Ralph dofollow leader Ralph;
	};

//Chuck
/*
Chuck addEventHandler ["HandleDamage",{ 
    if (_this select 2 > 0.8) then {
	Chuck setunconscious true;
	Chuck setunitpos "down";
	};
}];

//Ralph

While {alive Ralph} do {
	Sleep 30;
	if (damage Chuck > 0.2) then {
	Ralph domove (position Chuck);
	While {Ralph distance Chuck > 2} do {
		Sleep 5;
		Ralph domove (position Chuck);
	};
	Sleep 1;
	Ralph action ["Heal", Chuck];
	Waituntil {damage Chuck < 0.1};
	Sleep 1;
//	Chuck setunitpos "auto";
//	Ralph setunitpos "auto";
	};
};


if (damage Chuck > 0.2) then {
Ralph domove (position Chuck);
Chuck action ["Heal", Ralph];

Ralph domove (position Chuck);

Ralph action ["Heal", Chuck];

Chuck setdamage 0;

Chuck setunconscious false;

Chuck setunitpos "auto";


if (damage Chuck > 0.2) then {
 Ralph domove (position Chuck);
 Sleep 5;
 Ralph action ["Heal", Chuck];
 Sleep 5;
 Chuck setdamage 0;
 Chuck setunconscious false;
};



//Every AI Unit:
Chuck addEventHandler ["HandleDamage",{
	if (_this select 2 > 0.8) then {
		Chuck setunconscious true;
		Chuck setdamage 0.9;
	};
}];



//Every AI Medic:
	If (damage Chuck > 0.3) then {
//		Jon dotarget Chuck;
//		[Jon, "SmokeShellMuzzle"] call BIS_fnc_fire;
//		Sleep 5;
		Ralph domove (position Chuck);
		Waituntil {Ralph distance Chuck < 2};
		Dostop Ralph;
		Ralph action ["Heal", Chuck];
		If (!alive Chuck) then {
			Ralph dofollow leader Ralph;
		} else {
			Sleep 10;
			Chuck setdamage 0;
			Chuck setunconscious false;
			Waituntil {damage Chuck < 0.3};
			Sleep 5;
			Ralph dofollow leader Ralph;
		};
	};


*/

If (damage Chuck > 0.7) then {
	Ralph domove (position Chuck);
	Waituntil {Ralph distance Chuck < 2};
	Dostop Ralph;
	Ralph action ["Heal", Chuck];
	Sleep 10;
	If (alive Chuck) then {
		Chuck setdamage 0;
		Chuck setunconscious false;
		Waituntil {damage Chuck < 0.2};
	};
	Ralph dofollow leader Ralph;
};

//Unit Init

Chuck addEventHandler ["HandleDamage",{ 
    if (_this select 2 > 0.8) then {
	Chuck setunconscious true;
	};
}];

//Medic Init
_medic = _this select 0;
_units = _this select 1;
_injured = objNull;
if (isPlayer _medic) exitWith{};
if (not isServer) exitWith{};

while {alive _medic} do {
sleep 2;
//waiting for a wounded
while {isNull _injured} do {
	//if the medic is injured
	if (getDammage _medic > 0.1) then {
		//if medic is already dead, then exit
		if (!alive _medic) exitWith{};
		//else he is the injured and he is a priority to heal himself
		_injured = _medic;
	} else {		
		{
			//player sideChat format["%1 sebesulese %2", name _x, getDammage _x];
			if (isNull _injured and getDammage _x > 0.1) then {			
				_injured = _x;
				//player sideChat format["megvan a sebesult: ", name _x];
				_medic sideChat format["Keep calm %1, I will heal you.", (name _injured)];
			};
		} foreach _units;
	};
	sleep 5;
};

//we have an injured, stop him
if ((!isPlayer _injured) and (_medic!=_injured)) then {
	_injured disableAI "MOVE";
	_injured setUnitPos "down";
};
if (_medic!=_injured) then {
	//medic go for him
	_medic doMove (position _injured);
	while {_medic distance _injured > 3} do {
		sleep 2;
		_medic doMove (position _injured);
	};
};
//when medic is close enough to the injured...
sleep 1;
//...and injured is still alive
if (alive _injured) then {	
	//stop the medic
	_medic disableAI "MOVE";
	_medic setUnitPos "middle";

	//HEAL the injured
	// ******************************
	_injured action ["Heal", _medic];
	// ******************************


	//wait until injured is healed or dead
	waitUntil { (getDammage _injured < 0.1) or (!alive _injured) };
	sleep 3;
	if (_medic!=_injured) then {
		_medic sideChat format["OK %1, you are ready to fight.", (name _injured)];
	};

	if (!isPlayer _injured) then {
		//healed soldier is ready to fight
		_injured enableAI "MOVE";
		_injured setUnitPos "auto";
	};
};
//we are ready for looking a new injured
_injured = objNull;
//set the medic to ready to looking for a new injured
_medic enableAI "MOVE";
_medic setUnitPos "auto";
//doMove stops the medic, so we have to command him to follow his leader
_medic doFollow (leader group _medic);
};

_Medic = _this select 0;
_Units = _this select 1;
_Casualty = objNull;

if (isplayer _Medic) exitwith {};
if (!isserver) exitwith {};

While {alive _Medic} do {
	Sleep 30;
	While {isnull _Casualty} do {
		if (getdammage _Medic > 0.1) then {
		if (!alive _Medic) exitwith {};
		_Casualty = _Medic;} else {
			{
				if isnull _Casualty and getdammage _x > 0.1) then {
				_Casualty = _x;
				};
			} foreach _Units;
		}:
		Sleep 1;
	};

	if ((!isplayer _Casualty) and (_Medic != _Casualty)) then {
		_Casualty setunitpos "down";
	};

	if (_Medic != _Casualty) then {
		_Medic domove (position _Casualty);
		while {_Medic distance _Casualty > 2} do {
			Sleep 5;
			_Medic domove (position _Casualty);
		};

	};

	Sleep 1;
	if (alive _Casualty) then {
		_Medic disableAI "MOVE";
		_Medic setunitpos "middle";
		_Casualty action ["Heal", _Medic];
		waituntil {(damage _Casualty < 0.1) or (!alive _Casualty)};
		Sleep 1;
		_Casualty setunitpos "auto";
	};

	_Casualty = objnull;
	_Medic enableAI "MOVE";
	_Medic setunitpos "auto";
	_Medic dofollow (leader group _Medic);
};

Chuck addEventHandler ["HandleDamage",{ 
    if (_this select 2 > 0.8) then {
	Chuck setunconscious true;
	Chuck setunitpos "down";
	};
}];

//////////////////////////////////////////////////

While {alive Ralph} do {
	Sleep 30;
	if (damage Chuck > 0.2) then {
	Ralph domove (position Chuck);
	While {Ralph distance Chuck > 2} do {
		Sleep 5;
		Ralph domove (position Chuck);
	};
	Sleep 1;
	Chuck setunitpos "down";
	Ralph setunitpos "middle";
	Chuck action ["Heal", Ralph];
	Waituntil {damage Chuck < 0.1};
	Sleep 1;
	Chuck setunitpos "auto";
	Ralph setunitpos "auto";
	};
};

	//Copytoclipboard getallhitpointsdamage Orca;
	
	["hull_hit",
	"fuel_hit",
	"avionics_hit",
	"",
	"engine_1_hit",
	"engine_2_hit",
	"engine_hit",
	"main_rotor_hit",
	"tail_rotor_hit",
	"glass1",
	"glass2",
	"glass3",
	"glass4",
	"glass5",
	"glass6",
	"glass7",
	"glass8",
	"glass9",
	"glass10",
	"glass11",
	"glass12",
	"glass13",
	"glass14",
	"","","",
	"slingload0",
	"transmission",
	"","","","","","","","","","","","","","",
	"light_l_hitpoint",
	"light_r_hitpoint"]

if (damage Orca > 0.9) then {
allowdamage false;};

Orca addeventhandler ["Handledamage",{
	if (_this select 2 > 0.9) then {
		Orca allowdamage false;
	};
}];

Orca addeventhandler ["Handledamage",{
	if (_this select 2 > 0.9) then {
		Orca allowdamage false;
		Orca damage "fuel_hit" 1;
		Orca damage "avionics_hit" 1;
		Orca damage "engine_1_hit" 1;
		Orca damage "engine_2_hit" 1;
		Orca damage "engine_hit" 1;
		Orca damage "main_rotor_hit" 1;
	};
}];