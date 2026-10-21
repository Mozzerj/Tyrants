[
    ["intel.basic","Basic Intelligence","intelligence",30000,[]],
    ["intel.comms","Communications Intercept","intelligence",50000,["intel.basic"]],
    ["intel.listening","Listening Devices","intelligence",75000,["intel.comms"]],
    ["intel.trackers","Vehicle Trackers","intelligence",40000,["intel.basic"]],
    ["intel.satellite","Satellite Surveillance","intelligence",150000,["intel.listening","intel.trackers"]],
    ["infra.basic","Basic Infrastructure","infrastructure",30000,[]],
    ["infra.strategic","Strategic Emplacements","infrastructure",35000,["infra.basic"]],
    ["infra.cbr","Counter Battery Radar","infrastructure",40000,["infra.strategic"]],
    ["infra.roadblock","Roadblocks","infrastructure",35000,["infra.strategic"]],
    ["infra.factory","Factory Production","infrastructure",30000,["infra.basic"]],
    ["infra.offensive","Offensive Emplacements","infrastructure",250000,["infra.cbr","infra.roadblock","infra.factory"]],
    ["proc.armored","Armoured Vehicles","procurement",30000,[]],
    ["proc.heavy","Heavy Armour","procurement",35000,["proc.armored"]],
    ["proc.rotary","Rotary Wing","procurement",45000,["proc.heavy"]],
    ["proc.artillery","Artillery","procurement",60000,["proc.rotary"]],
    ["proc.fixed","Fixed Wing","procurement",100000,["proc.artillery"]],
    ["proc.autonomous","Autonomous Systems","procurement",100000,["proc.fixed"]]
]
