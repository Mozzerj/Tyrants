{
    _teamVehs = _x;
    _TeamSide = _forEachIndex;

    {
        _vehicle = _x # 0;
        _veh = _x # 1;
        _Pcolor = _x # 2;
        _mark = _x # 8;

        gameData # 4 # _TeamSide set [_forEachIndex, [
            _vehicle, 
            _veh, 
            _Pcolor, 
            getAllHitPointsDamage _veh, 
            magazinesAllTurrets _veh, 
            fuel _veh, 
            getDir _veh, 
            getPos _veh,
            _mark
        ]];
    } forEach _teamVehs;

} forEach gameData # 4;