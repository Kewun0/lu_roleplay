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
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function BanPlayerCommand ( pPlayer , szCommand , szParams ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Bans a player from the server" , [ "ban" ] , "You must have the BasicModeration staff flag." );
        
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
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Temporarily bans a player from the server" , [ "tempban" ] , "You must have the BasicModeration staff flag." );
        
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
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Kicks a player from the server" , [ "kick" ] , "You must have the BasicModeration staff flag." );
        
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

    GiveStaffFlag ( pPlayer , szStaffFlag );

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

    TakeStaffFlag ( pPlayer , szStaffFlag );

    return true;

}

// -------------------------------------------------------------------------------------------------

function ListAllStaffFlagsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Moderation]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
