// -------------------------------------------------------------------------------------------------

function GetCoreTable ( ) {

	return ::pCoreTable;

}

// -------------------------------------------------------------------------------------------------

function InitCoreTable ( ) {
	
	local pTempCoreTable									   =  { };
	
	pTempCoreTable.Players									<- { };
	pTempCoreTable.Vehicles									<- { }; // ::LoadVehiclesFromDatabase ( );
	pTempCoreTable.Houses									<- { };
	pTempCoreTable.Businesses								<- { };
	pTempCoreTable.Fires									<- { };
	pTempCoreTable.Commands									<- { };
	pTempCoreTable.Pickups									<- array ( MAX_PICKUPS , { iPickupDataType = 0 , iPickupDataID = -1 } );
	pTempCoreTable.Locations								<- ::InitLocationsCoreTable ( );
	pTempCoreTable.Colours									<- ::InitColoursCoreTable ( );
	pTempCoreTable.Utilities								<- ::InitUtilitiesCoreTable ( );
	pTempCoreTable.Database									<- ::InitDatabaseCoreTable ( );
	pTempCoreTable.Weapons									<- ::InitWeaponDataCoreTable ( );
	pTempCoreTable.BitFlags									<- ::InitBitFlagCoreTable ( );
	pTempCoreTable.Security									<- ::InitSecurityCoreTable ( );
	pTempCoreTable.Classes									<- ::InitClassesCoreTable ( );
	pTempCoreTable.Locale 									<- ::InitLocaleGlobalTable ( );
	pTempCoreTable.Clans									<- { };
	pTempCoreTable.Threads									<- ::InitServerProcessingThreads ( );
	pTempCoreTable.Jobs										<- ::InitJobsCoreTable ( );
	
	pTempCoreTable.VehicleToData							<- array ( MAX_VEHICLES , false );
	
	print ( "[Server.Core]: Core table created" );
	
	return pTempCoreTable;
	
}

// -------------------------------------------------------------------------------------------------
	
