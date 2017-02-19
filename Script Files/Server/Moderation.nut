// NAME: Moderation.nut
// DESC: Handles anything related to server moderation. Commands and information for server staff.

// -- COMMANDS -------------------------------------------------------------------------------------

// - Kick                                   KickPlayerCommand                               BasicModeration
// - Ban                                    BanPlayerCommand                                BasicModeration
// - TempBan                                TempBanPlayerCommand                            BasicModeration
// - Mute                                   MutePlayerCommand                               BasicModeration
// - Unmute                                 UnmutePlayerCommand                             BasicModeration
// - Freeze                                 FreezePlayerCommand                             BasicModeration
// - Unfreeze                               UnfreezePlayerCommand                           BasicModeration
// - Report									SubmitStaffReportCommand						None
// - Reports								ListStaffReportsCommand							BasicModeration
// - AcceptReport							AcceptStaffReportCommand						BasicModeration
// - DenyReport								DenyStaffReportCommand							BasicModeration

// -------------------------------------------------------------------------------------------------

function AddModerationCommandHandlers ( ) {

    AddCommandHandler ( "Kick" , KickPlayerCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    AddCommandHandler ( "Ban" , BanPlayerCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration);
    AddCommandHandler ( "TempBan" , TempBanPlayerCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    AddCommandHandler ( "Mute" , MutePlayerCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    AddCommandHandler ( "Unmute" , UnmutePlayerCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    AddCommandHandler ( "Freeze" , FreezePlayerCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    AddCommandHandler ( "Unfreeze" , UnfreezePlayerCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    
    AddCommandHandler ( "Goto" , GotoPlayerCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    AddCommandHandler ( "GotoVeh" , GotoVehicleCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    AddCommandHandler ( "GotoVeh" , GotoBusinessCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    AddCommandHandler ( "GotoHouse" , GotoHouseCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
	
	AddCommandHandler ( "ResetReport" , ResetStaffReportCommand , GetCoreTable ( ).BitFlags.StaffFlags.ManageServer | GetCoreTable ( ).BitFlags.StaffFlags.ManageAdmins | GetCoreTable ( ).BitFlags.StaffFlags.Scripter );
    AddCommandHandler ( "AcceptReport" , AcceptStaffReportCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
	AddCommandHandler ( "DenyReport" , DenyStaffReportCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
	AddCommandHandler ( "ForumReport" , ForumStaffReportCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
	
    return true;

}

// -------------------------------------------------------------------------------------------------

function BanPlayerCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Bans a player from the server" , [ "Ban" ] , "You must have the BasicModeration staff flag." );
        
        return false;
    
    }

    if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
        
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
    
    SendAllAdminMessage ( pTarget.Name + " has been banned by " + pPlayer.Name );
    
    BanPlayer ( pTarget , BANTYPE_LUID );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function TempBanPlayerCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Temporarily bans a player from the server" , [ "TempBan" ] , "You must have the BasicModeration staff flag." );
        
        return false;
    
    }

    if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
        
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
    
    SendAllAdminMessage ( pTarget.Name + " has been temp-banned by " + pPlayer.Name );
    
    BanPlayer ( pTarget , BANTYPE_LUID );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function KickPlayerCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Kicks a player from the server" , [ "Kick" ] , "You must have the BasicModeration staff flag." );
        
        return false;
    
    }

    if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
        
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
    
    SendAllAdminMessage ( pTarget.Name + " has been kicked by " + pPlayer.Name );
    
    KickPlayer ( pTarget );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function MutePlayerCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Mutes a player. Keeps them from using any chat." , [ "Mute" , "MutePlayer" ] , "This also blocks chat-related commands (ME, DO, etc)" );
        
        return false;
    
    }

    if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
        
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
    
    SendAllAdminMessage ( pTarget.Name + " has been muted by " + pPlayer.Name );
    
    UnitedIslands.Players [ pTarget.ID ].bMuted = true;
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function UnmutePlayerCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Unmutes a player so they can use chat again." , [ "Unmute" , "UnmutePlayer" ] , "" );
        
        return false;
    
    }

    if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
        
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
    
    SendAllAdminMessage ( pTarget.Name + " has been un-muted by " + pPlayer.Name );
    
    UnitedIslands.Players [ pTarget.ID ].bMuted = false;
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function FreezePlayerCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Freezes a player so they can't move." , [ "Freeze" , "FreezePlayer" ] , "They can still look around with their mouse." );
        
        return false;
    
    }
    
    if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
        
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
    
    Message ( UnitedIslands.Colours.Hex.BrightRed + "[ADMIN] " + UnitedIslands.Colours.Hex.White + pTarget.Name + " has been frozen by " + pPlayer.Name );
    
    UnitedIslands.Players [ pTarget.ID ].bFrozen = true;
        
    pTarget.Frozen = true;
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function UnfreezePlayerCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Unfreezes a player so they can move again." , [ "Unfreeze" ] , "" );
        
        return false;
    
    }

    if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
        
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
    
    Message ( UnitedIslands.Colours.Hex.BrightRed + "[ADMIN] " + UnitedIslands.Colours.Hex.White + pTarget.Name + " has been un-frozen by " + pPlayer.Name );
    
    UnitedIslands.Players [ pTarget.ID ].bFrozen = false;
        
    pTarget.Frozen = false;
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GotoPlayerCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Teleports you to a player" , [ "Goto" , "GotoPlayer" ] , "You can provide offset X, Y, and Z." );
        
        return false;
    
    }

    if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
        
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
    
    pPlayer.Pos = GetVectorBehindVector ( pTarget.Pos , pTarget.Angle , 3.0 );
    
    SendPlayerSuccessMessage ( pPlayer , "You have been teleported to player '" + pTarget.Name + "' (ID " + pTarget.ID + ")" );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GotoVehicleCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Teleports you to a vehicle." , [ "GotoVeh" ] , "You can provide offset X, Y, and Z." );
        
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

function SubmitStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

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

function SetAsForumStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

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

// -- THIS GOES LAST

print ( "[Server.Moderation]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
