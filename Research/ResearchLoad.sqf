createDialog "TyrResearchMenu";
waitUntil {sleep 0.01; !isNull findDisplay 1205};
TYR_researchSelectedKey = "";
[-1] execVM "Research\ResearchUpdate.sqf";
