//Design Doc and Notes

/*
Base Posting: React to Contact Defensively
Bases must have invisible named markers at key postings.
Units move to these postings if they know about a threat.
Certain units prefer specific postings, like autoriflemen in corners.
*/

AI action "chain,"
Secure (Secure local area, prepare)
Supply (Logistics)
Survey (Reconnaissance)
Seek (Move to Contact)
Seize (Attack)
Secure (Repeat)

Three levels of resistance;
Discovered means element knows its location is known to other factions.
Challenged means element has been engaged.
Defeated means element has been forced to break contact.

_Group = [Position, SIDE,
1 ["Units","Units"],
2 [Relative Positions],
3 [Ranks],
4 [Skill Range],
5 [Ammo Count Range],
6 [Random Controls],
180] call BIS_fnc_spawnGroup;

[group, position, target, clearUnknownMines] call BIS_fnc_wpDemine;
[group this, getPos this, 1000] call bis_fnc_taskPatrol;
[group player, getMarkerPos "mineField", objNull, false] call BIS_fnc_wpDemine;

[group this, getPos this, objnull, true] call BIS_fnc_wpDemine;

	waitUntil {
		isNull _HQ
	};

systemChat "HQ deleted.";

[group this, getPos this, objnull, true] call BIS_fnc_wpDemine;

Null = execvm "Animation.sqf";

rank cursorobject;