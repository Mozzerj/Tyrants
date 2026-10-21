/*
    [key, title, branchIndex, nodeIndex, steelCost, prerequisites, description[]]
    Branches: 0 intelligence, 1 infrastructure, 2 procurement.
*/
[
    ["intel.basic", "Basic Intelligence", 0, 0, 30000, [], ["Opens the intelligence research branch."]],
    ["intel.comms", "Communications Intercept", 0, 1, 50000, ["intel.basic"], ["Enables future interception of enemy communications."]],
    ["intel.listening", "Listening Devices", 0, 2, 75000, ["intel.comms"], ["Enables future warning of planned enemy attacks."]],
    ["intel.trackers", "Vehicle Trackers", 0, 3, 40000, ["intel.basic"], ["Enables future tracking devices for enemy vehicles."]],
    ["intel.satellite", "Satellite Surveillance", 0, 4, 150000, ["intel.listening", "intel.trackers"], ["Enables future satellite surveillance capabilities."]],

    ["infra.basic", "Basic Infrastructure", 1, 0, 30000, [], ["Opens the infrastructure research branch."]],
    ["infra.strategic", "Strategic Emplacements", 1, 1, 35000, ["infra.basic"], ["Unlocks the strategic emplacement branch."]],
    ["infra.cbr", "Counter Battery Radars", 1, 2, 40000, ["infra.strategic"], ["Researches counter-battery radar systems."]],
    ["infra.roadblock", "Roadblocks", 1, 3, 35000, ["infra.strategic"], ["Researches hardened roadblocks and defensive obstacles."]],
    ["infra.factory", "Factory Production", 1, 4, 30000, ["infra.basic"], ["Researches future factory production upgrades."]],
    ["infra.offensive", "Offensive Emplacements", 1, 5, 250000, ["infra.cbr", "infra.roadblock", "infra.factory"], ["Unlocks heavy static offensive emplacements, including VLS."]],

    ["proc.armored", "Armoured Procurement", 2, 0, 30000, [], ["Unlocks armoured personnel carriers and similar vehicles."]],
    ["proc.heavy", "Heavy Armour", 2, 1, 35000, ["proc.armored"], ["Unlocks tanks and heavy armour."]],
    ["proc.rotary", "Rotary Wing", 2, 2, 45000, ["proc.heavy"], ["Unlocks helicopters."]],
    ["proc.artillery", "Artillery", 2, 3, 60000, ["proc.rotary"], ["Unlocks artillery-capable vehicles and weapons."]],
    ["proc.fixed", "Fixed Wing", 2, 4, 100000, ["proc.artillery"], ["Unlocks fixed-wing aircraft."]],
    ["proc.autonomous", "Autonomous Capabilities", 2, 5, 100000, ["proc.fixed"], ["Unlocks autonomous ground and air vehicles."]]
]