function InitColoursCoreTable ( ) {
	
	local pAllColoursTable 						= { };
	local pHexColoursTable 						= { };
	local pRGBColoursTable 						= { };
	local pByTypeColoursTable 					= { };

	pHexColoursTable.White						<- "[#FFFFFF]";
	pHexColoursTable.Black						<- "[#000000]";
	pHexColoursTable.LightGrey					<- "[#CCCCCC]";
	pHexColoursTable.MediumGrey					<- "[#999999]";
	pHexColoursTable.DarkGrey					<- "[#666666]";
	pHexColoursTable.BrightRed					<- "[#FF0000]";
	pHexColoursTable.MediumRed					<- "[#660000]";
	pHexColoursTable.Maroon						<- "[#330000]";
	pHexColoursTable.Yellow						<- "[#FFFF00]";
	pHexColoursTable.Orange						<- "[#FF6600]";
	pHexColoursTable.Lime						<- "[#00FF00]";
	pHexColoursTable.Green						<- "[#006600]";
	pHexColoursTable.RoyalBlue					<- "[#0000FF]";
	pHexColoursTable.LightBlue					<- "[#00FFFF]";
	pHexColoursTable.LightPurple				<- "[#A000A0]";	
	pHexColoursTable.MediumPurple				<- "[#660066]";
	pHexColoursTable.DarkPurple					<- "[#400040]";
	pHexColoursTable.Pink						<- "[#FF00FF]";
	
	pRGBColoursTable.White						<- Colour ( 255 , 255 , 255 );
	pRGBColoursTable.Black						<- Colour ( 000 , 000 , 000 );
	pRGBColoursTable.LightGrey					<- Colour ( 204 , 204 , 204 );
	pRGBColoursTable.MediumGrey					<- Colour ( 153 , 153 , 153 );
	pRGBColoursTable.DarkGrey					<- Colour ( 102 , 102 , 102 );
	pRGBColoursTable.BrightRed					<- Colour ( 255 , 000 , 000 );
	pRGBColoursTable.MediumRed					<- Colour ( 102 , 000 , 000 );
	pRGBColoursTable.Maroon						<- Colour ( 051 , 000 , 000 );
	pRGBColoursTable.Yellow						<- Colour ( 255 , 255 , 000 );
	pRGBColoursTable.Orange						<- Colour ( 255 , 255 , 255 );
	pRGBColoursTable.Lime						<- Colour ( 000 , 255 , 000 );
	pRGBColoursTable.Green						<- Colour ( 000 , 102 , 000 );
	pRGBColoursTable.RoyalBlue					<- Colour ( 000 , 000 , 255 );
	pRGBColoursTable.LightBlue					<- Colour ( 000 , 255 , 255 );
	pRGBColoursTable.LightPurple				<- Colour ( 200 , 000 , 200 );
	pRGBColoursTable.MediumPurple				<- Colour ( 102 , 000 , 102 );
	pRGBColoursTable.DarkPurple					<- Colour ( 064 , 000 , 064 );
	pRGBColoursTable.Pink						<- Colour ( 255 , 000 , 255 );	
	
	pByTypeColoursTable.UnknownCommandMessage	<- pHexColoursTable.White;
	pByTypeColoursTable.UnknownCommandHeader	<- pHexColoursTable.BrightRed;
	pByTypeColoursTable.GeneralAlertMessage		<- pHexColoursTable.White;
	pByTypeColoursTable.GeneralAlertHeader		<- pHexColoursTable.Yellow;
	pByTypeColoursTable.GeneralSuccessMessage	<- pHexColoursTable.White;
	pByTypeColoursTable.GeneralSuccessHeader	<- pHexColoursTable.Lime;
	pByTypeColoursTable.GeneralErrorMessage		<- pHexColoursTable.White;
	pByTypeColoursTable.GeneralErrorHeader		<- pHexColoursTable.BrightRed;
	pByTypeColoursTable.SyntaxErrorMessage		<- pHexColoursTable.White;
	pByTypeColoursTable.SyntaxErrorHeader		<- pHexColoursTable.LightGrey;
	pByTypeColoursTable.ChatMessage				<- pHexColoursTable.LightGrey;
	pByTypeColoursTable.ChatPlayerName			<- pHexColoursTable.White;
	pByTypeColoursTable.ChatPlayerHeader		<- pHexColoursTable.Orange;
	pByTypeColoursTable.AreaTalkHeader			<- pHexColoursTable.LightBlue;
	pByTypeColoursTable.AreaTalkName			<- pHexColoursTable.White;
	pByTypeColoursTable.AreaTalkMessage			<- pHexColoursTable.LightGrey;
	pByTypeColoursTable.AreaShoutHeader			<- pHexColoursTable.LightBlue;
	pByTypeColoursTable.AreaShoutName			<- pHexColoursTable.White;
	pByTypeColoursTable.AreaShoutMessage		<- pHexColoursTable.LightGrey;
	pByTypeColoursTable.AdminAnnounceHeader		<- pHexColoursTable.Orange;
	pByTypeColoursTable.AdminAnnounceMessage	<- pHexColoursTable.White;
	pByTypeColoursTable.InfoMessageMessage		<- pHexColoursTable.White;
	pByTypeColoursTable.InfoMessageHeader		<- pHexColoursTable.LightPurple;
	pByTypeColoursTable.InfoMessageMessage		<- pHexColoursTable.White;
	pByTypeColoursTable.CommandHeader			<- pHexColoursTable.LightPurple;  
	pByTypeColoursTable.CommandInfoHeader		<- pHexColoursTable.LightPurple; 	
	pByTypeColoursTable.CommandInfoMessage		<- pHexColoursTable.LightGrey;
	
	pAllColoursTable.Hex 						<- pHexColoursTable;
	pAllColoursTable.RGB 						<- pRGBColoursTable;
	pAllColoursTable.ByType 					<- pByTypeColoursTable;
	
	::print ( "[Server.Core]: Core colour tables created" );
	
	return pAllColoursTable;
	
}

