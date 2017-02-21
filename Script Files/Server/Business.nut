function AddBusinessCommandHandlers ( ) {

	AddCommandHandler ( "AddBiz" , CreateBusinessCommand , GetCoreTable ( ).BitFlags.StaffFlags.ManageBusinesses );
	AddCommandHandler ( "DelBiz" , DeleteBusinessCommand , GetCoreTable ( ).BitFlags.StaffFlags.ManageBusinesses );
	AddCommandHandler ( "SetBizOwner" , SetBusinessOwnerCommand , GetCoreTable ( ).BitFlags.StaffFlags.ManageBusinesses );
	AddCommandHandler ( "SetBizName" , SetBusinessNameCommand , GetCoreTable ( ).BitFlags.StaffFlags.ManageBusinesses );
	AddCommandHandler ( "LockBiz" , LockBusinessCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
	AddCommandHandler ( "UnlockBiz" , UnlockBusinessCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
	AddCommandHandler ( "GiveBizFlag" , GiveBusinessFlagCommand , GetCoreTable ( ).BitFlags.StaffFlags.ManageBusinesses );
	AddCommandHandler ( "TakeBizFlag" , TakeBusinessFlagCommand , GetCoreTable ( ).BitFlags.StaffFlags.ManageBusinesses );
	AddCommandHandler ( "GiveBizSellFlag" , GiveBusinessSellFlagCommand , GetCoreTable ( ).BitFlags.StaffFlags.ManageBusinesses );
	AddCommandHandler ( "TakeBizSellFlag" , TakeBusinessSellFlagCommand , GetCoreTable ( ).BitFlags.StaffFlags.ManageBusinesses );

}

// -------------------------------------------------------------------------------------------------

function CreateBusinessPickups ( ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function CreateBusinessCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Creates a new business" , [ "CreateBiz" , "AddBiz" ] , "Must be accepted by an admin." );
        
        return false;
    
    }
	
	
	
	return true;

}

// -------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Business]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------