// NAME: Moderation.nut
// DESC: Handles anything related to server moderation. Commands and information for server staff.

// -------------------------------------------------------------------------------------------------

function AddModerationCommandHandlers ( ) {

	AddCommandHandler ( "Kick" , KickPlayerCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "Ban" , BanPlayerCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "TempBan" , TempBanPlayerCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "Mute" , MutePlayerCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "Unmute" , UnmutePlayerCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "Freeze" , FreezePlayerCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "Unfreeze" , UnfreezePlayerCommand , GetStaffFlagValue ( "BasicModeration" ) );
	
	AddCommandHandler ( "Goto" , GotoPlayerCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "GetHere" , GetPlayerToMeCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "GotoVeh" , GotoVehicleCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "GetVeh" , GetVehicleCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "GotoHouse" , GotoHouseCommand , GetStaffFlagValue ( "BasicModeration" ) );
	
	AddCommandHandler ( "Report" , ForumStaffReportCommand , GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Reports" , ListAllStaffReportsCommand , GetStaffFlagValue ( "BasicModeration" ) );
	
	AddCommandHandler ( "ResetReport" , ResetStaffReportCommand , GetStaffFlagValue ( "ManageServer" ) | GetStaffFlagValue ( "ManageAdmins" ) | GetStaffFlagValue ( "Scripter" ) );
	AddCommandHandler ( "AcceptReport" , AcceptStaffReportCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "DenyReport" , DenyStaffReportCommand , GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "ForumReport" , ForumStaffReportCommand , GetStaffFlagValue ( "BasicModeration" ) );
	
	AddCommandHandler ( "GiveStaffFlag" , GivePlayerStaffFlagCommand , GetStaffFlagValue ( "ManageAdmins" ) );
	AddCommandHandler ( "TakeStaffFlag" , GivePlayerStaffFlagCommand , GetStaffFlagValue ( "ManageAdmins" ) );
	AddCommandHandler ( "StaffFlags" , ListAllStaffFlagsCommand , GetStaffFlagValue ( "ManageAdmins" ) );
	
	AddCommandHandler ( "SetSkin" , SetPlayerSkinCommand , GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "GiveMoney" , GivePlayerMoneyCommand , GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "GiveGun" , GivePlayerWeaponCommand , GetStaffFlagValue ( "ManagePlayerStats" ) );
	
	AddCommandHandler ( "SaveAll" , SaveServerDataCommand , GetStaffFlagValue ( "ManageServer" ) );
	
	AddCommandHandler ( "InVeh" , SaveServerDataCommand , GetStaffFlagValue ( "BasicModeration" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function BanPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Bans a player from the server" , [ "Ban" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Ban <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	SendAdminMessageToAll ( pTarget.Name + " has been banned by " + pPlayer.Name );
	
	BanPlayer ( pTarget , BANTYPE_LUID );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AdminChatCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Talks on admin chat" , [ "SC" , "StaffChat" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/StaffChat <Message>" );
		
		return false;
	
	}
	
	SendMessageToAdmins ( GetHexColour ( "MediumRed" ) + "(Staff Chat) " + GetHexColour ( "MediumGrey" ) + "<" + GetPlayerData ( pPlayer ).szStaffTitle + "> " + GetHexColour ( "LightGrey" ) + pPlayer.Name + ": " + GetHexColour ( "White" ) + szMessage );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TempBanPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Temporarily bans a player from the server" , [ "TempBan" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/TempBan <Player Name/ID> <Time in Hours>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	SendAdminMessageToAll ( pTarget.Name + " has been temp-banned by " + pPlayer.Name );
	
	BanPlayer ( pTarget , BANTYPE_LUID );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function KickPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Kicks a player from the server" , [ "Kick" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Kick <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	SendAdminMessageToAll ( pTarget.Name + " has been kicked by " + pPlayer.Name );
	
	KickPlayer ( pTarget );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function MutePlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Mutes a player. Keeps them from using any chat." , [ "Mute" , "MutePlayer" ] , "This also blocks chat-related commands (ME, DO, etc)" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Mute <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	SendAdminMessageToAll ( pTarget.Name + " has been muted by " + pPlayer.Name );
	
	GetPlayerData ( pTarget ).bMuted = true;
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function UnmutePlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Unmutes a player so they can use chat again." , [ "Unmute" , "UnmutePlayer" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Unmute <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	SendAdminMessageToAll ( pTarget.Name + " has been un-muted by " + pPlayer.Name );
	
	GetPlayerData ( pTarget ).bMuted = false;
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function FreezePlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Freezes a player so they can't move." , [ "Freeze" , "FreezePlayer" ] , "They can still look around with their mouse." );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Freeze <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	SendAdminMessageToAll ( pTarget.Name + " has been frozen by " + pPlayer.Name );
	
	GetPlayerData ( pTarget ).bFrozen = true;
		
	pTarget.Frozen = true;
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function UnfreezePlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Unfreezes a player so they can move again." , [ "Unfreeze" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Unfreeze <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	SendAdminMessageToAll ( pTarget.Name + " has been un-frozen by " + pPlayer.Name );
	
	GetPlayerData ( pTarget ).bFrozen = false;
		
	pTarget.Frozen = false;
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GotoPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Teleports you to a player" , [ "Goto" , "GotoPlayer" ] , "You can provide offset X, Y, and Z." );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Goto <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( pTarget.Vehicle ) {
	
		pPlayer.Pos = GetVectorAboveVector ( pTarget.Pos , 3.0 );
	
	} else {
	
		pPlayer.Pos = GetVectorInFrontVector ( pTarget.Pos , pTarget.Angle , 3.0 );
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "You have been teleported to player '" + pTarget.Name + "' (ID " + pTarget.ID + ")" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerToMeCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Teleports a player to you" , [ "GetHere" , "BringPlayer" ] , "You can provide offset X, Y, and Z." );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/GetHere <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( pPlayer.Vehicle ) {
	
		pTarget.Pos = GetVectorAboveVector ( pPlayer.Pos , 3.0 );
	
	} else {
	
		pTarget.Pos = GetVectorInFrontVector ( pPlayer.Pos , pPlayer.Angle , 3.0 );
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "You have been teleported '" + pTarget.Name + "' (ID " + pTarget.ID + ") to you." );
	SendPlayerSuccessMessage ( pTarget , "You have been teleported to '" + pPlayer.Name + "' (ID " + pPlayer.ID + ")" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerVehicleInfoCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Gets info for the vehicle a player is driving" , [ "InVeh" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/InVeh <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( pTarget.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is not in a vehicle!" );
		
		return false;
	
	}
	
	MessagePlayer ( "== VEHICLE INFO ======================" );
	MessagePlayer ( "- Owner: " + GetVehicleOwnerTypeName ( pTarget.Vehicle ) + " " + GetVehicleOwnerName ( pTarget.Vehicle ) + ", Seat: " + pTarget.VehicleSeat , pPlayer , GetRGBColour ( "White" ) );
	MessagePlayer ( "- Locked: " + GetYesNoBoolText ( GetVehicleData ( pTarget.Vehicle ).bLocked ) + ", Engine: " + GetOnOffBoolText ( GetVehicleData ( pTarget.Vehicle ).bEngineState ) , pPlayer , GetRGBColour ( "White" ) );
	MessagePlayer ( "- Database ID: " + GetVehicleData ( pTarget.Vehicle ).iDatabaseID + ", Type: " + GetVehicleName ( pTarget.Vehicle.Model ) , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GotoVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Teleports you to a vehicle." , [ "GotoVeh" ] , "You can provide offset X, Y, and Z." );
		
		return false;
	
	}

	if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/GotoVeh <Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	szParams = szParams.tointeger ( );
	
	if ( !FindVehicle ( szParams ) ) {
	
		
		SendPlayerErrorMessage ( pPlayer , "That vehicle does not exist!" );
		
		return false;
	
	}
	
	local pVehicle = FindVehicle ( szParams );
	
	pPlayer.Pos = GetVectorAboveVector ( pVehicle.Pos , 3.0 );
	
	SendPlayerSuccessMessage ( pPlayer , "You have been teleported to vehicle '" + GetVehicleName( pVehicle.Model ) + "' (ID " + pVehicle.ID + ")" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleDatabaseIDCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Gets the database ID of a vehicle" , [ "VehDBID" ] , "" );
		
		return false;
	
	}

	if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/VehDBID <Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	szParams = szParams.tointeger ( );
	
	if ( !FindVehicle ( szParams ) ) {
		
		SendPlayerErrorMessage ( pPlayer , "That vehicle does not exist!" );
		
		return false;
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "The database ID for '" + GetVehicleName( pVehicle.Model ) + "' (ID " + pVehicle.ID + ") is " + GetVehicleData ( pVehicle ).iDatabaseID );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function RespawnVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns a vehicle" , [ "RespawnVeh" ] , "" );
		
		return false;
	
	}

	if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/RespawnVeh <Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	szParams = szParams.tointeger ( );
	
	if ( !FindVehicle ( szParams ) ) {
		
		SendPlayerErrorMessage ( pPlayer , "That vehicle does not exist!" );
		
		return false;
	
	}
	
	local pColour1 = GetVehicleData ( pVehicle ).pColour1;
	local pColour2 = GetVehicleData ( pVehicle ).pColour2;
	
	pVehicle.Respawn ( );
	pVehicle.RGBColour1 = Colour ( pColour1.r , pColour1.g , pColour1.b );
	pVehicle.RGBColour2 = Colour ( pColour2.r , pColour2.g , pColour2.b );
	pVehicle.Locked = GetVehicleData ( pVehicle ).bLocked;
	
	SendPlayerSuccessMessage ( pPlayer , "The '" + GetVehicleName( pVehicle.Model ) + "' (ID " + pVehicle.ID + ") has been respawned!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Teleports a vehicle to you." , [ "GetVeh" ] , "You can provide offset X, Y, and Z." );
		
		return false;
	
	}

	if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/GotoVeh <Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	szParams = szParams.tointeger ( );
	
	if ( !FindVehicle ( szParams ) ) {
	
		
		SendPlayerErrorMessage ( pPlayer , "That vehicle does not exist!" );
		
		return false;
	
	}
	
	local pVehicle = FindVehicle ( szParams );
	
	pVehicle.Pos = GetVectorInFrontOfPlayer ( pPlayer , 10.0 );
	pVehicle.Angle = pPlayer.Angle;
	
	SendPlayerSuccessMessage ( pPlayer , "You have been teleported vehicle '" + GetVehicleName( pVehicle.Model ) + "' (ID " + pVehicle.ID + ") to you." );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerStaffFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Gives a staff flag to a player" , [ "GiveStaffFlag" ] , "" );

		return false;

	}

	local pTarget;
	local szFlagName;

	if ( !szParams ) {

		SendPlayerSyntaxMessage ( pPlayer , "/GiveStaffFlag <Player Name/ID> <Staff Flag Name>" );
		SendPlayerInfoMessage ( pPlayer , "Use /StaffFlags for a list of staff flags." );

		return false;

	}

	if ( NumTok ( szParams , " " ) != 2 ) {

		SendPlayerSyntaxMessage ( pPlayer , "/GiveStaffFlag <Player Name/ID> <Staff Flag Name>" );
		SendPlayerInfoMessage ( pPlayer , "Use /StaffFlags for a list of staff flags." );
		
		return false;

	}

	pTarget = FindPlayer ( GetTok ( szParams , " " , 1 ) );
	szFlagName = GetTok ( szParams , " " , 2 );

	if ( !pTarget ) {

		SendPlayerErrorMessage ( pPlayer , "There is no player that matches '" + szFlagName + "'!" );

		return false;

	}

	if ( !( szFlagName in GetRootTable ( ).BitFlags.StaffFlags ) ) {

		SendPlayerErrorMessage ( pPlayer , "There is no staff flag called '" + szFlagName + "'!" );
		SendPlayerInfoMessage ( pPlayer , "Use /StaffFlags for a list of staff flags." );

		return false;

	}

	if ( szFlagName == "Scripter" ) {

		if ( !DoesPlayerHaveStaffFlag ( pPlayer , "Scripter" ) ) {
		   
		   SendPlayerErrorMessage ( pPlayer , "You can't give " + pTarget.Name + " the 'Scripter' staff flag!" );

		   return false;

		}

	}	

	if ( DoesPlayerHaveStaffFlag ( pTarget , "Scripter" ) ) {
	
		if ( !DoesPlayerHaveStaffFlag ( pPlayer , "Scripter" ) ) {
		   
		   SendPlayerErrorMessage ( pPlayer , "You can't modify " + pTarget.Name + "'s flags!" );

		   return false;
		   
		}
		

		return false;

	}	

	if ( DoesPlayerHaveStaffFlag ( pPlayer , szFlagName ) ) {

		SendPlayerErrorMessage ( pPlayer , pTarget.Name + " already has the '" + szFlagName + "' staff flag!" );

		return false;

	}

	SendPlayerSuccessMessage ( pPlayer , "You have given " + pTarget.Name + " the '" + szFlagName + "' staff flag." );
	SendPlayerAlertMessage ( pTarget , pPlayer.Name + " has given you the '" + szFlagName + "' staff flag." );

	AddStaffPermission ( pPlayer , szStaffFlag );

	return true;

}

