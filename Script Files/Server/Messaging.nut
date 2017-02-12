function ShowWelcomeMessage ( pPlayer ) {

    MessagePlayer ( "Welcome to Life in Liberty City RP!" , pPlayer , LURP.Colours.RGB.White );
    MessagePlayer ( "This server is under development, and may restart often for updates." , pPlayer , LURP.Colours.RGB.BrightRed );
    
    MessagePlayer ( " " , pPlayer );
    
    MessagePlayer ( "Please wait while your account is loaded ... " , pPlayer , LURP.Colours.RGB.White );
    
    return;
    
}

// -------------------------------------------------------------------------------------------------

function SendPlayerErrorMessage ( pPlayer , szMessage ) {

    MessagePlayer ( LURP.Colours.ByType.GeneralErrorHeader + GetPlayerLocaleMessage ( pPlayer , "ErrorMessageHeader" ) + ": " + LURP.Colours.ByType.GeneralErrorMessage + szMessage , pPlayer , LURP.Colours.RGB.White );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SendAdminMessageToAll ( pPlayer , szMessage ) {

    Message ( LURP.Colours.ByType.AdminAnnounceHeader + GetPlayerLocaleMessage ( pPlayer , "AdminAnnounceHeader" ) + ": " + LURP.Colours.ByType.AdminAnnounceMessage + szMessage ,LURP.Colours.RGB.White );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerSyntaxMessage ( pPlayer , szMessage ) {

    MessagePlayer ( LURP.Colours.ByType.SyntaxErrorHeader + GetPlayerLocaleMessage ( pPlayer , "SyntaxMessageHeader" ) + ": " + LURP.Colours.ByType.SyntaxErrorMessage + szMessage , pPlayer , LURP.Colours.RGB.White );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerAlertMessage ( pPlayer , szMessage ) {

    MessagePlayer ( LURP.Colours.ByType.GeneralAlertHeader + GetPlayerLocaleMessage ( pPlayer , "AlertMessageHeader" ) + ": " + LURP.Colours.ByType.GeneralAlertMessage + szMessage , pPlayer , LURP.Colours.RGB.White );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerSuccessMessage ( pPlayer , szMessage ) {

    MessagePlayer ( LURP.Colours.ByType.GeneralSuccessHeader + GetPlayerLocaleMessage ( pPlayer , "SuccessMessageHeader" ) + ": " + LURP.Colours.ByType.GeneralSuccessMessage + szMessage , pPlayer , LURP.Colours.RGB.White );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SendIsRegisteredWelcomeOnConnect ( pPlayer ) {
    
    local pPlayerData = LURP.Players [ pPlayer.ID ];
    
    /*
    if ( IsAutoIPLoginEnabled( pPlayerData.iAccountSettings ) {
        
        if ( IsIPAllowedToUseAccount ( pPlayerData , pPlayer.IP ) ) {
            
            MessagePlayer ( "Welcome back, " + pPlayer.Name + ". You have been automatically logged in with your IP!" , pPlayer , LURP.Colours.RGB.Yellow );   
            MessagePlayer ( "Please use left CTRL to join the game." , pPlayer , LURP.Colours.RGB.Yellow ); 
            
            return true;
            
        }
        
    }
    */
    
    if ( pPlayerData.iDatabaseID.tointeger ( ) == 0 ) {
        
        MessagePlayer ( "Oops! It looks like you aren't registered. You'll need to create an account to join the game." , pPlayer , LURP.Colours.RGB.Orange )
        MessagePlayer ( "Please use /register to create your account." , pPlayer , LURP.Colours.RGB.Yellow );
        
    } else {
    
        MessagePlayer ( "Welcome back, " + pPlayer.Name + ". Your account has been loaded. Please use /login." , pPlayer , LURP.Colours.RGB.Yellow );        
    
    }
    
    pPlayerData.bCanUseCommands = true;
    
    return;
    
}

// -------------------------------------------------------------------------------------------------

function AreaTalkCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    local pPlayerData = LURP.Players [ pPlayer.ID ];
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are muted, and cannot speak!" );
        
        return false;
    
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/talk <message>" );
        
        return false;
    
    }

    PlayerAreaTalkMessage ( pPlayer , szParams );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function AreaShoutCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    local pPlayerData = LURP.Players [ pPlayer.ID ];
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are muted, and cannot speak!" );
        
        return false;
    
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/shout <message>" );
        
        return false;
    
    }    

    PlayerAreaShoutMessage ( pPlayer , szParams );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function PrivateMessageCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    local szMessage = "";
    local pReceiver = false;

    local pPlayerData = LURP.Players [ pPlayer.ID ];
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are muted, and cannot speak!" );
        
        return false;
    
    }
    
    if ( ( szParams == "" ) || ( NumTok ( szParams , " " ) < 2 ) ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/pm <name/id> <message>" );
        
        return false;
    
    }
    
    pReceiver = FindPlayer ( GetTok ( szParams , " " , 1 ) );
    
    if ( !pReceiver ) {
    
        SendPlayerErrorMessage ( pPlayer , "That player is not connected!" );
        
        return false;
    
    }
    
    szMessage = GetRemainingString ( szParams , " " , 2 );

    PlayerPrivateMessage ( pPlayer , pReceiver , szMessage );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function PlayerPrivateMessage ( pSender , pReceiver , szMessage ) {

    MessagePlayer ( LURP.Colours.Hex.Lime + "(MSG) " + LURP.Colours.Hex.White + " From " + pSender.Name + ": " LURP.Colours.Hex.LightGrey + szMessage , pReceiver , LURP.Colours.RGB.White );
    MessagePlayer ( LURP.Colours.Hex.Lime + "(MSG) " + LURP.Colours.Hex.White + " To " + pReceiver.Name + ": " LURP.Colours.Hex.LightGrey + szMessage , pSender , LURP.Colours.RGB.White );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerAreaTalkMessage ( pPlayer , szMessage ) {

    if ( !pPlayer.Spawned ) {
    
        return false;
        
    }
    
    foreach ( ii , iv in LURP.Players ) {
        
        if ( GetDistance ( pPlayer.Pos , iv.pPlayer.Pos ) < LURP.Utilities.fAreaTalkRange ) {
    
            MessagePlayer ( LURP.Colours.ByType.AreaTalkHeader + "(Nearby) " + LURP.Colours.ByType.AreaTalkName + pPlayer.Name + ": " + LURP.Colours.ByType.AreaTalkMessage + szMessage , iv.pPlayer );
        
        }
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function PlayerAreaShoutMessage ( pPlayer , szMessage ) {

    if ( !pPlayer.Spawned ) {
    
        return false;
        
    }
    
    foreach ( ii , iv in LURP.Players ) {
        
        if ( GetDistance ( pPlayer.Pos , iv.pPlayer.Pos ) < LURP.Utilities.fAreaShoutRange ) {
    
            MessagePlayer ( LURP.Colours.ByType.AreaShoutHeader + "(Shout) " + LURP.Colours.ByType.AreaShoutName + pPlayer.Name + ": " + LURP.Colours.ByType.AreaShoutMessage + szMessage + "!" , iv.pPlayer );
        
        }
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function SendWelcomeMessage ( pPlayer ) {

    MessagePlayer ( "Welcome to Life in Liberty City RP." , pPlayer , LURP.Colours.RGB.White );
    MessagePlayer ( "This server is still in development, so it may restart often for updates." , pPlayer , LURP.Colours.RGB.BrightRed );
    
    MessagePlayer ( " " , pPlayer , LURP.Colours.RGB.White );
    
    MessagePlayer ( "Please wait while your account is loaded ... " , pPlayer , LURP.Colours.RGB.White );
    
    // MessagePlayer ( "Please remember to speak only english in the main chat." , pPlayer , LURP.Colours.RGB.Orange );
    // MessagePlayer ( "You can use other languages in different chats, such as private messages." , pPlayer , LURP.Colours.RGB.Orange );

    return;

}

// -------------------------------------------------------------------------------------------------

function HelpCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    local pPlayerData = LURP.Players [ pPlayer.ID ];
    local szCategory = "";
    
    if ( !szParams ) {
        
        SendPlayerSyntaxMessage ( pPlayer , "/Help <Category>" );
        MessagePlayer ( LURP.Colours.Hex.White + "Help Categories: " + LURP.Colours.Hex.LightGrey + "Account, Command, Vehicle, Job, Chat, Rules, Website" , LURP.Colours.RGB.White );
        
        return false;
        
    }
    
    szCategory = GetTok ( szParams , " " , 1 );
    
    // == Account Help =============================
    // == Vehicle Help =============================
    // == Job Help =================================
    // == Chat Help ================================
    // == Server Rules =============================
    
    if ( szCategory.tolower ( ) == "account" ) {
        
        MessagePlayer ( "== Account Help =============================" , pPlayer , LURP.Colours.RGB.White );
        MessagePlayer ( "- Do not share your password with anybody else." , pPlayer , LURP.Colours.RGB.LightGrey );
        MessagePlayer ( "- The server staff will never ask for your password." , pPlayer , LURP.Colours.RGB.LightGrey );
        MessagePlayer ( "- Use /iplogin or /luidlogin to automatically log you in with your IP or LUID" , pPlayer , LURP.Colours.RGB.LightGrey );
        MessagePlayer ( "- Use /changepass to change your password." , pPlayer , LURP.Colours.RGB.LightGrey );
        
        return true;
        
    }
    
    if ( szCategory.tolower ( ) == "vehicle" ) {
        
        MessagePlayer ( "== Vehicle Help =============================" , pPlayer , LURP.Colours.RGB.White );
        MessagePlayer ( "- Visit the dealership in Portland to buy vehicles." , pPlayer , LURP.Colours.RGB.LightGrey );
        MessagePlayer ( "- Use /lock to unlock your car." , pPlayer , LURP.Colours.RGB.LightGrey );
        MessagePlayer ( "- The /lights command can turn on and off your headlights." , pPlayer , LURP.Colours.RGB.LightGrey );
        MessagePlayer ( "- To turn an engine on or off, use /engine" , pPlayer , LURP.Colours.RGB.LightGrey );
        MessagePlayer ( "- To sell your car to another player, use /sellcar" , pPlayer , LURP.Colours.RGB.LightGrey );
        
        return true;
        
    }

    if ( szCategory.tolower ( ) == "job" ) {
        
        if ( pPlayerData.iJob != -1 ) {
            
            MessagePlayer ( "== Job Help =================================" , pPlayer , LURP.Colours.RGB.White );
            MessagePlayer ( "- Jobs are a good way to make money." , pPlayer , LURP.Colours.RGB.LightGrey );
            MessagePlayer ( "- Visit any job site, and use /takejob to get a job." , pPlayer , LURP.Colours.RGB.LightGrey );
            
        }
        
        if ( pPlayerData.iJob == 0 ) {
            
            MessagePlayer ( "== Job Help =================================" , pPlayer , LURP.Colours.RGB.White );
            MessagePlayer ( "- Jobs are a good way to make money." , pPlayer , LURP.Colours.RGB.LightGrey );
            MessagePlayer ( "- Visit any job site, and use /takejob to get a job." , pPlayer , LURP.Colours.RGB.LightGrey );
            
        }
        
        return true;
        
    }
    
    if ( szCategory.tolower ( ) == "command" ) {
    
        if ( NumTok ( szParams , " " ) == 2 ) {
        
            szCommandParam = GetTok ( szParams , " " , 2 );
            
            if ( !DoesCommandHandlerExist ( szCommandParam ) ) {
            
                SendPlayerErrorMessage ( pPlayer , "Command not found!" );
            
                return false;
          
            }
            
            LURP.Commands.rawget ( szCommand.tolower ( ) ) [ "pListener" ] ( pPlayer , szCommand , szParams , true );
        
        } else {
        
            SendPlayerSyntaxMessage ( pPlayer , "/Help Command <Command>" );
            
            return false;
        
        }
    
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function SendPlayerCommandInfoMessage ( pPlayer , szCommand , szDescription , pAliases , szExtraInfo ) {

    local szAliases = "None";
    local pPlayerData = LURP.Players [ pPlayer.ID ];
    
    if ( !DoesCommandHandlerExist ( szCommand ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "Command not found!" );
        
        return false;
        
    }
    
    local pCommandData = LURP.Commands.rawin ( szCommand.tolower ( ) );

    MessagePlayer ( LURP.Colours.ByType.CommandInfoHeader + GetPlayerLocaleMessage ( pPlayer , "CommandInfoHeader" ) + ": " + LURP.Colours.ByType.CommandInfoMessage + szDescription , pPlayer , LURP.Colours.RGB.White );
    
    if ( pAliases.len ( ) > 0 ) {
    
        szAliases = "";
        
        foreach ( ii , iv in pAliases ) {
        
            szAliases = szAliases + iv;
        
        }
    
    }
    
    MessagePlayer ( LURP.Colours.ByType.CommandInfoHeader + GetPlayerLocaleMessage ( pPlayer , "CommandAliasesHeader" ) + ": " + LURP.Colours.ByType.CommandInfoMessage + szAliases , pPlayer , LURP.Colours.RGB.White );
    
    if ( szExtraInfo ) {
    
        MessagePlayer ( LURP.Colours.ByType.CommandInfoHeader + GetPlayerLocaleMessage ( pPlayer , "CommandExtraInfoHeader" ) + ": " + LURP.Colours.ByType.CommandInfoMessage + szExtraInfo , pPlayer , LURP.Colours.RGB.White );
    
    }
    
    if ( HasBitFlag ( pPlayerData.iStaffFlags , pCommandData.iStaffFlags ) ) {
    
        SendPlayerAlertMessage ( pPlayer , "You do not have permission to use this command." );
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerInfoMessage ( pPlayer , szMessage ) {

    MessagePlayer ( LURP.Colours.ByType.InfoMessageHeader + GetPlayerLocaleMessage ( pPlayer , "InfoMessageHeader" ) + ": " + LURP.Colours.ByType.InfoMessageHeader + szMessage , pPlayer , LURP.Colours.RGB.White );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Messaging]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
