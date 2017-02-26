// -------------------------------------------------------------------------------------------------

function InitLocaleGlobalTable ( ) {

	// 0 - English
	// 1 - Spanish
	// 2 - Russian
	// 3 - Dutch
	// 4 - Croatian
	
	local pLocaleTable = [ 
		
		// 0 - English
		dofile ( szScriptsPath + "Script Files/Server/Locale/English.nut" , true ) , 
		
		// 1 - Spanish
		dofile ( szScriptsPath + "Script Files/Server/Locale/Spanish.nut" , true ) , 
		
		// 2 - Russian
		dofile ( szScriptsPath + "Script Files/Server/Locale/Russian.nut" , true ) , 
		
		// 3 - Dutch
		dofile ( szScriptsPath + "Script Files/Server/Locale/Dutch.nut" , true ) , 

		// 4 - Croatian
		dofile ( szScriptsPath + "Script Files/Server/Locale/Croatian.nut" , true ) , 

	];
	
	return pLocaleTable;
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerLocaleMessage ( pPlayer , szMessageType ) {

	local pPlayerData = GetPlayerData ( pPlayer );

	return GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szMessageType ];
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerGroupedLocaleMessage ( pPlayer , szGroupName , szMessageType ) {

	local pPlayerData = GetPlayerData ( pPlayer );

	return GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szGroupName ] [ szMessageType ];
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerLocaleMultiMessage ( pPlayer , szGroupName ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	local pMessages = [ ];

	foreach ( ii , iv in GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szGroupName ] ) {
	
		pMessages.push ( iv );
	
	}
	
	return pMessages;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Locale]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------