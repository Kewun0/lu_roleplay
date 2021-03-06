
// NAME: Vehicle.nut
// DESC: Handles anything related to vehicles and vehicle data.

// -- COMMANDS -------------------------------------------------------------------------------------

function AddVehicleCommandHandlers ( ) {

	AddCommandHandler ( "AddVeh" 			, CreateVehicleCommand 				, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "DelVeh" 			, DeleteVehicleCommand 				, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RentVehicle" 		, RentVehicleCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "BuyVehicle" 		, BuyVehicleCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "StopRent" 			, StopRentVehicleCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehEngine" 		, VehicleEngineCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Engine" 			, VehicleEngineCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Lock" 				, VehicleLockCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehLock" 			, VehicleLockCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Lights" 			, VehicleLightsCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehLights" 		, VehicleLightsCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Siren" 			, VehicleSirenCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehSiren" 			, VehicleSirenCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "SirenLight" 		, VehicleSirenLightCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehSirenLight" 	, VehicleSirenLightCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "TaxiLight" 		, VehicleTaxiLightCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehTaxiLight" 		, VehicleTaxiLightCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "RentPrice" 		, SetVehicleRentPriceCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "BuyPrice" 			, SetVehicleBuyPriceCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnAll" 		, RespawnAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "ExplodeAll" 		, ExplodeAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "VehOwner" 			, SetVehicleOwnerCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "VehColour" 		, SetVehicleColourCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehFuel" 			, SetVehicleFuelCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "VehHealth" 		, SetVehicleHealthCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "VehSpawnLock" 		, VehicleSpawnLockCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );

	return true;
	
}

// -------------------------------------------------------------------------------------------------

function LoadVehiclesFromDatabase ( ) {
	
	local pVehiclesData = [ ];
	local pVehicleData = false;
	local iVehiclesCount = 0;
	
	iVehiclesCount = GetNumberOfVehicles ( );
	
	if( iVehiclesCount > 0 ) {
	
		for ( local i = 1 ; i <= iVehiclesCount ; i++ ) {
		
		   pVehicleData = ::CallLoadVehicleThread ( i );
		   
		   pVehiclesData.push ( pVehicleData );
		
		}
		
	}
	
	// -- Return the table, even if it's empty. It will show that no vehicles exist to load.
	
	print ("[ServerStart]: " + pVehiclesData.len ( ) + " Vehicles Loaded!" );
	
	return pVehiclesData;
	
}

// -------------------------------------------------------------------------------------------------

function CallLoadVehicleThread ( iDatabaseID ) {

	return ::GetCoreTable( ).Threads.LoadVehicleThread.call ( iDatabaseID );

}

// -------------------------------------------------------------------------------------------------

function SaveVehicleToDatabase ( pVehicle ) {
	
	local pVehicleData = ::GetVehicleData ( pVehicle );
	local pQuery = false;
	
	local pPosition = pVehicleData.pPosition;
	local fAngle = pVehicleData.fAngle;

	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iModel" , pVehicleData.iModel );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iColour1Red" , pVehicleData.pColour1.r );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iColour1Green" , pVehicleData.pColour1.g );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iColour1Blue" , pVehicleData.pColour1.b );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iColour2Red" , pVehicleData.pColour2.r );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iColour2Green" , pVehicleData.pColour2.g );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iColour2Blue" , pVehicleData.pColour2.b );
	::WriteIniBool ( pVehicleData.szFileString , "General" , "bLocked" , pVehicleData.bLocked );
	::WriteIniFloat ( pVehicleData.szFileString , "General" , "fHealth" , pVehicleData.fHealth );
	::WriteIniFloat ( pVehicleData.szFileString , "General" , "fEngineDamage" , pVehicleData.fEngineDamage );
	::WriteIniFloat ( pVehicleData.szFileString , "General" , "fPositionX" , pPosition.x );
	::WriteIniFloat ( pVehicleData.szFileString , "General" , "fPositionY" , pPosition.y );
	::WriteIniFloat ( pVehicleData.szFileString , "General" , "fPositionZ" , pPosition.z );
	::WriteIniFloat ( pVehicleData.szFileString , "General" , "fRotationX" , 0.0 );
	::WriteIniFloat ( pVehicleData.szFileString , "General" , "fRotationY" , 0.0 );
	::WriteIniFloat ( pVehicleData.szFileString , "General" , "fRotationZ" , 0.0 );		
	::WriteIniFloat ( pVehicleData.szFileString , "General" , "fAngle" , fAngle );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iOwnerType" , pVehicleData.iOwnerType );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iOwnerID" , pVehicleData.iOwnerID );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iRentPrice" , pVehicleData.iRentPrice );
	::WriteIniInteger ( pVehicleData.szFileString , "General" , "iBuyPrice" , pVehicleData.iBuyPrice );		
	::WriteIniBool ( pVehicleData.szFileString , "General" , "bSpawnLock" , pVehicleData.bSpawnLock );	
	
	::print ( "- Vehicle " + pVehicleData.iDatabaseID + " (spawned as " + pVehicle.ID + ") saved to database" );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function SaveAllVehiclesToDatabase ( ) {

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		CallSaveVehicleThread ( iv.pVehicle );
	
	}

}

