//AI Medic Script
//execvm "AIMedic.sqf";

/*	
	Every AI Unit:
Casualty addeventhandler ["Handledamage",{
	if (_this select 2 > 0.8) then {
		Casualty setunconscious true;
		Casualty setdamage 0.9;
	};
}];
	
	_unit forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"];
*/

//	Every AI Medic:
If (damage Casualty > 0.8) then {
//		Ben forceweaponfire ["SmokeShellMuzzle", "SmokeShellMuzzle"];
//		Jack forceweaponfire ["SmokeShellMuzzle", "SmokeShellMuzzle"];
//		Jon forceweaponfire ["SmokeShellMuzzle", "SmokeShellMuzzle"];
//		Mark forceweaponfire ["SmokeShellMuzzle", "SmokeShellMuzzle"];
//		Rick forceweaponfire ["SmokeShellMuzzle", "SmokeShellMuzzle"];
//		Steve forceweaponfire ["SmokeShellMuzzle", "SmokeShellMuzzle"];
	Medic domove (position Casualty);
	Waituntil {Medic distance Casualty < 2};
	Dostop Medic;
	Medic action ["Heal", Casualty];
	If (alive Casualty) then {
		Sleep 5;
		Casualty setdamage 0;
		Casualty setunconscious false;
		Waituntil {damage Casualty < 0.2};
		Sleep 5;
	};
	Medic dofollow leader Medic;
};

If (damage Casualty > 0.8) then {
	Medic domove (position Casualty);
	Waituntil {Medic distance Casualty < 2};
	Dostop Medic;
	Medic action ["Heal", Casualty];
	If (alive Casualty) then {
		Sleep 5;
		Casualty setdamage 0;
		Casualty setunconscious false;
		Waituntil {damage Casualty < 0.2};
		Sleep 5;
	};
	Medic dofollow leader Medic;
};