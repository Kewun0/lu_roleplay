function LoadHousesFromDatabase ( ) {
   
	local pHousesData = [ ];
	local pHouseData = { };
	local iHousesCount = 0;
	
	iHousesCount = GetNumberOfHouses ( );
	
	for ( local i = 1 ; i <= iHousesCount ; i++ ) {
	
		pHouseData = GetCoreTable ( ).Classes.HouseData ( );
		
		pHousesData.push ( pHousesData );
	
	}
	
	// -- Return the table, even if it's empty. It will show that no houses exist to load.
	
	return pHousesData;
	
}

// -------------------------------------------------------------------------------------------------

function ShowHouseInformationToPlayer ( pPlayer , pHouseData ) {
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function CreateHousePickups ( ) {
	
	local pPickup = false;
	
	foreach ( ii , iv in GetCoreTable ( ).Houses ) {
		
		UnitedIslands.Houses [ ii ].pPickup = AddPickupToWorld ( iv.pPosition , 1384 , GetCoreTable ( ).Utilities.pPickupDataType.House , ii )
		
	}
	
	print ( "[ServerStart]: House pickups created" );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------


function GetNumberOfHouses ( ) {

	return ReadIniInteger ( "Scripts/United Islands RPG/Data/Index.ini" , "General" , "iHouseAmount" );

}

// -------------------------------------------------------------------------------------------------

function GotoHouseCommand ( pPlayer , szCommand , szParams ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.House]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------