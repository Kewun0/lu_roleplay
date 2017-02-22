function SetVehicleOnFire ( pVehicle ) {

	local pFireData = GetCoreTable.Classes.FireData ( );
	local pFire = CreateFire ( GetVectorInFrontOfVehicle ( pVehicle , 1.0 ) , 2 );

	pFireData.pFire = pFire;
	pFireData.iStart = time ( );
	pFireData.iFireType = GetRootTable.Utilities.FireTypes.VehicleFire;
	pFireData.pAttached = pVehicle;

	GetVehicleData ( pVehicle ).bOnFire = true;
	GetVehicleData ( pVehicle ).bAttachedFire = pFire;

	return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Fire]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------