// -------------------------------------------------------------------------------------------------

function TakePlayerStaffFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Takes a staff flag from a player" , [ "TakeStaffFlag" ] , "" );

		return false;

	}

	local pTarget;
	local szFlagName;

	if ( !szParams ) {

		SendPlayerSyntaxMessage ( pPlayer , "/TakeStaffFlag <Player Name/ID> <Staff Flag Name>" );
		SendPlayerInfoMessage ( pPlayer , "Use /StaffFlags for a list of all staff flags." );
		SendPlayerInfoMessage ( pPlayer , "Use /PlayerStaffFlags for a list of the player's staff flags." );

		return false;

	}

	if ( NumTok ( szParams , " " ) != 2 ) {

		SendPlayerSyntaxMessage ( pPlayer , "/TakeStaffFlag <Player Name/ID> <Staff Flag Name>" );
		SendPlayerInfoMessage ( pPlayer , "Use /StaffFlags for a list of all staff flags." );
		SendPlayerInfoMessage ( pPlayer , "Use /PlayerStaffFlags for a list of the player's staff flags." );
		
		return false;

	}

	pTarget = FindPlayer ( GetTok ( szParams , " " , 1 ) );
	szFlagName = GetTok ( szParams , " " , 2 );

	if ( !pTarget ) {

		SendPlayerErrorMessage ( pPlayer , "There is no player that matches '" + szFlagName + "'!" );

		return false;

	}

	if ( !( szFlagName in GetRootTable ( ).BitFlags.StaffFlags ) ) {

		SendPlayerErrorMessage ( pPlayer , "There is no staff flag called '" + szFlagName + "'!" );
		SendPlayerInfoMessage ( pPlayer , "Use /StaffFlags for a list of staff flags." );

		return false;

	}

	if ( szFlagName == "Scripter" ) {

		if ( !DoesPlayerHaveStaffFlag ( pPlayer , "Scripter" ) ) {
		   
		   SendPlayerErrorMessage ( pPlayer , "You can't take " + pTarget.Name + " the 'Scripter' staff flag!" );

		   return false;

		}

	}

	if ( !DoesPlayerHaveStaffFlag ( pPlayer , szFlagName ) ) {

		SendPlayerErrorMessage ( pPlayer , pTarget.Name + " doesn't have the '" + szFlagName + "' staff flag!" );
		SendPlayerInfoMessage ( pPlayer , "Use /PlayerStaffFlags for a list of the player's staff flags." );

		return false;

	}

	if ( DoesPlayerHaveStaffFlag ( pTarget , "Scripter" ) ) {
	
		if ( !DoesPlayerHaveStaffFlag ( pPlayer , "Scripter" ) ) {
		   
		   SendPlayerErrorMessage ( pPlayer , "You can't modify " + pTarget.Name + "'s flags!" );

		   return false;
		   
		}
		

		return false;

	}

	SendPlayerSuccessMessage ( pPlayer , "You have taken the '" + szFlagName + "' staff flag from " + pTarget.Name );
	SendPlayerAlertMessage ( pTarget , pPlayer.Name + " has taken the '" + szFlagName + "' staff flag away from you." );

	RemoveStaffPermission ( pPlayer , szStaffFlag );

	return true;

}