// -------------------------------------------------------------------------------------------------

function InitDatabaseCoreTable ( ) {

	local pDatabaseConfigurationTable = { };
	
	pDatabaseConfigurationTable.szHost				<- "";
	pDatabaseConfigurationTable.szUser				<- "";
	pDatabaseConfigurationTable.szPass				<- "";
	pDatabaseConfigurationTable.szName				<- "";
	pDatabaseConfigurationTable.iPort				<- 3306;

	::print ( "[Server.Core]: Core database configuration tables created" );
	
	return pDatabaseConfigurationTable;
	
}

// -------------------------------------------------------------------------------------------------

function InitEntityToDataCoreTables ( ) {
	
	local pVehicleToData = array ( MAX_VEHICLES , -1 );

	return pVehicleToData;
	
}

// -------------------------------------------------------------------------------------------------

function InitUtilitiesCoreTable ( ) {

	local pUtilitiesValuesTable = { };

	pUtilitiesValuesTable.iScriptVersion				<- 1;
	pUtilitiesValuesTable.iStartTimeStamp				<- 0;
	pUtilitiesValuesTable.pZeroVector					<- Vector ( 0.0 , 0.0 , 0.0 );
	pUtilitiesValuesTable.szPartReasons					<- [ "Disconnected" , "Crashed" , "Timed Out" , "Kicked" , "Banned" ];
	pUtilitiesValuesTable.iNoWeapon						<- [ WEP_VEHICLE , WEP_DROWNED , WEP_FALL , WEP_EXPLOSION ];
	pUtilitiesValuesTable.szCardinalDirections			<- [ "North" , "Northeast" , "East" , "Southeast" , "South" , "Southwest" , "West" , "Northwest" , "Unknown" ];
	pUtilitiesValuesTable.pAllowedVehicles				<- [ 90 , 91 , 92 , 93 , 94 , 95 , 96 , 99 , 100 , 101 , 102 , 103 , 104 , 105 , 108 , 109 , 111 , 112 , 113 , 114 , 119 , 121 , 127 , 129 , 130 , 132 , 133 , 134 , 135 , 136 , 137 , 138 , 139 , 144 , 145 , 146 , 149 ];
	pUtilitiesValuesTable.pVehicleOwnerType				<- { None = 0 , Player = 1 , Clan = 2 , Job = 3 };
	pUtilitiesValuesTable.pPickupDataType				<- { None = 0 , HiddenPackage = 1 , Business = 2 , House = 3 , Job = 4 };
	pUtilitiesValuesTable.iMaxHiddenPackages			<- 50;
	pUtilitiesValuesTable.fAreaShoutRange				<- 20.0;
	pUtilitiesValuesTable.fAreaTalkRange				<- 10.0;
	pUtilitiesValuesTable.fArrestRange					<- 5.0;
	pUtilitiesValuesTable.fHospitalHealRange			<- 10.0;
	pUtilitiesValuesTable.fVehicleLockRange				<- 5.0;
	pUtilitiesValuesTable.fVehicleTrunkRange			<- 5.0;
	pUtilitiesValuesTable.fCuffRange					<- 3.0;
	pUtilitiesValuesTable.pJobs							<- { None = 0 , Police = 1 , Fire = 2 , Medical = 3 , Trash = 4 , Delivery = 5 };
	pUtilitiesValuesTable.WeekDays						<- [ "Sunday" , "Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday" ];
	pUtilitiesValuesTable.Months						<- [ "January" , "February" , "March" , "April" , "May" , "June" , "July" , "August" , "September" , "October" , "November" , "December" ];
	
	pUtilitiesValuesTable.szScriptsPath					<- "Scripts/lu_roleplay/";

	::print ( "[Server.Core]: Core utility values table created" );
	
	return pUtilitiesValuesTable;
	
}

