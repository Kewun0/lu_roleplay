function onScriptLoad ( ) {

	CallFunc ( "lu_roleplay/Server.nut" , "InitCoreTable" );

}

// -------------------------------------------------------------------------------------------------

function onServerStart ( ) {

	

}

// -------------------------------------------------------------------------------------------------

function onScriptUnload ( ) {

	Message ( "SCRIPT RE-LOADING ... PLEASE /RECONNECT !!!" , Colour ( 255 , 0 , 0 ) );
	
	foreach ( ii , iv in ConnectedPlayers ) {
	
		KickPlayer ( iv );
	
	}
	
	return;
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerConnect ( pPlayer ) {
	
	ConnectedPlayers [ pPlayer.ID ] <- pPlayer;
	
	GetCoreTable ( ).Players [ pPlayer.ID ] <- GetCoreTable ( ).Classes.PlayerData ( pPlayer );
	
	Message ( GetHexColour ( "White" ) + pPlayer.Name + GetHexColour ( "LightGrey" ) + " has connected!" , GetRGBColour ( "White" ) );
	
	::print ( "- Player '" + pPlayer.Name + "' connected. (ID: " + pPlayer.ID + ", IP: " + pPlayer.IP + ", LUID " + pPlayer.LUID + ")" );
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerJoin ( pPlayer ) {
	
	MessagePlayer ( "Please wait a moment ..." , pPlayer , GetRGBColour ( "White" ) );
	
	NewTimer ( "InitPlayer" , 2000 , 1 , pPlayer );
	
	print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") joined" );
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerPart ( pPlayer , iReason ) {
	
	SavePlayerToDatabase ( pPlayer );
	
	print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") disconnected. Reason: " + iReason );
	
	ResetRentedVehicle ( pPlayer );
	
	Message ( GetHexColour ( "White" ) + pPlayer.Name + GetHexColour ( "LightGrey" ) + " has left the server (" + GetCoreTable ( ).Utilities.szPartReasons [ iReason ] + ")" , GetRGBColour ( "White" ) );
	
	// -- Make sure this goes last in the function. Once it's gone, we can't use it!
	
	GetCoreTable ( ).Players [ pPlayer.ID ] <- null;

	ConnectedPlayers [ pPlayer.ID ] <- null;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerDeath ( pPlayer , iReason ) {

	GetPlayerData ( pPlayer ).iDeaths ++;
	GetPlayerData ( pPlayer ).bDead = true;
	
	GetPlayerData ( pPlayer ).pPosition = GetClosestHospital ( pPlayer.Pos );
	
	print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") died. Reason: " + iReason );

	return true;
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerEnteredVehicle ( pPlayer , pVehicle , iSeatID ) {

	local iVehicleDataID = GetCoreTable ( ).VehicleToData [ pVehicle.ID ];
	local pVehicleData = GetCoreTable ( ).Vehicles [ iVehicleDataID ];
	local pPlayerData = GetPlayerData ( pPlayer );

	// -- Let's make sure they didn't just enter a locked vehicle.
	
	if ( pVehicleData.bLocked ) {
	
		SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleIsLocked" ) , GetVehicleName ( pVehicle ) ) );		
		pPlayer.RemoveFromVehicle ( );
		
		return 0;
		
	}
	
	// -- If they entered the driver's seat
	
	if( iSeatID == 0 ) {
		
		if ( pVehicleData.iOwnerType == GetCoreTable ( ).Utilities.pVehicleOwnerType.Player && pVehicleData.iOwnerID == pPlayerData.iDatabaseID ) {
		
			SendPlayerAlertMessage ( pPlayer , "You are the owner of this " + GetVehicleName ( pVehicle.Model ) );
		
		}
		
		// -- If the car can be rented, let the player know.
	
		if ( pVehicleData.iRentPrice > 0 ) {
		
			if ( pVehicleData.pRenter ) {
			
				if ( pVehicleData.pRenter.ID == pPlayer.ID ) {
				
					SendPlayerAlertMessage ( pPlayer , "You are renting this " + GetVehicleName ( pVehicle.Model ) );
				
				}
			
			} else {
			
				pVehicleData.bEngine = false;
				
				MessagePlayer ( "If you want to drive this vehicle, you'll need to rent it for $" + pVehicleData.iRentPrice , pPlayer , GetRGBColour ( "White" ) );
				MessagePlayer ( "Use /rentvehicle to drive it now. Otherwise, please exit the vehicle." , pPlayer , GetRGBColour ( "White" ) );
		
			}
		
		}
		
		// -- If the car can be bought, let the player know.
		
		if ( pVehicleData.iBuyPrice > 0 ) {
		
			pVehicleData.bEngine = false;
			
			pPlayerData.pBuyVehState = 1;
			pPlayerData.pBuyVehVehicle = pVehicle;
			pPlayerData.pBuyVehPrice = pVehicleData.iBuyPrice;
			pPlayerData.pBuyVehPosition = pVehicle.Pos;
			pPlayerData.pBuyVehAngle = pVehicle.Angle;
		
			MessagePlayer ( "This vehicle is for sale. Cost $" + pVehicleData.iBuyPrice , pPlayer , GetRGBColour ( "White" ) );
			MessagePlayer ( "Use /buyvehicle to buy it now. Otherwise, please exit the vehicle." , pPlayer , GetRGBColour ( "White" ) );			

		}
		
		// -- Vehicle engines automatically turn on when entering as a driver. If the engine is supposed to be off, use SetEngineState
		
		if ( !pVehicleData.bEngine ) {
		
			pVehicle.SetEngineState ( false );
		
		}
	
	}
	
	print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") entered vehicle. Vehicle: " + pVehicle.ID + ", Seat: " + iSeatID );
	
	return 1;

}

// -------------------------------------------------------------------------------------------------

function onPlayerUpdate ( pPlayer ) {

	if ( pPlayer.Vehicle ) {
	
		if ( GetPlayerData ( pPlayer ).pBuyVehState == 2 ) { // Player bought car, waiting to leave the parking space
		
			if ( GetDistance ( pPlayer.Pos , GetPlayerData ( pPlayer ).pBuyVehPosition ) > 15.0 ) {
				
				GetPlayerData ( pPlayer ).pBuyVehState = 0; // Player left parking space, create new dealership car and reset
				local pVehicle = CreateNewVehicle ( GetPlayerData ( pPlayer ).pBuyVehVehicle.Model , GetPlayerData ( pPlayer ).pBuyVehPosition , GetPlayerData ( pPlayer ).pBuyVehAngle );
				GetVehicleData ( pVehicle ).iBuyPrice = GetPlayerData ( pPlayer ).pBuyVehPrice;
			
			}
		
		}
	
	}

}

// -------------------------------------------------------------------------------------------------

function onPlayerExitedVehicle ( pPlayer , pVehicle , iSeatID ) {
	
	if ( GetPlayerData ( pPlayer ).pBuyVehState == 2 ) { // Player bought car, but they got out before leaving the lot
		
		GetPlayerData ( pPlayer ).pBuyVehVehicle.Pos = Vector ( 1215.1 , -102.78 , 14.15 );
		GetPlayerData ( pPlayer ).pBuyVehVehicle.Angle = 90.0;

		CreateNewVehicle ( pVehicleData , GetPlayerData ( pPlayer ).pBuyVehPosition , GetPlayerData ( pPlayer ).pBuyVehAngle );
		GetPlayerData ( pPlayer ).pBuyVehState = 0; // Create new dealership car and reset	
		
	}
	
	return 1;
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerSpawn ( pPlayer , iSpawnClass ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pPlayerData.bCanSpawn ) {
	
		ClearChat ( pPlayer );
		
		MessagePlayer ( "You need to be logged in to spawn!" , pPlayer , GetRGBColour ( "BrightRed" ) );
		
		pPlayer.ForceToSpawnScreen ( );
		
		return 0;
	
	}
	
	if ( pPlayerData.bAuthenticated ) {
	
		pPlayer.Pos = pPlayerData.pPosition;
		pPlayer.Angle = pPlayerData.iAngle;
		
		pPlayer.Skin = pPlayerData.iSkin;
		
		pPlayer.Cash = pPlayerData.iCash;
	
	}
	
	if ( pPlayerData.bNewlyRegistered ) {
	
		ClearChat ( pPlayer );
			
		MessagePlayer ( "Your flight has just landed in Liberty City." , pPlayer , GetRGBColour ( "White" ) );
		MessagePlayer ( "You have some cash to get started." , pPlayer , GetRGBColour ( "White" ) );
		
		MessagePlayer ( "Be sure to read the /rules and use /help for info." , pPlayer , GetRGBColour ( "Yellow" ) );
		
		MessagePlayer ( "To get started, get in a rental Blista or take the train." , pPlayer , GetRGBColour ( "LightGrey" ) );
		MessagePlayer ( "The Shoreside Terminal train station is down the road to the south." , pPlayer , GetRGBColour ( "LightGrey" ) );
	
	}
	
	return 1;

}

// -------------------------------------------------------------------------------------------------

function onPlayerCommand ( pPlayer , szCommand , szParams ) {

	print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") tried command. String: /" + szCommand + " " + szParams );

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pPlayerData ) {
	
		return false;
	
	}
	
	if( !IsCommandAllowedBeforeAuthentication ( szCommand ) ) {
		
		if ( !pPlayerData.bAuthenticated ) {
		
			SendPlayerErrorMessage ( pPlayer , "You need to be logged in to use commands!" );
		
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Not authenticated - String: /" + szCommand + " " + szParams );
			
			return false;
		
		}
		
		if( !pPlayerData.bCanUseCommands ) {
		
			SendPlayerErrorMessage ( pPlayer , "You can't use commands right now!" );
		
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

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pPlayerData.bAuthenticated ) {
	
		return 0;
		
	}
	
	if ( !pPlayerData.bCanUseCommands ) {
	
		return 0;
		
	}	
	
	if ( !pPlayerData.bCanSpawn ) {
	
		return 0;
		
	}	
	
	if ( pPlayerData.bMuted ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "YouAreMuted" ) );
		
		return 0;
	
	}
	
	Message ( GetCoreTable ( ).Colours.ByType.ChatPlayerHeader + "(All) " + GetCoreTable ( ).Colours.ByType.ChatPlayerName + pPlayer.Name + ": " + GetCoreTable ( ).Colours.ByType.ChatMessage + szText , GetCoreTable ( ).Colours.RGB.White );

	return 0;
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerAction ( pPlayer , szText ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
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