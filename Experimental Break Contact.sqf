/* Break Contact
If AI elements are being beaten, they will return to their parent base.

Patrol leader gets total count of patrol.
If over twenty five percent of the patrol has been injured,
then the patrol leader considers breaking contact.

By the time fifty percent of the patrol is wounded,
the chance of breaking contact is 100%.
*/

aliveCurr >= aliveBegin = 20%; aliveCurr <= aliveEnd = 100%; aliveBegin > aliveEnd; and chance changed between begin and end from 20% to 100% linearly;

(random 1.0) >= (linearConversion [_aliveBegin, _aliveEnd, _aliveCurr, 0.8, 0.0]);

linearConversion [_aliveBegin, _aliveEnd, _aliveCurr, 0.8, 0.0] -> _aliveCurr * 0.8 / _aliveEnd;

((0.8 - 0.2)/(begin-end))*(curr - end);

