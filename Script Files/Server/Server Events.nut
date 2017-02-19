function onScriptLoad ( ) {

	CallFunc ( "lu_roleplay/Server.nut" , "InitCoreTable" );

}

// -------------------------------------------------------------------------------------------------

function onServerStart ( ) {

    

}

// -------------------------------------------------------------------------------------------------

function onScriptUnload ( ) {

    foreach ( ii , iv in GetCoreTable ( ).Players ) {
    
        KickPlayer ( iv.pPlayer );
    
    }
    
    return;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerConnect ( pPlayer ) {
    
    ::print ( "- Player '" + pPlayer.Name + "' connected. (ID: " + pPlayer.ID + ", IP: " + pPlayer.IP + ", LUID " + pPlayer.LUID + ")" );
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerJoin ( pPlayer ) {
    
    MessagePlayer ( "Please wait a moment ..." , pPlayer , GetCoreTable ( ).Colours.RGB.White );
    
    NewTimer ( "InitPlayer" , 2000 , 1 , pPlayer );
    
    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") joined" );
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerPart ( pPlayer , iReason ) {
    
    SavePlayerToDatabase ( pPlayer );
    
    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") disconnected. Reason: " + iReason );
    
    ResetRentedVehicle ( pPlayer );
    
    // -- Make sure this goes last in the function. Once it's gone, we can't use it!
 
    
    GetCoreTable ( ).Players [ pPlayer.ID ] <- null;

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerDeath ( pPlayer , iReason ) {

    GetCoreTable ( ).Players [ pPlayer.ID ].iDeaths ++;
    GetCoreTable ( ).Players [ pPlayer.ID ].bDead = true;
    
    GetCoreTable ( ).Players [ pPlayer.ID ].pPosition = GetClosestHospital ( pPlayer.Pos );
    
    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") died. Reason: " + iReason );

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerEnteredVehicle ( pPlayer , pVehicle , iSeatID ) {

    local iVehicleDataID = GetCoreTable ( ).VehicleToData [ pVehicle.ID ];
    local pVehicleData = GetCoreTable ( ).Vehicles [ iVehicleDataID ];
    local pPlayerData = GetCoreTable ( ).Players [ pPlayer.ID ];

    // -- Let's make sure they didn't just enter a locked vehicle.
    
    if ( pVehicleData.bLocked ) {
    
        SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleIsLocked" ) , GetVehicleName ( pVehicle ) ) );        
        pPlayer.RemoveFromVehicle ( );
        
        return 0;
        
    }
    
    // -- If they entered the driver's seat
    
    if( iSeatID == 0 ) {
    
        // -- Vehicle engines automatically turn on when entering as a driver. If the engine is supposed to be off, use SetEngineState
        
        if ( !pVehicleData.bEngine ) {
        
            pVehicle.SetEngineState ( false );
        
        }
        
        // -- If the car can be rented, let the player know.
    
        if ( pVehicleData.iRentPrice > 0 ) {
        
            if ( !pVehicleData.pRenter ) {
            
                SendPlayerAlertMessage ( pPlayer , "You are renting this " + GetVehicleName ( pVehicle.Model ) );
            
            }
            
            pVehicle.SetEngineState ( false );
            
            MessagePlayer ( "If you want to drive this vehicle, you'll need to rent it for $" + pVehicleData.iRentPrice , pPlayer , GetCoreTable ( ).Colours.RGB.White );
            MessagePlayer ( "Use /rentvehicle to drive it now. Otherwise, please exit the vehicle." , pPlayer , GetCoreTable ( ).Colours.RGB.White );
        
        
        }
    
    }
    
    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") entered vehicle. Vehicle: " + pVehicle.ID + ", Seat: " + iSeatID );
    
    return 1;

}

// -------------------------------------------------------------------------------------------------

function onPlayerSpawn ( pPlayer , iSpawnClass ) {

    local pPlayerData = GetCoreTable ( ).Players [ pPlayer.ID ];
    
    if ( !pPlayerData.bCanSpawn ) {
    
        pPlayer.ForceToSpawnScreen ( );
        
        return 0;
    
    }
    
    if ( pPlayerData.bAuthenticated ) {
    
        pPlayer.Pos = pPlayerData.pPosition;
        pPlayer.Angle = pPlayerData.iAngle;
        
        pPlayer.Skin = pPlayerData.iSkin;
        
        pPlayer.Cash = pPlayerData.iCash;
    
    }
    
    return 1;

}

// -------------------------------------------------------------------------------------------------

function onPlayerCommand ( pPlayer , szCommand , szParams ) {

    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") tried command. String: /" + szCommand + " " + szParams );

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if( !IsCommandAllowedBeforeAuthentication ( szCommand ) ) {
        
        if ( !pPlayerData.bAuthenticated ) {
        
            print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Not authenticated - String: /" + szCommand + " " + szParams );
            
            return false;
        
        }
        
        if( !pPlayerData.bCanUseCommands ) {
        
            print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: bCanUseCommands is false - String: /" + szCommand + " " + szParams );
            
            return false;
        
        }        
        
    }
    
    if ( DoesCommandHandlerExist ( szCommand.tolower ( ) ) ) {

		if ( GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).iStaffFlags != 0 ) {
			
			if ( !HasBitFlag ( pPlayerData.iStaffFlags , GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).iStaffFlags ) ) {
			
				SendPlayerErrorMessage ( pPlayer , "You don't have permission to use this command!" );
				
				print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Does not have required staff flags - String: /" + szCommand + " " + szParams );
				
				return true;
			
			}
		
		}
    
        if ( !GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bEnabled ) {
        
            SendPlayerErrorMessage ( pPlayer , "The " + szCommand + " command is disabled. Reason: " + szCommand.tolower ( ).szDisableReason );
            
            print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Command is disabled - String: /" + szCommand + " " + szParams );
            
            return true;
        
        }

        return GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ) [ "pListener" ] ( pPlayer , szCommand , szParams );
        
    }

    SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UnknownCommand" ) + " - /" + szCommand );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerChat ( pPlayer , szText ) {

    local pPlayerData = GetCoreTable ( ).Players [ pPlayer.ID ];
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "YouAreMuted" ) );
        
        return 0;
    
    }
    
    Message ( GetCoreTable ( ).Colours.ByType.ChatPlayerHeader + "(All) " + GetCoreTable ( ).Colours.ByType.ChatPlayerName + pPlayer.Name + ": " + GetCoreTable ( ).Colours.ByType.ChatMessage + szText , GetCoreTable ( ).Colours.RGB.White );

    return 0;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerAction ( pPlayer , szText ) {

    local pPlayerData = GetCoreTable ( ).Players [ pPlayer.ID ];
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are muted, and cannot use an action!" );
        
        return 0;
    
    }

    return 1;
    
}

