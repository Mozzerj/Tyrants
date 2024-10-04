WestAccGrp = createGroup West;
basePos = (GameData # 0 # 1 # 0);
WestAccountant = WestAccGrp createUnit ["C_man_polo_4_F", (basePos), [], 0, "NONE"];
WestBox = createVehicle ["virtualReammoBox_camonet_F", (basePos vectorAdd [1,0,0]), [], 0, "NONE"];

WestAccountant disableAI "MOVE";

AccountantMove = {
    WestMoveAccID = WestAccountant addAction ["Move Accountant", {
        WestAccountant removeAction WestMoveAccID;
        WestAccountant attachTo [player, [0, 3, 0]];

        WestDropAccID = player addAction ['Drop Accountant', {
            GameData # 0 # (Pside + 1) set [0, getPos WestAccountant];
            publicVariable "GameData";
            detach WestAccountant;
            WestAccountant setPos (player modelToWorld [0, 3, 0]);
            player removeAction WestDropAccID;
            call AccountantMove;
        },
        nil,
        1.5,
        true,
        true,
        "",
        "true",
        10
    ];
    }];
};

publicVariable "WestBox";

call AccountantMove;