// -------------------------------------------------------------------------------------------------

function CallSaveVehicleThread ( pVehicle ) {
	
	::GetCoreTable( ).Threads.SaveVehicleThread.call ( pVehicle );

}

// -------------------------------------------------------------------------------------------------

function CreateVehicles ( ) {

	local pVehicle = false;

	if ( GetCoreTable ( ).Vehicles.len ( ) > 0 ) {
	
		foreach ( ii , iv in GetCoreTable ( ).Vehicles ) {
			
			pVehicle = CreateVehicle ( iv.iModel , Vector ( iv.pPosition.x , iv.pPosition.y , iv.pPosition.z ) , iv.fAngle );
			
			if ( pVehicle ) {
			
				pVehicle.RGBColour1 = Colour ( iv.pColour1.r , iv.pColour1.g , iv.pColour1.b );
				pVehicle.RGBColour2 = Colour ( iv.pColour2.r , iv.pColour2.g , iv.pColour2.b );
				
				pVehicle.Locked = iv.bLocked;
				pVehicle.LightState = !( pVehicle.LightState );
				pVehicle.SetEngineState ( false );
				
				iv.pVehicle = pVehicle;
				
				GetCoreTable ( ).VehicleToData [ pVehicle.ID ] = ii;
				
				print ( "[ServerStart]: Vehicle " + pVehicle.ID + " Spawned (" + GetVehicleName ( iv.iModel ) + " - " + ii + ")" );
			
			}
			
		}
	
	}
	
	print ( "[ServerStart]: " + GetCoreTable ( ).Vehicles.len ( ) + " vehicles spawned" );
	
	return true;
   
}

// -------------------------------------------------------------------------------------------------

function VehicleEngineCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bEngineState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicles engine on or off." , [ "engine" , "vehengine" ] , "You must have the keys. For more info, use /help vehicle keys." );
		
		return false;
	
	}

	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
		
		return false;
	
	}	
	
	if ( !DoesPlayerHaveVehicleKeys ( pPlayer , pPlayer.Vehicle ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You do not have keys to this vehicle!" );
		
		return false;
	
	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Engine <ON/OFF>" );
		SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );
		
		return false;
	
	}
	
	if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You entered an invalid engine state. It must ON or OFF" );
		
		return false;
	
	}

	bEngineState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	if ( bEngineState == true ) {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s engine has been turned on." );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s engine has been turned off." );
	
	}
	
	SetVehicleEngineState ( pPlayer.Vehicle , bEngineState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleLockCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bLockState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Locks or unlocks a vehicle's doors." , [ "Lock" , "VehLock" ] , "You must have keys, or be in a front seat. Use '/help vehicle keys' for info." );
		
		return false;
	
	}	
	
	if ( pPlayer.Vehicle ) {
	
		if ( pPlayer.VehicleSeat > 1 ) {
		
			SendPlayerErrorMessage ( pPlayer , "You must be in a front seat!" );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleName ( pPlayer.Vehicle.Model ) + "). Reason: Not in a front seat" );
			
			return false;
		
		}

		if ( !szParams ) {
		
			SendPlayerSyntaxMessage ( pPlayer , "/Lock <ON/OFF>" );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleName ( pPlayer.Vehicle.Model ) + "). Reason: No lock state param" );
			
			return false;
		
		}
		
		if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You entered an invalid lock state. It must ON or OFF" );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleName ( pPlayer.Vehicle.Model ) + "). Reason: Invalid lock state param" );
			
			return false;
		
		}

		bLockState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
		
		if ( bLockState == true ) {
		
			SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s doors have been locked." );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") successfully locked vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleName ( pPlayer.Vehicle.Model ) + ") from front seat" );
		
		} else {
		
			SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s doors have been unlocked." );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") successfully unlocked vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleName ( pPlayer.Vehicle.Model ) + ") from front seat" );
		
		}
		
		SetVehicleDoorLockState ( pPlayer.Vehicle , bLockState );
	
	} else {
		
		local pClosestVehicle = GetClosestVehicle ( pPlayer );
		
		if ( GetDistance ( pPlayer.Pos , pClosestVehicle.Pos ) > 10.0 ) {
		
			SendPlayerErrorMessage ( pPlayer , "You must be near a vehicle!" );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pClosestVehicle.ID + " (" + GetVehicleName ( pClosestVehicle.Model ) + "). Reason: Not close enough to vehicle ( " + GetDistance ( pPlayer.Pos , pClosestVehicle.Pos ) + " meters away)" );
			
			return false;
		
		}
		
		if ( !DoesPlayerHaveVehicleKeys ( pPlayer , pClosestVehicle ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You don't have the keys to this vehicle!" );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pClosestVehicle.ID + " (" + GetVehicleName ( pClosestVehicle.Model ) + "). Reason: Doesnt have keys" );
			
			return false;
		
		}

		if ( !szParams ) {
		
			SendPlayerSyntaxMessage ( pPlayer , "/Lights <ON/OFF>" );
			SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pClosestVehicle.ID + " (" + GetVehicleName ( pClosestVehicle.Model ) + "). Reason: No lock state param" );
			
			return false;
		
		}
		
		if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You entered an invalid lock state. It must ON or OFF" );
			SendPlayerSyntaxMessage ( pPlayer , "/Lights <ON/OFF>" );
			SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );			
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pClosestVehicle.ID + " (" + GetVehicleName ( pClosestVehicle.Model ) + "). Reason: Invalid lock state param" );
			
			return false;
		
		}
		
		if ( szParams.tolower ( ) == "on" ) {
		
			bLockState = true;
		
			SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pClosestVehicle.Model ) + "'s doors have been locked." );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") successfully locked vehicle " + pClosestVehicle.ID + " (" + GetVehicleName ( pClosestVehicle.Model ) + ") from nearby" );
		
		} else {
		
			bLockState = false;
		
			SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pClosestVehicle.Model ) + "'s doors have been unlocked." );
			
			print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") successfully unlocked vehicle " + pClosestVehicle.ID + " (" + GetVehicleName ( pClosestVehicle.Model ) + ") from nearby" );
		
		}
		
		SetVehicleDoorLockState ( pClosestVehicle , bLockState );
	
	}
	

	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleLightsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bLightState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicle's main lights on or off." , [ "Lights" , "VehLights" ] , "You must be driving the vehicle." );
		
		return false;
	
	}	
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Lights <ON/OFF>" );
		SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );
		
		return false;
	
	}
	
	if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You entered an invalid light state. It must ON or OFF" );
		SendPlayerInfoMessage ( pPlayer , "It is not case-sensitive. Example: OFF, Off, and off will all work." );
		
		return false;
	
	}

	bLightState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	if ( bLightState ) {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s lights have been turned on." );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s lights have been turned off." );
	
	}
	
	SetVehicleLightState ( pPlayer.Vehicle , bLightState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleSirenLightCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bSirenLightState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicle's siren light on or off." , [ "SirenLight" , "VehSirenLight" ] , "You must be in a front seat. Only works on cars with siren lights." );
		
		return false;
	
	}		
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat > 1 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a front seat!" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/SirenLight <ON/OFF>" );
		SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );
		
		return false;
	
	}
	
	if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You entered an invalid siren light state. It must ON or OFF" );
		SendPlayerInfoMessage ( pPlayer , "It is not case-sensitive. Example: OFF, Off, and off will all work." );
		
		return false;
	
	}

	bSirenLightState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	if ( bSirenLightState == true ) {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s siren lights have been turned on." );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s siren lights have been turned off." );
	
	}
	
	SetVehicleSirenLightState ( pPlayer.Vehicle , bSirenLightState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleTaxiLightCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bTaxiLightState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicle's taxi light on or off." , [ "TaxiLight" , "VehTaxiLight" ] , "You must be in a front seat. Only works on cars with siren lights." );
		
		return false;
	
	}		 
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat > 1 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a front seat!" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/TaxiLight <ON/OFF>" );
		SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );
		
		return false;
	
	}
	
	if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You entered an invalid taxi light state. It must ON or OFF" );
		
		return false;
	
	}

	bTaxiLightState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	if ( bTaxiLightState == true ) {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s taxi light has been turned on." );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s taxi light has been turned off." );
	
	}
	
	SetVehicleTaxiLightState ( pPlayer.Vehicle , bTaxiLightState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleSirenCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bSirenState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicle's siren on or off." , [ "Siren" , "VehSiren" ] , "You must be in a front seat. Only works on cars with sirens." );
		
		return false;
	
	}			 
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat > 1 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a front seat!" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Siren <ON/OFF>" );
		SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );
		
		return false;
	
	}
	
	if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You entered an invalid siren state. It must ON or OFF" );
		SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );
		
		return false;
	
	}

	bSirenState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	if ( bSirenState == true ) {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s siren have been turned on." );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle ) + "'s siren have been turned off." );
	
	}
	
	SetVehicleSirenState ( pPlayer.Vehicle , bSirenState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function SetVehicleLightState ( pVehicle , bLightState ) {

	local iLightState = bLightState;
	local pVehicleDataID = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	local pVehicleData = GetCoreTable( ).Vehicles [ pVehicleDataID ];
	
	pVehicle.LightState = iLightState;
	
	pVehicleData.bLightState = bLightState;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleDoorLockState ( pVehicle , bLockState ) {

	local pVehicleDataID = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	local pVehicleData = GetCoreTable( ).Vehicles [ pVehicleDataID ];
	
	pVehicle.Locked = bLockState;
	
	pVehicleData.bLocked = bLockState;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleEngineState ( pVehicle , bEngineState ) {

	local pVehicleDataID = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	local pVehicleData = GetCoreTable( ).Vehicles [ pVehicleDataID ];
	
	pVehicle.SetEngineState ( bEngineState );
	
	pVehicleData.bEngine = bEngineState;
	
	return;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleSirenState ( pVehicle , bSirenState ) {

	//local pVehicleData = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	
	pVehicle.Siren = bSirenState;
	
	return;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleSirenLightState ( pVehicle , bSirenLightState ) {

	//local pVehicleData = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	
	pVehicle.SirenLight = bSirenLightState;
	
	return;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleTaxiLightState ( pVehicle , bTaxiLightState ) {

	//local pVehicleData = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	
	pVehicle.TaxiLight = bTaxiLightState;
	
	return;

}

// -------------------------------------------------------------------------------------------------

function GetNumberOfVehicles ( ) {

	return ReadIniInteger ( "Scripts/lu_roleplay/Data/Index.ini" , "General" , "iVehicleAmount" );

}

// -------------------------------------------------------------------------------------------------

function LoadVehicleFromDatabase ( iDatabaseID ) {

	local pVehicleData = false;

	pVehicleData = GetCoreTable( ).Classes.VehicleData ( );
	
	pVehicleData.iDatabaseID = iDatabaseID;
	
	pVehicleData.szFileString =  "Scripts/lu_roleplay/Data/Vehicles/" + pVehicleData.iDatabaseID +".ini";
	
	pVehicleData.iModel = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iModel" );
	pVehicleData.pColour1 = { r = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iColour1Red" ) , g = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iColour1Green" ) , b = ::ReadIniInteger ( pVehicleData.szFileString , "General", "iColour1Blue" ) };
	pVehicleData.pColour2 = { r = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iColour2Red" ) , g = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iColour2Green" ) , b = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iColour2Blue" ) };
	pVehicleData.fAngle = ::ReadIniFloat ( pVehicleData.szFileString , "General" , "fAngle" );
	
	pVehicleData.pPosition = { x = ::ReadIniFloat ( pVehicleData.szFileString , "General" , "fPositionX" ) , y = ::ReadIniFloat ( pVehicleData.szFileString , "General" , "fPositionY" ) , z = ::ReadIniFloat ( pVehicleData.szFileString , "General" , "fPositionZ" ) };
	
	pVehicleData.iOwnerType = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iOwnerType" );
	pVehicleData.iOwnerID = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iOwnerType" );
	pVehicleData.bLocked = ::ReadIniBool ( pVehicleData.szFileString , "General" , "bLocked" );
	
	pVehicleData.iRentPrice = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iRentPrice" );
	pVehicleData.iBuyPrice = ::ReadIniInteger ( pVehicleData.szFileString , "General" , "iBuyPrice" );
	
	::print ( "[ServerStart]: Vehicle " + iDatabaseID + " loaded (" + ::GetVehicleName ( pVehicleData.iModel ) + ")" );
	
	return pVehicleData;
			
}

// -------------------------------------------------------------------------------------------------

function SetVehicleRentPriceCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	local pVehicleData = false;
	local iVehicleDataID = 0;
	
	if( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}	
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/RentPrice <$ Amount>" );
		SendPlayerInfoMessage ( pPlayer , "The amount will be charged one time, and doesn't change." );
		
		return false;
	
	}

	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The amount must be a number!" );
		
		return false;	
	
	}
	
	iVehicleDataID = GetCoreTable( ).VehicleToData [ pPlayer.Vehicle.ID ];
	pVehicleData = GetCoreTable( ).Vehicles [ iVehicleDataID ];
	
	pVehicleData.iRentPrice = szParams.tointeger ( );
	
	SendPlayerSuccessMessage ( pPlayer , "You have set the " + GetVehicleName ( pPlayer.Vehicle.Model ) + "'s rent price to $" + szParams.tointeger ( ) + " per hour." );
   
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleBuyPriceCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	local pVehicleData = false;
	local iVehicleDataID = 0;
	
	if( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}	
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/BuyPrice <$ Amount>" );
		SendPlayerInfoMessage ( pPlayer , "The amount will be charged one time, and doesn't change." );
		
		return false;
	
	}

	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The amount must be a number!" );
		
		return false;	
	
	}
	
	iVehicleDataID = GetCoreTable( ).VehicleToData [ pPlayer.Vehicle.ID ];
	pVehicleData = GetCoreTable( ).Vehicles [ iVehicleDataID ];
	
	pVehicleData.iBuyPrice = szParams.tointeger ( );
	
	SendPlayerSuccessMessage ( pPlayer , "You have set the " + GetVehicleName ( pPlayer.Vehicle.Model ) + "'s buy price to $" + szParams.tointeger ( ) + " per hour." );
   
	return true;

}

