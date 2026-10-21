params ["_factionId", ["_rgba", false]];
private _pair = switch (toLower _factionId) do {
    case "west": {["ColorWEST", [0.05,0.35,0.85,1]]};
    case "east": {["ColorEAST", [0.75,0.08,0.08,1]]};
    case "independent": {["ColorGUER", [0.08,0.60,0.22,1]]};
    default {["ColorUNKNOWN", [0.55,0.55,0.55,1]]};
};
if (_rgba) then {_pair # 1} else {_pair # 0}
