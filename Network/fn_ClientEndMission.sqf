params ["_winnerId"];
private _name = toUpper _winnerId;
if (!isNil "TYR_ClientState") then {
    private _f = (TYR_ClientState get "factions") getOrDefault [_winnerId,[]];
    if (count _f > 1) then {_name = _f # 1};
};
titleText [format ["%1 HAS WON THE CAMPAIGN",_name],"BLACK FADED",2];
sleep 4;
endMission "END1";
