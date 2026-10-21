class TYR
{
    tag = "TYR";

    class Core
    {
        file = "Core";
        class RecordGet {};
        class FactionIds {};
        class FactionSide {};
        class SideFaction {};
        class FactionColor {};
        class FindPlayerByOwner {};
        class ServerSendToPlayer {};
        class ServerBootstrap {};
        class ServerScheduler {};
    };

    class State
    {
        file = "State";
        class StateCreateCampaign {};
        class StateGetFaction {};
        class StateGetLocation {};
        class StateNextId {};
        class StateMarkDirty {};
        class StateChangeResource {};
        class StateResearchUnlocked {};
        class StateKnowledgeGet {};
        class StateObserveLocation {};
        class StateObserveContact {};
        class StatePublicKnowledge {};
        class StatePublicFaction {};
        class StatePublicCampaign {};
        class StatePublicLocation {};
    };

    class Persistence
    {
        file = "Persistence";
        class PersistenceBuildSnapshot {};
        class PersistenceValidateRecord {};
        class PersistenceApplySnapshot {};
        class PersistenceLoad {};
        class PersistenceSave {};
        class PersistenceQueue {};
        class PersistenceManager {};
        class PersistenceReset {};
    };

    class Network
    {
        file = "Network";
        class ServerRequestState {};
        class ServerPublishFaction {};
        class ServerPublishDeployment {};
        class ServerPublishLocation {};
        class ServerPublishKnowledge {};
        class ClientReceiveSnapshot {};
        class ClientReceiveDeployment {};
        class ClientReceiveFaction {};
        class ClientReceiveLocation {};
        class ClientReceiveKnowledge {};
        class ClientHint {};
        class ClientCaptureStatus {};
        class ClientEndMission {};
        class ClientVLSState {};
    };

    class World
    {
        file = "World";
        class ServerBuildLocations {};
        class DeploymentCheckPosition {};
        class DeploymentFindCollisions {};
        class IsValidLandPosition {};
        class FindSafeSpawnPosition {};
        class ObservationCanSee {};
        class ServerReportVisualContact {};
        class ServerSetCombatState {};
        class ServerGenerateDeployment {};
        class ServerAutoSelectBase {};
        class ServerConfirmBase {};
        class ServerFinalizeDeployment {};
        class ServerCreateBases {};
        class ServerRegisterDestroyedBuilding {};
        class ServerRestoreDestroyedBuildings {};
        class ServerObservationTick {};
        class ServerVictoryEvaluate {};
    };

    class Players
    {
        file = "Players";
        class ClientInit {};
        class ClientRestorePlayer {};
        class ClientApplyLoadout {};
        class ClientAttachBaseActions {};
        class ClientOpenArsenal {};
        class LoadoutCost {};
        class ServerRegisterPlayer {};
        class ServerSavePlayer {};
        class ServerBeginArsenal {};
        class ServerPurchaseLoadout {};
    };

    class Economy
    {
        file = "Economy";
        class ServerEconomyTick {};
        class ServerCollectFactory {};
    };

    class Territory
    {
        file = "Territory";
        class ServerBeginCapture {};
        class ServerTerritoryTick {};
    };

    class Research
    {
        file = "Research";
        class GetResearchDefinitions {};
        class ResearchPurchase {};
        class ServerPurchaseResearch {};
    };

    class Vehicles
    {
        file = "Vehicles";
        class VehicleCategory {};
        class VehicleCost {};
        class VehiclePurchase {};
        class ServerPurchaseVehicle {};
        class ServerVehicleKilled {};
        class ServerRestoreVehicles {};
    };

    class Emplacements
    {
        file = "Emplacements";
        class GetEmplacementDefinitions {};
        class ServerPurchaseEmplacement {};
        class ServerRestoreEmplacements {};
        class VLSAccess {};
        class ServerGetVLSState {};
        class ServerAddVLSTarget {};
        class ServerRemoveVLSTarget {};
        class ServerLaunchVLS {};
        class CruiseMissileLaunch {};
    };

    class AI
    {
        file = "AI";
        class AIBuildPicture {};
        class AIAssessPosture {};
        class AIReassessOperations {};
        class AIGenerateCandidates {};
        class AIScoreCandidates {};
        class AIValidateCandidate {};
        class AIExecuteCandidate {};
        class AIForceCreate {};
        class AIForceRestore {};
        class AIEnsureForces {};
        class AICommanderThink {};
        class AIOperationsTick {};
        class ServerRequestForce {};
    };

    class Command
    {
        file = "Command";
        class CommandNetworkGet {};
        class CommandOrderDelay {};
        class ServerCommandCreate {};
        class ServerCommandSpawnPerson {};
        class ServerCommandPersonKilled {};
        class ServerCommandRestore {};
        class ServerCommandAssignForce {};
        class ServerCommandQueueOrder {};
        class ServerCommandDeliverOrders {};
        class ServerCommandTick {};
    };

    class UI
    {
        file = "UI";
        class PlayerMenuRefresh {};
        class GetFactoryResource {};
        class VehicleBuyMenu {};
        class VehicleBuy {};
        class OpenResearchMenu {};
        class ResearchMenuUpdate {};
        class OpenEmplacementMenu {};
        class DeployEmplacement {};
        class ClientAttachEmplacementActions {};
        class OpenVLSMenu {};
        class VLSMenuRefresh {};
        class VLSAddTargetMode {};
        class VLSRemoveTargetAction {};
        class VLSFocusTarget {};
        class VLSLaunchControl {};
        class VLSMenuCleanup {};
        class ClientMapInit {};
        class ClientMapDraw {};
        class DrawDeploymentSectors {};
        class DeploymentOverlayBuild {};
        class DeploymentOverlayCleanup {};
        class DeploymentMapDraw {};
        class DeploymentMenuInit {};
        class DeploymentMapClick {};
        class DeploymentConfirm {};
        class DeploymentMenuRefresh {};
        class CommanderMenuRefresh {};
        class DebugMenuRefresh {};
        class DebugTeleport {};
        class DebugCamera {};
        class DebugMapTeleport {};
        class DebugRunCommand {};
        class ClientObservationTick {};
    };

    class Debug
    {
        file = "Debug";
        class ServerDebugAction {};
        class ClientDebugState {};
        class ClientDebugTeleport {};
        class ClientDebugMapData {};
        class ClientDebugAITraceData {};
        class ClientDebugMapDraw {};
        class ClientDebugCommandResult {};
    };

    class Tests
    {
        file = "Tests";
        class ServerRunAutomatedTests {};
        class ClientShowTestReport {};
    };
};
