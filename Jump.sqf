//By Soulkobk at https://github.com/soulkobk/ArmA_Scripts/blob/master/playerJump/playerJump.sqf
If (!hasinterface) exitwith {}; //If you don't have an interface, do nothing.

Jumpbase = 1.00; //Jump at least this high.
Jumpmax = 2.00; //Jump this high if not encumbered.
Jumpspeed = 0.50; //Forward distance of jump.
Jumpact = "AovrPercMrunSrasWrflDf"; //This is the animation.

"FN_jumpact" addpublicvariableeventhandler { //Create a public varable event handler.
	(_this select 1) spawn FN_dojump; //This is the part that triggers the event.
};

FN_dojump =
{    
    params ["_unit","_velocity","_direction","_speed","_height","_anim"];
	_unit setvelocity [(_velocity select 0) + (sin _direction * _speed), (_velocity select 1) + (cos _direction * _speed), ((_velocity select 2) * _speed) + _height];
	_unit switchmove _anim;
};

FN_jump = {
	params ["_displaycode","_keycode","_isshift","_isctrl","_isalt"];
	_handled = false;
	if ((_keycode in actionkeys "getover" && _isshift) && (animationState player != jumpact)) then {
		private ["_height","_velocity","_direction","_speed"];
		if ((player == vehicle player) && (istouchingground player) && ((stance player == "STAND") || (stance player == "CROUCH"))) exitwith
		{
			_height = (jumpbase - (load player)) max jumpmax;
			_velocity = velocity player;
			_direction = direction player;
			_speed = jumpspeed;
			player setvelocity [(_velocity select 0) + (sin _direction * _speed), (_velocity select 1) + (cos _direction * _speed), ((_velocity select 2) * _speed) + _height];
			FN_jumpact = [player,_velocity,_direction,_speed,_height,jumpact];
			publicvariable "FN_jumpact";
			if (currentweapon player == "") then // half working buggy 'fix' for having no weapon in hands (no animation available for it... BIS!!)
			{
				player switchmove jumpact;
				player playmovenow jumpact;
			}
			else
			{
				player switchmove jumpact;
			};
			_handled = true;
		};
	};
	_handled
};

waituntil {!(isnull (finddisplay 46))};
(finddisplay 46) displayaddeventhandler ["Keydown", "_this call FN_jump;"];