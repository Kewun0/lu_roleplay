function CreateBitwiseTable ( szTableKeys ) {
	
	local iBitVal = 0;
	local pBitTable = { };
	local iIncVal = 1;
	
	foreach ( ii , iv in szTableKeys ) {
	
		pBitTable [ iv ] <- iBitVal;
		iBitVal = 1 << iIncVal;
		iIncVal++;
		
	}

	return pBitTable;
	
}

// -------------------------------------------------------------------------------------------------

function HasBitFlag ( iCheckThis , iCheckFor ) {
	
	if ( iCheckThis & iCheckFor ) {
	
		return true;
		
	}
	
	return false;
	
}

// -------------------------------------------------------------------------------------------------

function CreateBitwiseTables ( ) {
	
	GetCoreTable ( ).BitFlags.AccountSettings <- CreateBitwiseTable ( [ "None" , "LUIDLogin" , "IPLogin" , "TwoStepAuth" , "WhiteList" , "LoginAlert" ] );
	GetCoreTable ( ).BitFlags.StaffFlags <- CreateBitwiseTable ( [ "None" , "BasicModeration" , "ManagePlayerStats" , "ManageBans" , "ManageVehicles" , "ManageHouses" , "ManageBusinesses" , "ManageClans" , "Scripter" , "ManageServer" , "ManageAdmins" ] );
	GetCoreTable ( ).BitFlags.Licenses <- CreateBitwiseTable ( [ "None" , "DrivingLicense" , "BoatingLicense" , "PilotsLicense" , "TaxiLicense" , "WeaponsLicense" ] );	
	GetCoreTable ( ).BitFlags.ClanFlags <- CreateBitwiseTable ( [ "None" , "AddMember" , "RemoveMember" , "ClaimTurf" , "GiveTurf" , "StoreInSafe" , "TakeFromSafe" , "EditTag" , "EditName" , "ManageVehicles" , "ManageTurfs" , "ManageAlliances" , "Owner" ] );
	
	print ( "[ServerStart]: Bitwise tables created" );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function GetStaffFlagValue ( szStaffFlagName ) {

	if ( GetCoreTable ( ) [ "BitFlags" ] [ "StaffFlags" ].rawin ( szStaffFlagName ) ) {
		
		return GetCoreTable ( ) [ "BitFlags" ] [ "StaffFlags" ] [ szStaffFlagName ];
	
	}
	
	return 0;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.BitFlags]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
