function ShowJobInformationToPlayer ( pPlayer , pJobData ) {
    
    if ( !pJobData ) {
        
        return false;
        
    }
    
    MessagePlayerAlert ( pPlayer , "This is the " + pJobData.szName + " job. Use /takejob to start working." );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function CreateJobPickupsAndBlips ( ) {
    
    local pPickups = [ ];
    
	
	foreach ( ii , iv in GetCoreTable ( ).Jobs ) {
		
		iv.pPickup = AddPickupToWorld ( iv.pPosition , 1361 , GetCoreTable ( ).Utilities.pPickupDataType.Job , iv.iJobType );
		iv.pMapBlip = CreateBlip ( BLIP_NONE , iv.pPosition );
		iv.pMapBlip.Size = 2;
		iv.pMapBlip.DisplayType = BLIPTYPE_BLIPONLY;
		iv.pMapBlip.Colour = 1;
	
	}
    
    print ( "[ServerStart]: Job pickups created" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function TakeJobCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    foreach ( ii , iv in GetCoreTable ( ).Jobs ) {
        
        if ( GetDistance ( pPlayer.Pos , iv.pPosition ) <= GetCoreTable ( ).Utilities.fTakeJobRange ) {
            
            SetPlayerJob ( pPlayer , iv );
            
            SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "TakeJobSuccessful" ) , iv.szName ) );
            
            return true;
            
        }
        
    }
    
    MessagePlayerError ( pPlayer , "You are not near any job site!" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------