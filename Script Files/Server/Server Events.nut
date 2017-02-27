function onScriptLoad ( ) {

	CallFunc ( "lu_roleplay/Server.nut" , "InitCoreTable" );

}

// -------------------------------------------------------------------------------------------------

function onServerStart ( ) {

	

}

// -------------------------------------------------------------------------------------------------

function onScriptUnload ( ) {

	SaveServerDataToDatabase ( );

	Message ( "SCRIPT RE-LOADING ... PLEASE /RECONNECT !!!" , Colour ( 255 , 0 , 0 ) );
	
	foreach ( ii , iv in ConnectedPlayers ) {
	
		KickPlayer ( iv );
	
	}
	
	return;
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerConnect ( pPlayer ) {

	pPlayer.ColouredName = GetHexColour ( "White" ) + pPlayer.Name;
	pPlayer.Colour = 1;
	
	ConnectedPlayers.rawset ( pPlayer.ID , pPlayer );
	
	GetCoreTable ( ).Players [ pPlayer.ID ] <- GetCoreTable ( ).Classes.PlayerData ( );
	GetCoreTable ( ).Players [ pPlayer.ID ].pPlayer = pPlayer;
	
	Message ( GetHexColour ( "White" ) + pPlayer.Name + GetHexColour ( "LightGrey" ) + " has connected!" , GetRGBColour ( "White" ) );
	
	::print ( "- Player '" + pPlayer.Name + "' connected. (ID: " + pPlayer.ID + ", IP: " + pPlayer.IP + ", LUID " + pPlayer.LUID + ")" );
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerJoin ( pPlayer ) {
	
	pPlayer.ColouredName = GetHexColour ( "White" ) + pPlayer.Name;
	pPlayer.Colour = 1;
	
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

	ConnectedPlayers.rawdelete ( pPlayer.ID );
	
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
		
			SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "YouAreVehOwner" ) , GetVehicleName ( pVehicle.Model ) ) );
		
		}
		
		// -- If the car can be rented, let the player know.
	
		if ( pVehicleData.iRentPrice > 0 ) {
		
			if ( pVehicleData.pRenter ) {
			
				if ( pVehicleData.pRenter.ID == pPlayer.ID ) {
				
					SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "YouAreVehRenter" ) , GetVehicleName ( pVehicle.Model ) ) );
				
				}
			
			} else {
			
				pVehicleData.bEngine = false;
				
				MessagePlayer ( format ( GetPlayerLocaleMessage ( pPlayer , "VehicleForRent" ) , pVehicleData.iRentPrice ) , pPlayer , GetRGBColour ( "White" ) );
				MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "RentVehToUse" ) , pPlayer , GetRGBColour ( "White" ) );
		
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
		
			MessagePlayer ( format ( GetPlayerLocaleMessage ( pPlayer , "VehicleForSale" ) , pVehicleData.iBuyPrice ) , pPlayer , GetRGBColour ( "White" ) );
			MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "BuyVehToUse" ) , pPlayer , GetRGBColour ( "White" ) );			

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
				GetVehicleData ( pVehicle ).pColour1 = { r = 255 , g = 255 , b = 255 };
				GetVehicleData ( pVehicle ).pColour2 = { r = 255 , g = 255 , b = 255 };
				pVehicle.RGBColour1 = GetRGBColour ( "White" );
				pVehicle.RGBColour2 = GetRGBColour ( "White" );
				
			}
		
		}
	
	}

}

// -------------------------------------------------------------------------------------------------

function onPlayerExitedVehicle ( pPlayer , pVehicle ) {
	
	if ( GetPlayerData ( pPlayer ).pBuyVehState == 2 ) { // Player bought car, but they got out before leaving the lot
		
		GetVehicleData ( pVehicle ).iBuyPrice = pVehicleData.iBuyPrice;
		GetVehicleData ( pVehicle ).iOwnerType = 0;
		GetVehicleData ( pVehicle ).iOwnerType = 0;
		GetVehicleData ( pVehicle ).bEngine = false;
		
	}
	
	if ( !GetVehicleData ( pVehicle ).bSpawnLock ) {
		
		GetVehicleData ( pVehicle ).pPosition = pVehicle.Pos;
		GetVehicleData ( pVehicle ).fAngle = pVehicle.Angle;	
		pVehicle.SpawnPos = pVehicle.Pos;
		pVehicle.SpawnAngle = pVehicle.Angle;
		
	}
	
	if ( !pVehicle.Driver ) {
	
		pVehicle.SetEngineState ( false );
		
	}
	
	return 1;
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerSpawn ( pPlayer , iSpawnClass ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pPlayerData.bCanSpawn ) {
	
		ClearChat ( pPlayer );
		
		MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "NeedAuthForSpawn" ) , pPlayer , GetRGBColour ( "BrightRed" ) );
		
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
		
		local pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "NewPlayerReadyToPlay" );
		
		local pMessageColours = [ 
			
			GetRGBColour ( "White" ) ,
			GetRGBColour ( "White" ) ,
			GetRGBColour ( "Yellow" ) , 
			GetRGBColour ( "LightGrey" ) , 
			GetRGBColour ( "LightGrey" )
			
		];
		
		foreach ( ii , iv in pMessages ) {

			MessagePlayer ( iv , pMessageColours [ ii ] );
		
		}
		
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
		
			SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NeedAuthForCommand" ) );
		
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Not authenticated - String: /" + szCommand + " " + szParams );
			
			return false;
		
		}
		
		if( !pPlayerData.bCanUseCommands ) {
		
			SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CantUseCommands" ) );
		
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: bCanUseCommands is false - String: /" + szCommand + " " + szParams );
			
			return false;
		
		}		
		
	}
	
	if ( DoesCommandHandlerExist ( szCommand.tolower ( ) ) ) {

		if ( GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).iStaffFlags != 0 ) {
			
			if ( !HasBitFlag ( pPlayerData.iStaffFlags , GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).iStaffFlags ) ) {
			
				SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
				
				print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Does not have required staff flags - String: /" + szCommand + " " + szParams );
				
				return true;
			
			}
		
		}
	
		if ( !GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bEnabled ) {
		
			SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "CommandDisabled" ) , szCommand , szCommand.tolower ( ).szDisableReason ) );
			
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
	
	CallFunc ( "Scripts/LiLC.IRC/Server.nut" , "EchoPlayerChat" , pPlayer , szText );
	
	return 0;
	
}

// -------------------------------------------------------------------------------------------------

function onPlayerAction ( pPlayer , szText ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( pPlayerData.bMuted ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CantUseMeAction" ) );
		
		return 0;
	
	}

	return 1;
	
}

// -------------------------------------------------------------------------------------------------

function onVehicleRespawn ( pVehicle ) {

	local pVehicleData = GetVehicleData ( pVehicle );
	
	pVehicle.RGBColour1 = Colour ( pVehicleData.pColour1.r , pVehicleData.pColour1.g , pVehicleData.pColour1.b );
	pVehicle.RGBColour2 = Colour ( pVehicleData.pColour2.r , pVehicleData.pColour2.g , pVehicleData.pColour2.b );
	
	pVehicle.bLocked = true;
	pVehicle.SetEngineState ( false );
	
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