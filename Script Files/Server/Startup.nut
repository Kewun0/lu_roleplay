// -- This is delayed a bit, to make sure the script is fully loaded before running any database stuff.
// -- It's also helpful for running anything else that requires the script to be fully loaded first.

// -------------------------------------------------------------------------------------------------

function InitServerStartup ( ) {
	
	InitServerModules ( );
	
	return true;
	
}



function InitServerScriptCore ( ) {

	InitAllGlobalTables ( );
	InitAllClasses ( );
	
	return true;

}

// -------------------------------------------------------------------------------------------------


	
// -------------------------------------------------------------------------------------------------

/* 
function LoadAllScriptFiles ( ) {

	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Core.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Bit Flags.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Bugs.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Business.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Chat.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Clan.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Command.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Configuration.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Database.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Fire.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/House.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Jobs.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Locale.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Messaging.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Moderation.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Player.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Police.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Scripter.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Security.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Utilities.nut" , true );
	dofile ( GetCoreTable ( ).Utilities.szScriptsPath + "Script Files/Server/Vehicle.nut" , true );
	
	return true;
	
}
*/

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Startup]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------