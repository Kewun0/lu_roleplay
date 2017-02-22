function AddBusinessCommandHandlers ( ) {

	AddCommandHandler ( "Buy" , BuyFromBusinessCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "AddBiz" , CreateBusinessCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "DelBiz" , DeleteBusinessCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "SetBizOwner" , SetBusinessOwnerCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "SetBizName" , SetBusinessNameCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "LockBiz" , LockBusinessCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "UnlockBiz" , UnlockBusinessCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "GiveBizFlag" , GiveBusinessFlagCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "TakeBizFlag" , TakeBusinessFlagCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "GiveBizSellFlag" , GiveBusinessSellFlagCommand , GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "TakeBizSellFlag" , TakeBusinessSellFlagCommand , GetStaffFlagValue ( "ManageBusinesses" ) );

}

// -------------------------------------------------------------------------------------------------

function CreateBusinessPickups ( ) {

	

	return true;

}

// -------------------------------------------------------------------------------------------------

function BuyFromBusinessPickups ( ) {

	

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