// -------------------------------------------------------------------------------------------------

function InitWeaponDataCoreTable ( ) {

	local pWeaponDataTable = { };

	pWeaponDataTable [ WEP_FIST ]					<- { iWeaponID = 0		, szName = "Unarmed"		   	, iDamage = 20		, szKillerMessage = "%s killed %s with fists of steel."  								};
	pWeaponDataTable [ WEP_BAT ]					<- { iWeaponID = 1		, szName = "Baseball Bat"	  	, iDamage = 30		, szKillerMessage = "%s beat the shit out of %s with a Baseball Bat."  					};
	pWeaponDataTable [ WEP_COLT45 ]					<- { iWeaponID = 2		, szName = "Colt .45"		  	, iDamage = 10		, szKillerMessage = "%s killed %s in cold blood with a Colt .45"  						};
	pWeaponDataTable [ WEP_UZI ]					<- { iWeaponID = 3		, szName = "UZI"			   	, iDamage = 10		, szKillerMessage = "%s hosed %s down with an UZI"  									};
	pWeaponDataTable [ WEP_SHOTGUN ]				<- { iWeaponID = 4		, szName = "Shotgun"			, iDamage = 100		, szKillerMessage = "%s knocked %s on their ass with a Shotgun"  						};
	pWeaponDataTable [ WEP_AK47 ]					<- { iWeaponID = 5		, szName = "AK-47"				, iDamage = 10		, szKillerMessage = "%s killed %s with an AK-47"  										};
	pWeaponDataTable [ WEP_M16 ]					<- { iWeaponID = 6		, szName = "M-16"				, iDamage = 2		, szKillerMessage = "%s shredded %s's body apart with an M-16"  						};
	pWeaponDataTable [ WEP_SNIPER ]					<- { iWeaponID = 7		, szName = "Sniper Rifle"		, iDamage = 200		, szKillerMessage = "%s killed %s with a Sniper Rifle."  								};
	pWeaponDataTable [ WEP_ROCKETLAUNCHER ]			<- { iWeaponID = 8		, szName = "Rocket Launcher"	, iDamage = 200		, szKillerMessage = "%s's Rocket Launcher made sure there was nothing left of %s."  	};
	pWeaponDataTable [ WEP_FLAMETHROWER ]			<- { iWeaponID = 9		, szName = "Flamethrower"		, iDamage = 0		, szKillerMessage = "%s set %s on fire with a Flamethrower."  							};
	pWeaponDataTable [ WEP_MOLOTOV ]				<- { iWeaponID = 10		, szName = "Molotov"			, iDamage = 0		, szKillerMessage = "%s lit up %s with a Molotov."  									};
	pWeaponDataTable [ WEP_GRENADE ]				<- { iWeaponID = 11		, szName = "Grenade"			, iDamage = 0		, szKillerMessage = "%s blew up %s with a Grenade." 									};

	::print ( "[Server.Core]: Core weapon data table created" );
	
	return pWeaponDataTable;
	
}

// -------------------------------------------------------------------------------------------------

function InitBitFlagCoreTable ( ) {

	local pBitFlagsTable = { };

	pBitFlagsTable.AccountSettings					<- { };
	pBitFlagsTable.Licenses							<- { };
	pBitFlagsTable.StaffFlags						<- { };
	
	::print ( "[Server.Core]: Core bit flag tables created" );
	
	return pBitFlagsTable;
	
}

// -------------------------------------------------------------------------------------------------

