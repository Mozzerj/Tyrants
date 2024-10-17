createDialog "TYREmplacementMenu";

_Display = findDisplay 1003;

_map = _display displayCtrl 1000;
_EmplacementsLB = _display displayCtrl 1;

_research = gameData # 0 # (Pside + 1) # 5 # 1;

if (_research # 3 == 1) then {

    _EmplacementsLB lbAdd "Counter Battery Radar";

};
if (_research # 4 == 1) then {

    _EmplacementsLB lbAdd "Roadblock";


};
if (_research # 5 == 1) then {

    _EmplacementsLB lbAdd "VLS System";


};