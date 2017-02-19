szScriptsPath <- "Scripts/lu_roleplay/";

function LoadAllScriptFiles ( ) {

	dofile ( szScriptsPath + "Script Files/Server/Core.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Bit Flags.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Bugs.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Business.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Chat.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Clan.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Command.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Configuration.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Database.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Fire.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/House.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Jobs.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Locale.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Messaging.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Moderation.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Player.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Police.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Scripter.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Security.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Utilities.nut" , true );
	dofile ( szScriptsPath + "Script Files/Server/Vehicle.nut" , true );
	
}

function onScriptLoad ( ) {
	
	LoadAllScriptFiles ( );

}