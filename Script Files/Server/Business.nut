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

function SaveAllBusinessesToDatabase ( ) {

	return true;

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
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function BuyFromBusinessCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Buys an item from a business" , [ "Buy" ] , "" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetBusinessOwnerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Changes the owner of a business" , [ "BizOwner" ] , "" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetBusinessNameCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Changes the name of a business" , [ "BizName" ] , "" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function LockBusinessCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Locks a business" , [ "LockBiz" ] , "Players can't buy from a locked business." );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function UnlockBizCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Unlocks a business" , [ "UnlockBiz" ] , "" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GiveBusinessFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Gives a business a business flag" , [ "GiveBizFlag" ] , "For a list, use /bizflags" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TakeBusinessFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Takes a business flag from a business" , [ "TakeBizFlag" ] , "For a list, use /bizflags" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GiveBusinessSellFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Gives a business a business sell flag" , [ "GiveBizSellFlag" ] , "For a list, use /bizsellflags" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TakeBusinessSellFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Takes a business sell flag from a business" , [ "TakeBizSellFlag" ] , "For a list, use /bizsellflags" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Business]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------