// -------------------------------------------------------------------------------------------------

function BuyVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
		
		return false;	
	
	}
	
	local pVehicleData = GetVehicleDataFromVehicle ( pPlayer.Vehicle );
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( pVehicleData.iBuyPrice == 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "This vehicle is not for sale!" );
		
		return false;
	
	}	   
	
	if ( pPlayerData.iCash < pVehicleData.iBuyPrice ) {
	
		SendPlayerErrorMessage ( pPlayer , "You don't have enough money to buy this vehicle!" );
		
		return false;
	
	}
	
	TakePlayerCash ( pPlayer , pVehicleData.iBuyPrice );
	SetVehicleOwner ( pPlayer.Vehicle , pPlayer );
	
	SendPlayerSuccessMessage ( pPlayer , "You now own this vehicle! Use /engine to start it." );
	SendPlayerAlertMessage ( pPlayer , "Please drive this car off the parking space, or you will lose it." );
	
	pPlayerData.pBuyVehPosition = pPlayer.Vehicle.Pos;
	pPlayerData.pBuyVehAngle = pPlayer.Vehicle.Angle;
	pPlayerData.pBuyVehVehicle = pPlayer.Vehicle;
	pPlayerData.pBuyVehState = 2;
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function RentVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
		
		return false;	
	
	}
	
	local pVehicleData = GetVehicleDataFromVehicle ( pPlayer.Vehicle );
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( pVehicleData.iRentPrice == 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "This vehicle is not rentable!" );
		
		return false;
	
	}	
	
	if ( pVehicleData.pRenter != false ) {
	
		SendPlayerErrorMessage ( pPlayer , "This vehicle is already being rented!" );
		
		return false;
	
	}	   
	
	if ( pPlayerData.iCash < pVehicleData.iRentPrice ) {
	
		SendPlayerErrorMessage ( pPlayer , "You don't have enough money to rent this vehicle!" );
		
		return false;
	
	}
	
	SetVehicleRenter ( pPlayer.Vehicle , pPlayer );
	
	SendPlayerSuccessMessage ( pPlayer , "You are now renting this vehicle! Use /engine to start it." );
	SendPlayerAlertMessage ( pPlayer , "You can use /stoprent to stop renting the vehicle" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function StopRentVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local pPlayerData = GetPlayerData ( pPlayer );

	if ( !pPlayerData.pRentingVehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not renting a vehicle!" );
		
		return false;
	
	}
	
	local pRentingVehicleData = GetVehicleDataFromVehicle ( pPlayerData.pRentingVehicle );
	
	TakePlayerCash ( pPlayer , pRentingVehicleData.iRentPrice );
	
	SendPlayerSuccessMessage ( pPlayer , "You have stopped renting the " + GetVehicleName ( pPlayerData.pRentingVehicle.Model ) );
	SendPlayerAlertMessage ( pPlayer , "The vehicle's engine has been disabled. You'll need to rent the vehicle again to drive it." );
	
	ResetRentedVehicle ( pPlayer );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ResetRentedVehicle ( pPlayer ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pPlayerData.pRentingVehicle ) {
	
		return false;
	
	}
	
	local pRentingVehicleData = GetVehicleDataFromVehicle ( pPlayerData.pRentingVehicle );
	
	if ( !pRentingVehicleData ) {
	
		return false;
	
	}
	
	if ( pRentingVehicleData.pRenter.ID != pPlayer.ID ) {
	
		return false;
	
	}
	
	pRentingVehicleData.pRenter = false;
	
	SetVehicleEngineState ( pPlayerData.pRentingVehicle , false );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function SetVehicleRenter ( pVehicle , pPlayer ) {

	local pVehicleData = GetVehicleDataFromVehicle ( pVehicle );
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pVehicleData ) {
	
		return false;
	
	}
	
	pVehicleData.pRenter = pPlayer;
	pPlayerData.pRentingVehicle = pVehicle;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleDataFromVehicle ( pVehicle ) {

	local pVehicleDataID = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	
	if ( pVehicleDataID == -1 ) {
	
		return false;
	
	}	
	
	local pVehicleData = GetVehicleData ( pVehicle )
	
	if ( !pVehicleData ) {
	
		return false;
	
	}
	
	return pVehicleData;

}

// -------------------------------------------------------------------------------------------------

function CreateVehicleCommand ( pPlayer , szVehicle , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Creates a new vehicle" , [ "AddVeh" ] , "" );
		
		return false;
	
	}

	if ( !szParams ) {
		
		SendPlayerSyntaxMessage ( pPlayer , "/AddVeh <Model ID/Name>" );
		
		return false;
		
	}

	local iModelID = 0;
	
	if ( IsNum ( szParams ) ) {
		
		if ( !IsValidVehicleModel ( szParams.tointeger ( ) ) ) {
			
			SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleModelInvalid" ) );
			
			return false;
			
		}
		
		iModelID = szParams.tointeger ( ) ;
		
	} else {
		
		local iModelID = GetVehicleIDFromName ( szParams.tostring ( ) );
		
		if ( !IsValidVehicleModel ( iModelID ) ) {
			
			SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleModelInvalid" ) );
			
			return false;
			
		}
		
	}
	
	print ( iModelID );
	
	local pVehicle = CreateNewVehicle ( iModelID , GetVectorInFrontOfPlayer ( pPlayer , 10.0 ) , pPlayer.Angle );
	
	SendPlayerSuccessMessage ( pPlayer , "Vehicle created! (Type: " + GetVehicleName ( pVehicle.Model ) + ")" );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function CreateNewVehicle ( iModelID , pPosition , fAngle ) {

	local pVehicle = CreateVehicle ( iModelID , pPosition , fAngle , Colour ( 255 , 255 , 255 ) , Colour ( 255 , 255 , 255 ) );
	
	if ( pVehicle ) {
	
		local pVehicleData = GetCoreTable( ).Classes.VehicleData ( );
		pVehicleData.iModel = iModelID;
		pVehicleData.pColour1 = { r = 255 , g = 255 , b = 255 } ,
		pVehicleData.pColour2 = { r = 255 , g = 255 , b = 255 } ,
		pVehicleData.pPosition = pPosition;
		pVehicleData.pRotation = Vector ( 0.0 , 0.0 , fAngle );
		pVehicleData.fAngle = fAngle;
		pVehicleData.pVehicle = pVehicle;
		
		local iVehicleCount = ::GetNumberOfVehicles ( );
		
		iVehicleCount = iVehicleCount + 1;
		
		pVehicleData.iDatabaseID = iVehicleCount.tointeger ( );
		
		::WriteIniInteger ( "Scripts/lu_roleplay/Data/Index.ini" , "General" , "iVehicleAmount" , iVehicleCount );	
		
		pVehicleData.szFileString = "Scripts/lu_roleplay/Data/Vehicles/" + pVehicleData.iDatabaseID + ".ini";		
		
		GetCoreTable ( ).Vehicles.push ( pVehicleData );
		
		GetCoreTable ( ).VehicleToData [ pVehicle.ID ] = GetVehicleDataSlotByDatabaseID ( pVehicleData.iDatabaseID );
		
		::SaveVehicleToDatabase ( pVehicle );
		
		return pVehicle;
	
	}

}

// -------------------------------------------------------------------------------------------------

function RespawnVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local pVehicle = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns a vehicle" , [ "RespawnVeh" ] , "" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/RespawnVeh <Vehicle ID>" );
		
		return false;
	
	}
	
	if ( IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "MustBeNumber" ) , "Vehicle ID" ) );
		
		return false;
	
	}
	
	szParams = szParams.tointeger ( );
	pVehicle = FindVehicle ( szParams );
	
	if ( !pVehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleNotFound" ) );
		
		return false;
		
		
	}
	
	pVehicle.Respawn ( );

	return true;

}

