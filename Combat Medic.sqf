//AI Medic Script
/* To do; try to check for casualties still in queue before restarting loop.

Mission initialization:
if (isServer) then {
    IndiCasualties = [];
};

Every AI unit initialization:
_any/everyunit addeventhandler ["Handledamage",{
    if (_this select 2 > 0.8) then {
        _unit = _this select 0;
        _unit setunconscious true;
        IndiCasualties pushBackUnique _unit;
    };
}];*/
params [
    "_medic",
    "_casualties"
];

while {alive _medic} do {
    waitUntil {
        sleep 30;
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
