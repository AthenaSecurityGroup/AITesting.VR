/*
[C1, "STAND1", "NONE"] call BIS_fnc_ambientAnim;
[C_1,"STAND","ASIS"] call BIS_fnc_ambientAnimCombat;
[C_1, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","LEAN","WATCH","WATCH1","WATCH2"]),(selectrandom ["NONE","LIGHT","MEDIUM","MEDIUM","FULL","ASIS","RANDOM"])] call BIS_fnc_ambientAnimCombat;

[C_1, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_2, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_3, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_4, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_5, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_6, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_7, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_8, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_9, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_10, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_11, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_12, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_13, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_14, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
[C_15, (selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","WATCH","WATCH1","WATCH2"]), "RANDOM", {(player distance _this) < 5}, "SAFE"] call BIS_fnc_ambientAnimCombat;
*/

playaction

Actions:
Down
Medic
MedicOther
Relax
released
Salute
SitDown
StopRelaxed
Surrender


playmove
switchmove

Moves:

/*
Base Posting: React to Contact Defensively
Bases must have invisible named markers at key postings.
Units move to these postings if they know about a threat.
Certain units prefer specific postings, like autoriflemen in corners.
*/

/* BIS_fnc_ambientAnim

[UNIT, "ANIMATION", "GEAR"] call BIS_fnc_ambientAnim;

_U = unarmed variant

Universal
STAND
STAND1
STAND2
STAND_U1
STAND_U2
STAND_U3
WATCH
WATCH2
GUARD
LISTEN_BRIEFING
PRONE_INJURED
PRONE_INJURED_U1
PRONE_INJURED_U2
BRIEFING
BRIEFING_POINT_LEFT
BRIEFING_POINT_RIGHT
BRIEFING_POINT_TABLE

Require props for best use.
LEAN_ON_TABLE
LEAN
SIT_AT_TABLE
SIT
SIT1
SIT2
SIT3
SIT_U1
SIT_U2
SIT_U3
SIT_HIGH
SIT_HIGH1
SIT_LOW
SIT_LOW_U
SIT_SAD1
SIT_SAD2
REPAIR_VEH_PRONE
REPAIR_VEH_KNEEL
REPAIR_VEH_STAND
KNEEL_TREAT
KNEEL_TREAT2