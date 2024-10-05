EastAccGrp = createGroup East;
basePos = (GameData # 0 # 2 # 0);
EastAccountant = EastAccGrp createUnit ["C_man_polo_4_F", (basePos), [], 0, "NONE"];
EastBox = createVehicle ["virtualReammoBox_camonet_F", (basePos vectorAdd [1,0,0]), [], 0, "NONE"];

EastAccountant disableAI "MOVE";

AccountantMove = {
    EastMoveAccID = EastAccountant addAction ["Move Accountant", {
        EastAccountant removeAction EastMoveAccID;
        EastAccountant attachTo [player, [0, 3, 0]];

        EastDropAccID = player addAction ['Drop Accountant', {
            GameData # 0 # (Pside + 1) set [0, getPos EastAccountant];
            publicVariable "GameData";
            detach EastAccountant;
            EastAccountant setPos (player modelToWorld [0, 3, 0]);
            player removeAction EastDropAccID;
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

publicVariable "EastBox";

call AccountantMove;
