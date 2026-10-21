params ["_locationName","_progress","_required","_state"];
private _msg = switch (_state) do {
    case "capturing": {format ["Capturing %1\n%2 / %3 sec",_locationName,round _progress,round _required]};
    case "contested": {format ["%1 is contested",_locationName]};
    case "complete": {format ["%1 captured",_locationName]};
    case "cancelled": {format ["Capture of %1 cancelled",_locationName]};
    default {""};
};
if (_msg isNotEqualTo "") then {hintSilent _msg};
