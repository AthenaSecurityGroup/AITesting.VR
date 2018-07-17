action_id = this addaction ["Recruit", {
    params ["_target", "_caller", "_ID"];
    [_target] joinsilent (group _caller);
    _target removeaction _ID;
}, [], 1, true, true, "", "_target distance2D _this <= 5"];

/* PVP Insurgency Idea
Security force collateral damage adds tickets to insurgent pool.
Insurgent collateral damage remove tickets from the insurgent pool.


["face_hub","neck","head","pelvis","spine1","spine2","spine3","body","arms","hands","legs","body"] // Unit hit points

*/


hitpointsdamage

damage

getAllHitPointsDamage