function InitSecurityCoreTable ( ) {
	
	local pSecurityValuesTable = { };

	pSecurityValuesTable.iMinUsernameLen					<- 3;
	pSecurityValuesTable.iMaxUsernameLen					<- 32;
	pSecurityValuesTable.iMinPasswordLen					<- 6;
	pSecurityValuesTable.iMaxPasswordLen					<- 32;
	pSecurityValuesTable.bForcePasswordCaps					<- true;
	pSecurityValuesTable.bForcePasswordNumbers				<- true;
	pSecurityValuesTable.bForcePasswordSymbols				<- true;
	pSecurityValuesTable.szAllowedPasswordSymbols			<- "*()[]{}';:!@#$%^&*-=+";
	pSecurityValuesTable.szEncryptionPepper					<- "1234567890";
	pSecurityValuesTable.iMaxLoginAttempts					<- 3;

	// -- A string used with the format ( ) function to generate a string from ASCII characters.

	// pSecurityValuesTable.szFormatCharacterMask			<- @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c";
	pSecurityValuesTable.szUnsafeCharacters					<- "*()[]{}';:@#$%^&*-=+/\\";

	::print ( "[Server.Core]: Core security values table created" );
	
	return pSecurityValuesTable;
	
}
// -------------------------------------------------------------------------------------------------

