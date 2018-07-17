params [
	"_medic",
	"_casualties"
];

while {alive _medic} do {
	waitUntil {
		sleep 30; //300
		count _casualties > 0 && {
			_casualty = _casualties select 0;
			_medic distance _casualty <= 400;
		};
	};

	_casualty = _casualties select 0;
	// Mutates reference to casualty "queue".
	_casualties deleteRange [0, 1];

	_medic doMove (position _casualty);
	waitUntil {_medic distance _casualty < 2};
	doStop _medic;
	_medic action ["Heal", _casualty];
	if (alive _casualty) then {
		sleep 5;
		_casualty setdamage 0;
		_casualty setunconscious false;
		waitUntil {damage _casualty < 0.2};
		sleep 5;
	};
	_medic doFollow (leader _medic);
};

/*
TODO = see if possible to check for casualties after treating,
before restarting whole loop.
*/