// -------------------------------------------------------------------------------------------------

function RespawnAllVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns all vehicles" , [ "RespawnAll" ] , "" );
		
		return false;
	
	}

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			iv.pVehicle.Respawn ( );
		
		}
	
	}
	
	SendAdminMessageToAll ( "All vehicles have been respawned by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles have been respawned!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function ExplodeAllVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Blows up all vehicles" , [ "ExplodeAll" ] , "" );
		
		return false;
	
	}

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			iv.pVehicle.Explode ( pPlayer );
		
		}
	
	}
	
	SendAdminMessageToAll ( "All vehicles have been exploded by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles have been exploded!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function DeleteVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleOwnerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Sets a player as owner of a vehicle" , [ "VehOwner" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/VehOwner <Vehicle ID> <Player Name/ID>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/VehOwner <Vehicle ID> <Player Name/ID>" );
		
		return false;
	
	}
	
	local szVehicleParam = GetTok ( szParams , " " , 1 );
	local szTargetParam = GetTok ( szParams , " " , 2 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player was not found!" );
		
		return false;   
	
	}
	
	local pTarget = FindPlayer ( szTargetParam );
	
	if ( !FindVehicle ( szVehicleParam.tointeger ( ) ) ) {
		
		SendPlayerErrorMessage ( pPlayer , "That vehicle does not exist!" );
		
		return false;
	
	}
	
	local pVehicle = FindVehicle ( szVehicleParam.tointeger ( ) );
	
	GetVehicleData ( pVehicle ).iOwnerType = GetCoreTable ( ).Utilities.pVehicleOwnerType.Player;
	GetVehicleData ( pVehicle ).iOwnerID = GetPlayerData ( pPlayer ).iDatabaseID;
	
	SendPlayerSuccessMessage ( pPlayer , "The owner for vehicle '" + GetVehicleName( pVehicle.Model ) + "' (ID " + pVehicle.ID + ") has been set to " + pPlayer.Name );
	SendPlayerAlertMessage ( pTarget , pPlayer.Name + " has set you as owner for vehicle '" + GetVehicleName( pVehicle.Model ) + "' (ID " + pVehicle.ID + ")" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleColourCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Sets a vehicle colour" , [ "VehColour" ] , "" );
		
		return false;
	
	}
	
	if( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You need to be in a vehicle!" );
		
		return false;
	
	}	
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/VehColour <Colour Number> <Red> <Green> <Blue>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 4 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/VehColour <1/2> <Red> <Green> <Blue>" );
		
		return false;
	
	}
	
	local szColourIDParam = GetTok ( szParams , " " , 1 );
	local szRedParam = GetTok ( szParams , " " , 2 );
	local szGreenParam = GetTok ( szParams , " " , 3 );
	local szBlueParam = GetTok ( szParams , " " , 4 );
	
	if ( !DoesPlayerHaveVehicleKeys ( pPlayer , pPlayer.Vehicle ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't change this vehicle's colour!" );
		
		return false;
	
	}
	
	if ( !IsNum ( szColourIDParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The colour ID must be 1 or 2 !" );
		
		return false;
	
	}
	
	if ( !IsValidVehicleColourIndex ( szColourIDParam.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The colour ID must be 1 or 2 !" );
		
		return false;
	
	}
	
	
	if ( !IsNum ( szRedParam ) || !IsNum ( szGreenParam ) || !IsNum ( szBlueParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The colours must all be numbers!" );
		
		return false;
	
	}	
	
	if ( !IsValidRGBValue ( szRedParam.tointeger ( ) ) || !IsValidRGBValue ( szGreenParam.tointeger ( ) ) || !IsValidRGBValue ( szBlueParam.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The colours must all be between 0 and 255!" );
		
		return false;
	
	}
	
	local pColour = { r = szRedParam.tointeger ( ) , g = szGreenParam.tointeger ( ) , b = szBlueParam.tointeger ( ) };
	
	if ( szColourIDParam.tointeger ( ) == 1 ) {
	
		GetVehicleData ( pPlayer.Vehicle ).pColour1 = pColour;
		pPlayer.Vehicle.RGBColour1 = Colour ( pColour.r , pColour.g , pColour.b );
		
	} else {
	
		GetVehicleData ( pPlayer.Vehicle ).pColour2 = pColour;
		pPlayer.Vehicle.RGBColour2 = Colour ( pColour.r , pColour.g , pColour.b );
		
	}
	
	SendPlayerSuccessMessage ( pPlayer , "You set the colour for vehicle '" + GetVehicleName( pPlayer.Vehicle.Model ) + "' (ID " + pPlayer.Vehicle.ID + ") to " + szRedParam + " red, " + szGreenParam + " green, and " + szBlueParam + " blue" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleFuelCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleHealthCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleModelIDCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local iModelID = 0;
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/VehModelID <Name>" );
		
		return false;
	
	}
	
	iModelID = GetVehicleIDFromName ( szParams );
	
	SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleModelID" ) , szModelID ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function CommonVehHelpCommand ( pPlayer , szCommand , szParams ) {

	SendPlayerAlertMessage ( pPlayer , "To buy a vehicle, visit the dealership in Portland." );
	SendPlayerAlertMessage ( pPlayer , "Use /GPS to find the dealership." );
	SendPlayerAlertMessage ( pPlayer , "Use the train to go to Portland if you don't have a car." );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function GetVehicleData ( pVehicle ) {

	local iVehicleDataIndex = GetCoreTable ( ).VehicleToData [ pVehicle.ID ];
	
	return GetCoreTable ( ).Vehicles [ iVehicleDataIndex ];

}

// -------------------------------------------------------------------------------------------------

function SetVehicleOwner ( pVehicle , pPlayer ) {

	GetVehicleData ( pVehicle ).iOwnerType = GetCoreTable ( ).Utilities.pVehicleOwnerType.Player;
	GetVehicleData ( pVehicle ).iOwnerID = GetPlayerData ( pPlayer ).iDatabaseID;
	
	GetVehicleData ( pVehicle ).iBuyPrice = 0;
	GetVehicleData ( pVehicle ).iRentPrice = 0;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function SetVehicleUnowned ( pVehicle ) {

	GetVehicleData ( pVehicle ).iOwnerType = GetCoreTable ( ).Utilities.pVehicleOwnerType.None;
	GetVehicleData ( pVehicle ).iOwnerID = 0;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function GetVehicleDataSlotByDatabaseID ( iDatabaseID ) {

	foreach ( ii , iv in GetCoreTable ( ).Vehicles ) {
	
		if ( iv.iDatabaseID == iDatabaseID ) {
		
			return ii;
		
		}
	
	}

}

// -------------------------------------------------------------------------------------------------

function IsValidVehicleColourIndex ( iVehicleColourIndex ) {

	if ( iVehicleColourIndex == 1 || iVehicleColourIndex == 2 ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function IsValidVehicleModel ( iModelID ) {

	if ( iModelID < 90 && iModelID > 150 ) {
	
		return false;
	
	}
	
	if ( iModelID == 140 || iModelID == 147 || iModelID == 140 || iModelID == 141 ) {
	
		return false;
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function VehicleSpawnLockCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Toggles a vehicle spawn lock on or off" , [ "VehSpawnLock" ] , "" );
		
		return false;
	
	}
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( GetVehicleData ( pPlayer.Vehicle ).bSpawnLock ) {
	
		GetVehicleData ( pPlayer.Vehicle ).bSpawnLock = false;
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle.Model ) + " is not locked in the old spawn position anymore." );
	
	} else {
	
		GetVehicleData ( pPlayer.Vehicle ).bSpawnLock = true;
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleName ( pPlayer.Vehicle.Model ) + " is now locked in this position for respawn." );	
		
		GetVehicleData ( pPlayer.Vehicle ).pPosition = pPlayer.Vehicle.Pos;
		GetVehicleData ( pPlayer.Vehicle ).fAngle = pPlayer.Vehicle.Angle;
		
		pPlayer.Vehicle.SpawnPos = pPlayer.Vehicle.Pos;
		pPlayer.Vehicle.SpawnAngle = pPlayer.Vehicle.Angle;
		
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleOwnerName ( pVehicle ) {

	switch ( GetVehicleData ( pVehicle ).iOwnerType ) {
	
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.None:
			return "None";
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Player:
			return GetAccountDataByDatabaseID ( GetVehicleData ( pVehicle ).iOwnerID ).szName;
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Clan:
			return GetClanDataByDatabaseID ( GetVehicleData ( pVehicle ).iOwnerID ).szName;
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Job:
			return GetCoreTable ( ).Jobs [ GetVehicleData ( pVehicle ).iOwnerID ].szName;
			
		default:
			return "Unknown";
	}

}

// -------------------------------------------------------------------------------------------------

function GetVehicleOwnerTypeName ( pVehicle ) {

	switch ( GetVehicleData ( pVehicle ).iOwnerType ) {
	
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.None:
			return "None";
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Player:
			return "Player";
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Clan:
			return "Clan";
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Job:
			return "Job";
			
		default:
			return "Unknown";
	}
	
	return "Unknown";

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Vehicle]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
