params ["_factionId"];
switch (toLower _factionId) do {
    case "west": {west};
    case "east": {east};
    case "independent": {resistance};
    default {sideUnknown};
}
