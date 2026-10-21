class TYR
{
    tag = "TYR";
    class Core
    {
        file = "Functions";

        class CreateDefaultGameData {};
        class FindPlayerByOwner {};
        class FindVehicleCatalogEntry {};
        class SerializeGameState {};
        class GetLoadoutValue {};
        class GetUnitProfile {};
        class GetDividerLine {};
        class GetResearchDefinitions {};
        class IsResearchUnlocked {};
        class GetEmplacementDefinitions {};
        class IsVehicleCategoryUnlocked {};
        class ApplyPlayerLoadout {};
        class ClientHint {};
        class ClientEndMission {};
        class ClientShowTestReport {};
        class DebugMenuRefresh {};
        class ServerApplyDebugAction {};
        class ServerRunAutomatedTests {};

        class ServerBroadcastState {};
        class ServerLoadState {};
        class ServerSaveState {};
        class ServerResetGame {};
        class ServerBuildLocations {};
        class ServerStartSetup {};
        class StartSetupClient {};
        class ServerApplySettings {};
        class ServerApplyVehicleCatalog {};
        class ServerSetBasePosition {};
        class ServerMoveBase {};
        class ServerAttachAccountant {};
        class ServerRegisterPlayer {};
        class ServerSavePlayer {};
        class ServerBeginArsenal {};
        class ServerPurchaseLoadout {};
        class ServerCaptureRegion {};
        class ServerCollectFactory {};
        class ServerBuyVehicle {};
        class ServerVehicleKilled {};
        class ServerRestoreVehicles {};
        class ServerRestoreDestroyedObjects {};
        class ServerInitBase {};
        class ServerEnsureSoloOpponent {};
        class ServerPurchaseResearch {};
        class ServerBuyEmplacement {};
        class ServerAddVLSTarget {};
        class ServerRemoveVLSTarget {};
        class ServerLaunchVLS {};
        class ServerRestoreEmplacements {};
        class ServerEmplacementKilled {};
        class ServerDebugAction {};
        class ClientAttachEmplacementActions {};
        class CruiseMissileLaunch {};

        class ExitArsenal {};
        class VehicleCreate {};
        class destroyedVehicle {};
        class GameReset {};
        class getPlayerLoadout {};
        class givePlayerLoadout {};
        class FactoryUpdate {};
        class VehicleUpdate {};
        class GetFactoryResource {};
        class VehicleBuy {};
        class VehicleBuyMenu {};
    };
};