function InitLocationsCoreTable ( ) {
	
	local pLocationsTable = { };
	
	pLocationsTable.Hospitals <- [ 
		
		{   pPosition = Vector ( 1144.25 , -596.875 , 14.97 )		, fAngle = 90.0		, szName = "Portland"				} , 
		{   pPosition = Vector ( 183.5 , -17.75 , 16.21 )			, fAngle = 180.0	, szName = "Staunton Island"		} , 
		{   pPosition = Vector ( -1259.5 , -44.5 , 58.89 )			, fAngle = 90.0		, szName = "Shoreside Vale"			}
		
	];

	pLocationsTable.PoliceStations <- [ 
		
		{   pPosition = Vector ( 1143.875 , -675.1875 , 14.97 )		, fAngle = 90.0		, szName = "Portland"				} , 
		{   pPosition = Vector ( 340.25 , -1123.375 , 25.98 )		, fAngle = 180.0	, szName = "Staunton Island"		} , 
		{   pPosition = Vector ( -1253.0 , -138.1875 , 58.75 )		, fAngle = 90.0		, szName = "Shoreside Vale"			}
		
	];
	
	pLocationsTable.FireStations <- [ 
		
		{   pPosition = Vector ( 1103.70 , -52.45 , 7.49 )			, fAngle = 90.0		, szName = "Portland"				} , 
		{   pPosition = Vector ( -78.48 , -436.80 , 16.17 )			, fAngle = 180.0		, szName = "Staunton Island"	} , 
		{   pPosition = Vector (-1202.10 , -14.67 , 53.20 )			, fAngle = 180.0		, szName = "Shoreside Vale"		}
		
	];	
	
	
	pLocationsTable.HiddenPackages <- [
		
		{	pPosition = Vector ( 1105.25 , -1020 , 25.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 877.562 , -788 , 27.5625 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1254 , -611.188 , 22.75 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1045.75 , -967.062 , 16 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 942.062 , -793.375 , 14.875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 934 , -718.875 , 14.75 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 898.062 , -414.688 , 26.5 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 846.875 , -442.5 , 23.1875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 927.062 , -404.375 , 29.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 864.25 , -171.5 , 3.5 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1538.25 , -174.375 , 19.1875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1213.06 , -127.062 , 15.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 753.562 , 137 , 3.5 )				, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1162 , -101.75 , 12 )				, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1155.56 , -191.5 , 14.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1285.5 , -247.5 , 42.375 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1007.19 , -219.562 , 6.6875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1138.19 , -250 , 24.25 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1023.56 , -423.688 , 14.875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1237.5 , -854.062 , 20.5625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1478.25 , -1150.69 , 12 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1018.88 , -56.75 , 21 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1465.69 , -166.5 , 55.5 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1120.19 , -926.188 , 16 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1206.5 , -821.5 , 15 )				, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 940.188 , -199.875 , 5 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 979.25 , -1143.06 , 13.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1195.5 , -908.75 , 14.875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1470.38 , -811.375 , 22.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1320.5 , -365.5 , 15.1875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 932.562 , -477.25 , -10.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 1305.88 , -380.875 , 39.5 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 938.188 , -1258.25 , 3.5 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 36.75 , -530.188 , 26 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 414.375 , -279.25 , 23.5625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 203.5 , -1252.56 , 59.25 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 77.6875 , -352.25 , 16.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 120.875 , 243.688 , 11.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 49.375 , 36.25 , 16.6875 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 68.0625 , -773.25 , 22.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -4 , -1129.06 , 26 )				, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -134.688 , -1386.88 , 26.1875 )	, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -23.5 , -1472.38 , 19.6875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 112.062 , -1227.56 , 26 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 218.25 , -1237.75 , 20.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 308 , -1533.38 , 23.5625 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 468.562 , -1457.19 , 44.25 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 355.062 , -1085.69 , 25.875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 312.375 , -483.75 , 29 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 322.25 , -447.062 , 23.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 586.688 , -795 , 1.5625 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 504.25 , -1027.75 , 1.6875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 174.062 , -1259.5 , 32.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 248.75 , -958.25 , 26 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 54.75 , -566.5 , 26.0625 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -77 , -1490.06 , 26 )				, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 556 , -231.375 , 22.75 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -38.1875 , -1434.25 , 31.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 194.75 , -0.5 , 19.75 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 223.062 , -272.188 , 16.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -18.0625 , -222.25 , 29.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -69.25 , -469.188 , 16.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -270.688 , -631.562 , 72.25 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -59.1875 , -579.75 , 15.875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 392.75 , -1135.56 , 15.875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 145 , -1584 , 30.6875 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 428.062 , -340.375 , 16.1875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( 351.062 , -980.5 , 33.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -221.75 , -1487.56 , 5.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1193.06 , -75.75 , 47.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1090.5 , 131.688 , 58.6875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1015.5 , -13 , 49.0625 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -821.75 , -184.875 , 33.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -849.062 , -209.375 , 41.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -736.375 , 304.688 , 54.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -678.062 , 308.562 , 59.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -609.188 , 286.688 , 65.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -329.562 , 320.062 , 60.6875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1221.06 , 562.75 , 68.5625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1131.88 , 605.375 , 68.5625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1098.38 , 471.25 , 35.5 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1208.06 , 325.188 , 3.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1216.19 , 347.875 , 30.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1211.88 , -166.875 , 58.6875 )	, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1195.19 , -7.6875 , 59.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -206.875 , 328.75 , 3.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -753.188 , 142 , 10.0625 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -697.875 , -182.062 , 9.1875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -748.375 , -807 , -13.5625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -489.875 , -44.875 , 3.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -632.875 , 67.5625 , 18.75 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -546.75 , 10.6875 , 3.875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1032.56 , -573.375 , 10.875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -542 , -1046.56 , 3.375 )			, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1556.38 , -905.75 , 14.5 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1327 , -624.688 , 11.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -737.375 , -745.375 , 9.6875 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1278.69 , -776 , 11.0625 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -1494.69 , -1097.25 , 3.375 )		, pPickup = false		, iCashWin = 1000		} ,  
		{	pPosition = Vector ( -837.75 , -469.188 , 10.75 )		, pPickup = false		, iCashWin = 1000		}
		
	];
	
	::print ( "[Server.Core]: Core standard locations tables created" );
	
	return pLocationsTable;

}

// -------------------------------------------------------------------------------------------------

