

function PoliceArrestCommand ( pPlayer , szCommand , szParams, bShowHelpOnly = false  ) {

	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/arrest <player name/id" );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	if ( !IsPlayerCuffed ( pPTarget ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "MustBeCuffed" ) );
		
		return false;
	
	}
	
	if ( !IsPlayerAtPoliceStation ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "MustBeAtPoliceStation" ) );

		return false;
	
	}
	
	if ( GetDistance ( pPlayer.Pos , pTarget.Pos ) < GetCoreTable ( ).Utilities.fArrestRange ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "MustBeNearSuspect" ) );

		return false;
	
	}
	
	ArrestPlayer ( pTarget );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceCuffCommand ( pPlayer , szCommand , szParams ) {

	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}  

	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	pTarget = FindPlayer ( szParams );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , "Could not find that player!" );
		
		return false;
	
	}
	
	if ( pPlayer.ID == pTarget.ID ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't cuff yourself!" );
	
		return false;
	
	}
	
	if ( GetDistance ( pPlayer.Pos , pTarget.Pos ) > GetCoreTable ( ).Utilities.fCuffRange ) {
	
		SendPlayerErrorMessage ( pPlayer , pTarget.Name + " is too far away!" );
		
		return false;
	
	}
	
	CuffPlayer ( pTarget );
	
	SendPlayerSuccessMessage ( pPlayer , "You have hand-cuffed " + pTarget.Name );
	SendPlayerAlertMessage ( pPlayer , "You have been hand-cuffed by " + pPlayer.Name );

	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceTazerCommand ( pPlayer , szCommand , szParams ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceDutyCommand ( pPlayer , szCommand , szParams ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceEquipmentCommand ( pPlayer , szCommand , szParams ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceMegaphoneCommand ( pPlayer , szCommand , szParams ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceRadioCommand ( pPlayer , szCommand , szParams ) {

	return true;
	
}

// -------------------------------------------------------------------------------------------------

function IsPlayerPoliceOfficer ( pPlayer ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( pPlayerData.iJob == GetCoreTable ( ).Utilities.Jobs.Police ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function ArrestPlayer ( pPlayer ) {
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function CuffPlayer ( pPlayer ) {
	
	ResetPlayerAnimation ( pPlayer );
	
	pPlayer.SetAnim ( 8 );
	
	pPlayer.Frozen = true;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function UncuffPlayer ( pPlayer ) {
	
	ResetPlayerAnimation ( pPlayer );
	
	pPlayer.Frozen = false;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function ToggleTazerCommand ( pPlayer , szCommand , szParams ) {
	
	if ( !DoesPlayerHaveTazer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You do not have a tazer!" );
		SendPlayerInfoMessage ( pPlayer , "You can buy one at an electronics store. Use /GPS to find one." );
		
		return false;
	
	}
	
	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	if ( pPlayerData.bTazerArmed ) {
	
		pPlayer.ClearWeapons ( );
		pPlayer.SetWeapon ( 2 , 1 );
		pPlayerData.bTazerArmed = true;
		
		SendPlayerSuccessfulMessage ( pPlayer , "You have taken out a tazer." );
		
	} else {
	
		pPlayer.ClearWeapons ( );
		GivePlayerSavedWeapons ( );
		pPlayerData.bTazerArmed = false;
		
		SendPlayerSuccessfulMessage ( pPlayer , "You have put away your tazer." );	
	
	}
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Police]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------