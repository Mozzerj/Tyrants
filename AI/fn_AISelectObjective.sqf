params ["_factionId"];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
private _locations = TYR_State get "locations";

// Own current control is legitimate knowledge. Non-friendly ownership comes only
// from collected faction knowledge; unknown sites remain valid scout/expansion objectives.
private _owned = [];
{
    private _l = _locations get _x;
    if ((_l getOrDefault ["owner","neutral"]) isEqualTo _factionId) then {_owned pushBack (_l get "position")};
} forEach keys _locations;
private _base = _f getOrDefault ["basePosition",[worldSize*0.5,worldSize*0.5,0]];
if (count _owned isEqualTo 0) then {_owned pushBack _base};

private _best = "";
private _scoreBest = -1e9;
private _scoreRows = [];
{
    private _l = _locations get _x;
    private _trueOwner = _l getOrDefault ["owner","neutral"];
    if (_trueOwner isNotEqualTo _factionId) then {
        private _intel = [_factionId,"locations",_x] call TYR_fnc_StateKnowledgeGet;
        private _knownOwner = _intel getOrDefault ["owner","unknown"];
        private _pos = _l get "position";
        private _nearestOwn = 1e12;
        {_nearestOwn = _nearestOwn min (_x distance2D _pos)} forEach _owned;
        private _frontBonus = if (_nearestOwn < 3500) then {35} else {0};
        private _knowledgeBonus = switch (_knownOwner) do {
            case "unknown": {12};
            case "neutral": {18};
            default {25};
        };
        private _value = _l getOrDefault ["value",1];
        private _score = (_value * 24) + _frontBonus + _knowledgeBonus - (_nearestOwn / 450) + random 10;
        _scoreRows pushBack [_score,_x,_knownOwner];
        if (_score > _scoreBest) then {_scoreBest = _score;_best = _x};
    };
} forEach keys _locations;

// Debug-only decision telemetry. The AI still acts solely on its faction knowledge;
// this record merely exposes the explicit scores already used by the game AI.
_scoreRows sort false;
private _debugScores = [];
{
    if (_forEachIndex < 5) then {
        _x params ["_score","_id","_knownOwner"];
        private _l = _locations getOrDefault [_id,createHashMap];
        _debugScores pushBack [_l getOrDefault ["name",_id],_knownOwner,_score];
    };
} forEach _scoreRows;
private _allScores = TYR_Runtime getOrDefault ["aiObjectiveScores",createHashMap];
_allScores set [_factionId,_debugScores];
TYR_Runtime set ["aiObjectiveScores",_allScores];

_best
