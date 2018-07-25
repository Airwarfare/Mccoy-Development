/*
	Author: Maverick Applications
	Desc: Altis Life Shipwreck
*/

//Customize your settings to fit your server setup!
class Maverick_Shipwrecks {

    //How often (in seconds) should a shipwreck spawn, if no wreck is on the map?
    ShipwreckInterval = 60; //1800 = 30min

    //Define the possible locations for your shipwrecks.
    //getPosATL format -> Get the position via: diag_log(getPosATL player) -> replace the [] with {}
	Positions[] = {
        {23606,18198.6,0}
	};

    //Define the radius, in which the wreck randomly spawns around the given center position
    Radius = 250;

    //Define the possible sets of virtual items the user can loot from the wreck.
	ShipLoot[] = {
        {"tbacon","tbacon","tbacon","apple","apple"},
        {"tbacon","tbacon","tbacon","tbacon","tbacon","tbacon","tbacon","tbacon","tbacon"},
        {"goldbar"}
	};

	//What shall be displayed as text to gather the items from the ship? (The text of the addAction ingame)
	ShipLootText = "Retrieve the loot";

    //The message when the user has got all the loot successfully.
    ShipLootSuccess = "You successfully claimed the wreck's loot for you!";

    //The message in case something fails, or the user can not carry all the items.
    ShipLootFail = "You can not carry all the loot. Make some room first!";

	//Define the message, that should appear when a shipwreck spawns (broadcasted to all clients).
	SpawnMSG = "SHIPWRECK\n\nA sunken ship has been located! It may contain important items and it has been marked on your map!";

    //Define the message, that should appear when a shipwreck disappears after a user looted it (broadcasted to all clients).
	DeleteMSG = "SHIPWRECK\n\nThe ship has been successfully looted and has despawned!";
};