function InitJobsCoreTable ( ) {

	local pJobsTable = [

		{   szName = "Police Officer"		   	, pPosition = ::Vector ( 1143.87 , -675.18 , 14.97 )			, pPickup = false , pMapBlip = false , iJobType = 2 } , 
		//{   szName = "Police Officer"		   	, pPosition = ::Vector ( 340.25 , -1123.37 , 25.98 )			, pPickup = false , pMapBlip = false , iJobType = 2 } , 
		//{   szName = "Police Officer"		   	, pPosition = ::Vector ( -1253.0 , -138.18 , 58.75 )			, pPickup = false , pMapBlip = false , iJobType = 2 } , 
	   
		{   szName = "Paramedic"		   		, pPosition = ::Vector ( 1144.25 , -596.87 , 14.97 )			, pPickup = false , pMapBlip = false , iJobType = 3 } , 
		//{   szName = "Paramedic"		   		, pPosition = ::Vector ( 183.5 , -17.75 , 16.21 )				, pPickup = false , pMapBlip = false , iJobType = 3 } , 
		//{   szName = "Paramedic"		   		, pPosition = ::Vector ( -1259.5 , -44.5 , 58.89 )				, pPickup = false , pMapBlip = false , iJobType = 3 } , 
		
		{   szName = "Firefighter"				, pPosition = ::Vector ( 1103.70 , -52.45 , 7.49 )				, pPickup = false , pMapBlip = false , iJobType = 2 } , 
		//{   szName = "Firefighter"			, pPosition = ::Vector ( -78.48 , -436.80 , 16.17 )				, pPickup = false , pMapBlip = false , iJobType = 2 } , 
		//{   szName = "Firefighter"			, pPosition = ::Vector (-1202.10 , -14.67 , 53.20 )				, pPickup = false , pMapBlip = false , iJobType = 2 } , 
		
		{   szName = "Trash Collector"			, pPosition = ::Vector ( 1121.8 , 27.8 , 1.99 )					, pPickup = false , pMapBlip = false , iJobType = 4 }
		
		/*
		{   szName = "Postal Worker"			, pPosition = Vector ( )										, pPickup = false , pMapBlip = false } , 
		{   szName = "Delivery Worker"			, pPosition = Vector ( )										, pPickup = false , pMapBlip = false } , 
		{   szName = "Taxi Driver"				, pPosition = Vector ( 1000.20 , -880.50 , 14.95 )				, pPickup = false , pMapBlip = false } , 
		{   szName = "Bus Driver"				, pPosition = Vector ( 1310.20 , -1016.30 , 14.88 )				, pPickup = false , pMapBlip = false } , 
		{   szName = "Mechanic"					, pPosition = Vector ( )										, pPickup = false , pMapBlip = false , iJobType = GetCoreTable ( ).Utilities.pJobs.Mechanic } , 
		*/
		
	];
	
	::print ( "[Server.Core]: Core job tables created" );
 
	return pJobsTable;
	
}

// -------------------------------------------------------------------------------------------------

function InitServerModules ( ) {

	print ( "[Server.Startup]: Initializing module 'lu_hashing' ... Result: " + LoadModule ( "lu_hashing" ) );
	print ( "[Server.Startup]: Initializing module 'lu_ini' ... Result: " + LoadModule ( "lu_ini" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function InitServerProcessingThreads ( ) {

	print ( "[Server.Startup]: Initiating server processing threads ... " );

	local pThreadTable = { };
	
	pThreadTable.LoadVehicleThread <- ::newthread ( LoadVehicleFromDatabase );
	pThreadTable.SaveVehicleThread <- ::newthread ( SaveVehicleToDatabase );
	// pThreadTable.LoadPlayerThread <- ::newthread ( LoadPlayerFromDatabase );
	// pThreadTable.SavePlayerThread <- ::newthread ( SavePlayerToDatabase );	

	return pThreadTable;
	
}

// -------------------------------------------------------------------------------------------------

function InitGameEntities ( ) {

	::print ( "[Server.Startup]: Initiating game entities ... " );
	
	::CreateBitwiseTables ( );
	::CreateBusinessPickups ( );
	::CreateHousePickups ( );
	::CreateJobPickupsAndBlips ( );
	::CreateVehicles ( );
	
	::AddAllCommandHandlers ( );
	
	// ::Echo_Initialize ( );

	return true;
	
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

::print ( "[Server.Core]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------