// -------------------------------------------------------------------------------------------------

function ListAllStaffFlagsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Shows a list of all staff flags." , [ "StaffFlags" ] , "" );

		return false;

	}
	
	foreach ( ii , iv in GetCoreTable ( ).BitFlags.StaffFlags ) {
	
		if ( HasBitFlag ( pPlayerData.StaffFlags , iv ) ) {
		
			SendPlayerNormalMessage ( pPlayer , GetCoreTable ( ).Colours.Hex.Lime + ii );
		
		} else {
		
			SendPlayerNormalMessage ( pPlayer , GetCoreTable ( ).Colours.Hex.BrightRed + ii );
		
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SubmitStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Reports a player or message to admins" , [ "Report" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Report <Message>" );
		
		return false;
	
	}
	
	if ( !CanPlayerSubmitStaffReport ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You cannot submit a report right now!" );
		
		return false;
	
	}
	
	SubmitStaffReport ( pPlayer , szParams );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ListAllStaffReportsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Shows all unhandled staff reports" , [ "Reports" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Reports" );
		//SendPlayerNormalMessage ( pPlayer , "Leaving the extra part out will show all unhandled reports." );
		
		return false;
	
	}
	
	local pStaffReports = GetAllUnhandledStaffReports ( );
	
	foreach ( ii , iv in pStaffReports ) {
	
		if ( iv.iResponseType == GetCoreTable ( ).Utilities.StaffReportResponse.None ) {
		
			SendPlayerNormalMessage ( pPlayer , "== STAFF REPORTS ===============================" );
			SendPlayerNormalMessage ( iv.iReportID + ": (From " + iv.szReporterName + ") " + iv.szMessage + " (sent " + GetTimeDifferenceDisplay ( time ( ) , iv.iTime ) + " ago)" );
			SendPlayerNormalMessage ( pPlayer , "================================================" );
		
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AcceptStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Accepts a report submitted by a player" , [ "AcceptReport" , "AR" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/AcceptReport <Report ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The Report ID must be a number!" );
		
		return false;
	
	}
	
	local pStaffReport = GetStaffReportByID ( szParams.tointeger ( ) );
	
	if ( !pStaffReport ) {
		
		SendPlayerErrorMessage ( pPlayer , "There is no report with that ID!" );
		
		return false;
		
	}
	
	if ( IsStaffReportAlreadyHandled ( pPlayer , pStaffReport ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That report is already being handled!" );
		
		if ( DoesPlayerHaveStaffFlag ( pPlayer , "ManageAdmins" ) || DoesPlayerHaveStaffFlag ( pPlayer , "Scripter" ) || DoesPlayerHaveStaffFlag ( pPlayer , "ManageServer" ) ) {
			
			SendPlayerAlertMessage ( pPlayer , "You can reset the report with /ResetReport" );
			
			return false;
		
		}
		
		return false;
	
	}
	
	AcceptStaffReport ( pPlayer , pStaffReport );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function DenyStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Denies a report submitted by a player" , [ "DenyReport" , "DR" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/DenyReport <Report ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The Report ID must be a number!" );
		
		return false;
	
	}
	
	local pStaffReport = GetStaffReportByID ( szParams.tointeger ( ) );
	
	if ( !pStaffReport ) {
		
		SendPlayerErrorMessage ( pPlayer , "There is no report with that ID!" );
		
		return false;
		
	}
	
	if ( IsStaffReportAlreadyHandled ( pPlayer , pStaffReport ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That report is already handled!" );
		
		if ( DoesPlayerHaveStaffFlag ( pPlayer , "ManageAdmins" ) || DoesPlayerHaveStaffFlag ( pPlayer , "Scripter" ) || DoesPlayerHaveStaffFlag ( pPlayer , "ManageServer" ) ) {
			
			SendPlayerAlertMessage ( pPlayer , "You can reset the report with /ResetReport" );
			
			return false;
		
		}
		
		return false;
	
	}
	
	DenyStaffReport ( pPlayer , pStaffReport );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ForumStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Sets a report as needing to be put on forum" , [ "ForumReport" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/ForumReport <Report ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The Report ID must be a number!" );
		
		return false;
	
	}
	
	local pStaffReport = GetStaffReportByID ( szParams.tointeger ( ) );
	
	if ( !pStaffReport ) {
		
		SendPlayerErrorMessage ( pPlayer , "There is no report with that ID!" );
		
		return false;
		
	}
	
	if ( IsStaffReportAlreadyHandled ( pPlayer , pStaffReport ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That report is already handled!" );
		
		if ( DoesPlayerHaveStaffFlag ( pPlayer , "ManageAdmins" ) || DoesPlayerHaveStaffFlag ( pPlayer , "Scripter" ) || DoesPlayerHaveStaffFlag ( pPlayer , "ManageServer" ) ) {
			
			SendPlayerAlertMessage ( pPlayer , "You can reset the report with /ResetReport" );
			
			return false;
		
		}
		
		return false;
	
	}
	
	SetAsForumStaffReport ( pPlayer , pStaffReport );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ResetStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Resets a handled staff report to handle it again" , [ "ResetReport" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/ResetReport <Report ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The Report ID must be a number!" );
		
		return false;
	
	}
	
	local pStaffReport = GetStaffReportByID ( szParams.tointeger ( ) );
	
	if ( !pStaffReport ) {
		
		SendPlayerErrorMessage ( pPlayer , "There is no report with that ID!" );
		
		return false;
		
	}
	
	if ( !IsStaffReportAlreadyHandled ( pPlayer , pStaffReport ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That report has not been handled! No need to reset it!" );
		
		return false;
	
	}
	
	OverrideStaffReport ( pPlayer , pStaffReport );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SubmitStaffReport ( pPlayer , szMessage ) {

	local pStaffReport = GetCoreTable ( ).Classes.StaffReports ( );
	
	pStaffReport.iTime = time ( );
	pStaffReport.szReporterName = pPlayer.Name;
	pStaffReport.szMessage = szMessage;

	GetCoreTable ( ).StaffReports.push ( pStaffReport );

	return true;

}

// -------------------------------------------------------------------------------------------------

function AcceptStaffReport ( pPlayer , pStaffReport ) {

	pStaffReport.iResponseType = GetCoreTable ( ).Utilities.StaffReportResponse.Accepted;
	
	pStaffReport.iResponseTime = time ( );
	pStaffReport.pResponseAdmin = pPlayer;
	
	SendPlayerSuccessMessage ( pPlayer , "You have accepted " + pStaffReport.pReporter.Name + "'s report (ID: " + pReportData.iReportID + ")" );
	SendPlayerAlertMessage ( pStaffReport.pReporter , pPlayer.Name + " has accepted your report." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function DenyStaffReport ( pPlayer , pStaffReport ) {

	pStaffReport.iResponseType = GetCoreTable ( ).Utilities.StaffReportResponse.Denied;
	
	pStaffReport.iResponseTime = time ( );
	pStaffReport.pResponseAdmin = pPlayer;
	
	SendPlayerSuccessMessage ( pPlayer , "You have denied " + pStaffReport.pReporter.Name + "'s report (ID: " + pReportData.iReportID + ")" );
	SendPlayerAlertMessage ( pStaffReport.pReporter , pPlayer.Name + " has denied your report." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function SetAsForumStaffReport ( pPlayer , pStaffReport ) {

	pStaffReport.iResponseType = GetCoreTable ( ).Utilities.StaffReportResponse.Denied;
	
	pStaffReport.iResponseTime = time ( );
	pStaffReport.pResponseAdmin = pPlayer;
	
	SendPlayerSuccessMessage ( pPlayer , "You have set " + pStaffReport.pReporter.Name + "'s as needing to be posted on forum. (ID: " + pReportData.iReportID + ")" );
	SendPlayerAlertMessage ( pStaffReport.pReporter , pPlayer.Name + " has set your report as needing to post on the forum." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function ResetStaffReport ( pPlayer , pStaffReport ) {

	pStaffReport.iResponseType = GetCoreTable ( ).Utilities.StaffReportResponse.Denied;
	
	pStaffReport.iResponseTime = time ( );
	pStaffReport.pResponseAdmin = pPlayer;
	
	SendPlayerSuccessMessage ( pPlayer , "You have reset " + pStaffReport.pReporter.Name + "'s report (ID: " + pReportData.iReportID + ")" );
	SendPlayerAlertMessage ( pPlayer , "The report has now been set as unhandled." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function GetStaffReportByID ( iStaffReportID ) {

	if ( !( iStaffReportID in GetAllStaffReports ( ) ) ) {
	
		return GetAllStaffReports ( ) [ iStaffReportID ]; 
	
	}

	return false;

}

// -------------------------------------------------------------------------------------------------

function GetAllStaffReports ( ) {

	return GetCoreTable ( ).StaffReports;

}

// -------------------------------------------------------------------------------------------------

function GetAllUnhandledStaffReports ( ) {

	local pTempReports = [ ];

	foreach ( ii , iv in GetAllStaffReports ( ) ) {
	
		if ( iv.iResponseType == GetCoreTable ( ).Utilities.StaffReportResponse.None ) {
		
			pTempReports.push ( iv );
		
		}
	
	}
	
	return pTempReports;

}

// -------------------------------------------------------------------------------------------------

function SetPlayerSkinCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Sets a player's skin" , [ "SetSkin" ] , "" );

		return false;

	}

	local szTargetParam = false;
	local szSkinParam = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/SetSkin <Player Name/ID> <Skin ID>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/setskin <Player Name/ID> <Skin ID>" );
		
		return false;
	
	}	
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	szSkinParam = GetTok ( szParams , " " , 2 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is not connected!" );
		
		return false;
	
	}
	
	if ( !IsNum ( szSkinParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The skin ID must be a number!" );
		
		return false;	
	
	}
	
	szSkinParam = szSkinParam.tointeger ( );
	
	if ( !IsValidSkinID ( szSkinParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That skin ID is invalid!" );
		
		return false;	
	
	}
	
	local pTarget = FindPlayer ( szTargetParam );
	
	SendPlayerSuccessMessage ( pPlayer , "You set " + pTarget.Name + "'s skin to ID " + szSkinParam );
	SendPlayerAlertMessage ( pTarget , pTarget.Name + " has set your skin to ID " + szSkinParam );
	
	SetPlayerSkin ( pTarget , szSkinParam );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerMoneyCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Gives a player money" , [ "GiveMoney" ] , "" );

		return false;

	}

	local szTargetParam = false;
	local szMoneyParam = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/GiveMoney <Player Name/ID> <Amount>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/GiveMoney <Player Name/ID> <Amount>" );
		
		return false;
	
	}	
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	szMoneyParam = GetTok ( szParams , " " , 2 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is not connected!" );
		
		return false;
	
	}
	
	if ( !IsNum ( szMoneyParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The amount of money must be a number!" );
		
		return false;	
	
	}
	
	szMoneyParam = szMoneyParam.tointeger ( );
	
	if ( szMoneyParam > 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The amount must be more than 0!" );
		
		return false;	
	
	}
	
	local pTarget = FindPlayer ( szTargetParam );
	
	SendPlayerSuccessMessage ( pPlayer , "You gave " + pTarget.Name + " $" + szMoneyParam );
	SendPlayerAlertMessage ( pTarget , pTarget.Name + " has given you $" + szMoneyParam );
	
	GivePlayerMoney ( pTarget , szMoneyParam );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerWeaponCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Gives a player a weapon" , [ "GiveGun" , "GiveWeapon" ] , "" );

		return false;

	}

	local szTargetParam = false;
	local szWeaponParam = false;
	local szAmmoParam = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/GiveGun <Player Name/ID> <Weapon ID> <Ammo>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 3 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/GiveGun <Player Name/ID> <Weapon ID> <Ammo>" );
		
		return false;
	
	}	
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	szWeaponParam = GetTok ( szParams , " " , 2 );
	szAmmoParam = GetTok ( szParams , " " , 3 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is not connected!" );
		
		return false;
	
	}
	
	if ( !IsNum ( szWeaponParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be a number!" );
		
		return false;	
	
	}
	
	szWeaponParam = szWeaponParam.tointeger ( );
	
	if ( !IsNum ( szAmmoParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The ammo amount must be a number!" );
		
		return false;	
	
	}	
	
	szAmmoParam = szAmmoParam.tointeger ( );
	
	if ( szWeaponParam > 0 && szWeaponParam < 12 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be between 1 and 11!" );
		
		return false;	
	
	}
	
	if ( szAmmoParam > 0 && szAmmoParam < 99999 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be between 1 and 99999!" );
		
		return false;	
	
	}	
	
	local pTarget = FindPlayer ( szTargetParam );
	
	SendPlayerSuccessMessage ( pPlayer , "You gave " + pTarget.Name + " $" + szMoneyParam );
	SendPlayerAlertMessage ( pTarget , pTarget.Name + " has given you $" + szMoneyParam );
	
	GivePlayerWeapon ( pTarget , szWeaponParam , szAmmoParam );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function CanPlayerSubmitStaffReport ( pPlayer ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function SaveServerDataCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	SendAdminMessageToAll ( pPlayer , "All server data is being saved. You might experience some lag!" );

	SaveServerDataToDatabase ( );
	
	SendAdminMessageToAll ( pPlayer , "All server data has been saved! The lag should be gone now!" );
	
	SendPlayerSuccessMessage ( pPlayer , "All server data has been saved!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SaveServerDataToDatabase ( ) {

	print ( "- Beginning server data saving ..." );
	
	SaveAllVehiclesToDatabase ( );
	
	print ( "- Saved vehicles to database" );
	
	SaveAllPlayersToDatabase ( );
	
	print ( "- Saved players to database" );
	
	SaveAllClansToDatabase ( );
	
	print ( "- Saved clans to database" );
	
	SaveAllBusinessesToDatabase ( );
	
	print ( "- Saved businesses to database" );	
	
	SaveAllHousesToDatabase ( );
	
	print ( "- Saved houses to database" );
	
	return;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Moderation]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------