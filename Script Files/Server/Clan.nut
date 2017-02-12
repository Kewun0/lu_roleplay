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
    AddCommandHandler ( "GotoBusiness" , GotoBusinessCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
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

// -- THIS GOES LAST

print ( "[Server.Moderation]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
