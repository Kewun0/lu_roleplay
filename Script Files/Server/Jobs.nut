function ShowJobInformationToPlayer ( pPlayer , pJobData ) {
    
    if ( !pJobData ) {
        
        return false;
        
    }
    
    MessagePlayerAlert ( pPlayer , "This is the " + pJobData.szName + " job. Use /takejob to start working." );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function CreateJobPickups ( ) {
    
    local pPickups = [ ];
    
    // Police Officer
    AddPickupToWorld ( GetCoreTable ( ).Locations.PoliceStations [ 0 ].pPosition , 1383 , GetCoreTable ( ).Utilities.pPickupDataType.Job , GetCoreTable ( ).Utilities.pJobs.Police );
    AddPickupToWorld ( GetCoreTable ( ).Locations.PoliceStations [ 1 ].pPosition , 1383 , GetCoreTable ( ).Utilities.pPickupDataType.Job , GetCoreTable ( ).Utilities.pJobs.Police );
    AddPickupToWorld ( GetCoreTable ( ).Locations.PoliceStations [ 2 ].pPosition , 1383 , GetCoreTable ( ).Utilities.pPickupDataType.Job , GetCoreTable ( ).Utilities.pJobs.Police );
    
    // Fire Fighter
    // AddPickupToWorld ( GetCoreTable ( ).Locations.FireStations [ 0 ].pPosition , 1361 , GetCoreTable ( ).Utilities.pPickupDataType.Job , GetCoreTable ( ).Utilities.pJobs.Fire );
    // AddPickupToWorld ( GetCoreTable ( ).Locations.FireStations [ 1 ].pPosition , 1361 , GetCoreTable ( ).Utilities.pPickupDataType.Job , GetCoreTable ( ).Utilities.pJobs.Fire );
    // AddPickupToWorld ( GetCoreTable ( ).Locations.FireStations [ 2 ].pPosition , 1361 , GetCoreTable ( ).Utilities.pPickupDataType.Job , GetCoreTable ( ).Utilities.pJobs.Fire );

    // Paramedic
    AddPickupToWorld ( GetCoreTable ( ).Locations.Hospitals [ 0 ].pPosition , 1361 , GetCoreTable ( ).Utilities.pPickupDataType.Job , GetCoreTable ( ).Utilities.pJobs.Medical );
    AddPickupToWorld ( GetCoreTable ( ).Locations.Hospitals [ 1 ].pPosition , 1361 , GetCoreTable ( ).Utilities.pPickupDataType.Job , GetCoreTable ( ).Utilities.pJobs.Medical );
    AddPickupToWorld ( GetCoreTable ( ).Locations.Hospitals [ 2 ].pPosition , 1361 , GetCoreTable ( ).Utilities.pPickupDataType.Job , GetCoreTable ( ).Utilities.pJobs.Medical );
    
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