params ["_report"];
missionNamespace setVariable ["TYR_lastTestReportText",_report];
copyToClipboard _report;
hint "Tyrants v4 automated test report copied to clipboard.";