// -------------------------------------------------------------------------------------------------

function onPickupPickedUp ( pPlayer , pPickup ) {

    local iPickupDataType = GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataType;
    local iPickupDataID = GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID;

    switch ( iPickupDataType ) {
        
        case GetCoreTable ( ).Utilities.pPickupDataType.HiddenPackage: // -- Hidden Package
            
            AttemptHiddenPackagePickup ( pPlayer , iPickupDataID );
            
            GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataType <- 0;
            GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID <- -1;
            
            pPickup.Remove ( );
            
            break;
            
        case GetCoreTable ( ).Utilities.pPickupDataType.Business: // -- Business
            
            ShowBusinessInformationToPlayer ( pPlayer , GetCoreTable ( ).Businesses [ iPickupDataID ] );
            
            break;            
            
            
        case GetCoreTable ( ).Utilities.pPickupDataType.House: // -- House
            
            ShowHouseInformationToPlayer ( pPlayer , GetCoreTable ( ).Houses [ iPickupDataID ] );
            
            break;        
            
            
        case GetCoreTable ( ).Utilities.pPickupDataType.Job: // -- Job
            
            ShowJobInformationToPlayer ( pPlayer , GetCoreTable ( ).Jobs [ iPickupDataID ] );
            
            break;              
            
            
        case GetCoreTable ( ).Utilities.pPickupDataType.None: // -- None (usually because it's not spawned or something fucked up)
        default:
        
            break;
    }

    return true;
    
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.ServerEvents]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------