while {true} do {
    
    {
        
        _pop = (count (nearestObjects [(_x select 4), ["House"], 250])*3);

        _ctrlB = (findDisplay 12) displayCtrl ((_x # 6) + 2000);
        _ctrlH = (findDisplay 12) displayCtrl ((_x # 6) + 2001);

        switch ((_x # (Pside + 1))) do {
            case "ColorGUER": { _ctrlH ctrlSetBackgroundColor [0.00, 0.50, 0.00, 1.00]};
            case "ColorWEST": { _ctrlH ctrlSetBackgroundColor [0.00, 0.30, 0.60, 1.00]};
            case "ColorEAST": { _ctrlH ctrlSetBackgroundColor [0.50, 0.00, 0.00, 1.00]};
        };

        lbClear _ctrlB;
        _ctrlB lbAdd "";
        _ctrlB lbAdd format["Pop: %1",_pop];

        sleep 0.1;

    }forEach GameData # 1 # 0;
     {

        _pop = (count (nearestObjects [(_x select 4), ["House"], 250])*3);

        _ctrlB = (findDisplay 12) displayCtrl ((_x # 6) + 2000);
        _ctrlH = (findDisplay 12) displayCtrl ((_x # 6) + 2001);

        switch ((_x # (Pside + 1))) do {
            case "ColorGUER": { _ctrlH ctrlSetBackgroundColor [0.00, 0.50, 0.00, 1.00]};
            case "ColorWEST": { _ctrlH ctrlSetBackgroundColor [0.00, 0.30, 0.60, 1.00]};
            case "ColorEAST": { _ctrlH ctrlSetBackgroundColor [0.50, 0.00, 0.00, 1.00]};
        };

        lbClear _ctrlB;
        _ctrlB lbAdd "";
        _ctrlB lbAdd format["Pop: %1",_pop];
        
        sleep 0.1;

    }forEach GameData # 1 # 1;
    {
        
        _ctrlB = (findDisplay 12) displayCtrl ((_x # 8) + 2000);
        _ctrlH = (findDisplay 12) displayCtrl ((_x # 8) + 2001);

        switch ((_x # (Pside + 1))) do {
            case "ColorGUER": { _ctrlH ctrlSetBackgroundColor [0.00, 0.50, 0.00, 1.00]};
            case "ColorWEST": { _ctrlH ctrlSetBackgroundColor [0.00, 0.30, 0.60, 1.00]};
            case "ColorEAST": { _ctrlH ctrlSetBackgroundColor [0.50, 0.00, 0.00, 1.00]};
        };

        lbClear _ctrlB;

        _ctrlB lbAdd "";
        
        _ctrlB lbAdd format["Type: %1",(_x select 7)];

        if (Pcolor == _x # 3) then {

            _ctrlB lbAdd format["Stock: %1",(_x select 6)];

        };
        
        sleep 0.1;

    }forEach GameData # 1 # 2;

    // base ctrls
    _ctrlB = (findDisplay 12) displayCtrl (3002);
    _ctrlH = (findDisplay 12) displayCtrl (3003);

    lbClear _ctrlB;
    _ctrlB lbAdd "";
        
    _ctrlB lbAdd format["Steel: %1",(gameData # 0 # (pside + 1) # 1)];
    _ctrlB lbAdd format["Ammo: %1",(gameData # 0 # (pside + 1) # 2)];
    _ctrlB lbAdd format["Fuel: %1",(gameData # 0 # (pside + 1) # 3)];

    sleep 5;
};