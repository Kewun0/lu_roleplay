function ShowWelcomeMessage ( pPlayer ) {

	MessagePlayer ( "Welcome to Life in Liberty City RP!" , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	MessagePlayer ( "This server is under development, and may restart often for updates." , pPlayer , GetCoreTable ( ).Colours.RGB.BrightRed );
	
	MessagePlayer ( " " , pPlayer );
	
	MessagePlayer ( "Please wait while your account is loaded ... " , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	return;
	
}

// -------------------------------------------------------------------------------------------------

function SendPlayerErrorMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetCoreTable ( ).Colours.ByType.GeneralErrorHeader + GetPlayerLocaleMessage ( pPlayer , "ErrorMessageHeader" ) + ": " + GetCoreTable ( ).Colours.ByType.GeneralErrorMessage + szMessage , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendAdminMessageToAll ( pPlayer , szMessage ) {

	Message ( GetCoreTable ( ).Colours.ByType.AdminAnnounceHeader + "ADMIN: " + GetCoreTable ( ).Colours.ByType.AdminAnnounceMessage + szMessage , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerSyntaxMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetCoreTable ( ).Colours.ByType.SyntaxErrorHeader + GetPlayerLocaleMessage ( pPlayer , "SyntaxMessageHeader" ) + ": " + GetCoreTable ( ).Colours.ByType.SyntaxErrorMessage + szMessage , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerNormalMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetCoreTable ( ).Colours.Hex.White + szMessage , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerAlertMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetCoreTable ( ).Colours.ByType.GeneralAlertHeader + GetPlayerLocaleMessage ( pPlayer , "AlertMessageHeader" ) + ": " + GetCoreTable ( ).Colours.ByType.GeneralAlertMessage + szMessage , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerSuccessMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetCoreTable ( ).Colours.ByType.GeneralSuccessHeader + GetPlayerLocaleMessage ( pPlayer , "SuccessMessageHeader" ) + ": " + GetCoreTable ( ).Colours.ByType.GeneralSuccessMessage + szMessage , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendIsRegisteredWelcomeOnConnect ( pPlayer ) {
	
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( IsPlayerAutoIPLoginEnabled ( pPlayer ) ) {
		
		if ( IsIPAllowedToUseAccount ( pPlayerData , pPlayer.IP ) ) {
			
			MessagePlayer ( "Welcome back, " + pPlayer.Name + ". You have been automatically logged in with your IP!" , pPlayer , GetCoreTable ( ).Colours.RGB.Yellow );   
			MessagePlayer ( "Please use left CTRL to join the game." , pPlayer , GetCoreTable ( ).Colours.RGB.Yellow ); 
			
			pPlayerData.bAuthenticated = true;
			pPlayerData.bCanSpawn = true;
			pPlayerData.bCanUseCommands = true;

			return true;
			
		}
		
	}
	
	if ( IsPlayerAutoLUIDLoginEnabled ( pPlayer ) ) {
		
		if ( IsLUIDAllowedToUseAccount ( pPlayerData , pPlayer.LUID ) ) {
			
			MessagePlayer ( "Welcome back, " + pPlayer.Name + ". You have been logged in with your LUID!" , pPlayer , GetCoreTable ( ).Colours.RGB.Yellow );   
			MessagePlayer ( "Please use left CTRL to join the game." , pPlayer , GetCoreTable ( ).Colours.RGB.Yellow ); 
			
			pPlayerData.bAuthenticated = true;
			pPlayerData.bCanSpawn = true;
			pPlayerData.bCanUseCommands = true;
			
			return true;
			
		}
		
	}	
	
	if ( pPlayerData.iDatabaseID.tointeger ( ) == 0 ) {
		
		MessagePlayer ( "Oops! It looks like you aren't registered. You'll need to create an account to join the game." , pPlayer , GetCoreTable ( ).Colours.RGB.Orange )
		MessagePlayer ( "Please use /register to create your account." , pPlayer , GetCoreTable ( ).Colours.RGB.Yellow );
		
	} else {
	
		MessagePlayer ( "Welcome back, " + pPlayer.Name + ". Your account has been loaded. Please use /login." , pPlayer , GetCoreTable ( ).Colours.RGB.Yellow );		
	
	}
	
	pPlayerData.bCanUseCommands = true;
	
	return;
	
}

// -------------------------------------------------------------------------------------------------

function AreaTalkCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Talks to nearby players." , [ "Talk" , "Local" , "L" ] , "" );

		return false;

	}	

	local pPlayerData = GetPlayerData ( pPlayer );
	
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

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Shouts to nearby players" , [ "Shout" , "S" ] , "" );

		return false;

	}	

	local pPlayerData = GetPlayerData ( pPlayer );
	
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

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Sends a private message to another player" , [ "PM" , "MSG" ] , "" );

		return false;

	}	

	local szMessage = "";
	local pReceiver = false;

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( pPlayerData.bMuted ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are muted, and cannot speak!" );
		
		return false;
	
	}
	
	if ( !szParams || ( szParams == "" ) || ( NumTok ( szParams , " " ) < 2 ) ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/PM <Player Name/ID> <Message>" );
		
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

	MessagePlayer ( GetCoreTable ( ).Colours.Hex.Lime + "(MSG) " + GetCoreTable ( ).Colours.Hex.White + " From " + pSender.Name + ": " GetCoreTable ( ).Colours.Hex.LightGrey + szMessage , pReceiver , GetCoreTable ( ).Colours.RGB.White );
	MessagePlayer ( GetCoreTable ( ).Colours.Hex.Lime + "(MSG) " + GetCoreTable ( ).Colours.Hex.White + " To " + pReceiver.Name + ": " GetCoreTable ( ).Colours.Hex.LightGrey + szMessage , pSender , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerAreaTalkMessage ( pPlayer , szMessage ) {

	if ( !pPlayer.Spawned ) {
	
		return false;
		
	}
	
	foreach ( ii , iv in GetCoreTable ( ).Players ) {
		
		if ( GetDistance ( pPlayer.Pos , iv.pPlayer.Pos ) < GetCoreTable ( ).Utilities.fAreaTalkRange ) {
	
			MessagePlayer ( GetCoreTable ( ).Colours.ByType.AreaTalkHeader + "(Nearby) " + GetCoreTable ( ).Colours.ByType.AreaTalkName + pPlayer.Name + ": " + GetCoreTable ( ).Colours.ByType.AreaTalkMessage + szMessage , iv.pPlayer );
		
		}
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function PlayerAreaShoutMessage ( pPlayer , szMessage ) {

	if ( !pPlayer.Spawned ) {
	
		return false;
		
	}
	
	foreach ( ii , iv in GetCoreTable ( ).Players ) {
		
		if ( GetDistance ( pPlayer.Pos , iv.pPlayer.Pos ) < GetCoreTable ( ).Utilities.fAreaShoutRange ) {
	
			MessagePlayer ( GetCoreTable ( ).Colours.ByType.AreaShoutHeader + "(Shout) " + GetCoreTable ( ).Colours.ByType.AreaShoutName + pPlayer.Name + ": " + GetCoreTable ( ).Colours.ByType.AreaShoutMessage + szMessage + "!" , iv.pPlayer );
		
		}
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function SendWelcomeMessage ( pPlayer ) {

	MessagePlayer ( "Welcome to Life in Liberty City RP." , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	MessagePlayer ( "This server is still in development, so it may restart often for updates." , pPlayer , GetCoreTable ( ).Colours.RGB.BrightRed );
	
	MessagePlayer ( " " , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	MessagePlayer ( "Please wait while your account is loaded ... " , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	// MessagePlayer ( "Please remember to speak only english in the main chat." , pPlayer , GetCoreTable ( ).Colours.RGB.Orange );
	// MessagePlayer ( "You can use other languages in different chats, such as private messages." , pPlayer , GetCoreTable ( ).Colours.RGB.Orange );

	return;

}

// -------------------------------------------------------------------------------------------------

function HelpCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Shows help information" , [ "Help" ] , "" );

		return false;

	}		
	
	local pPlayerData = GetPlayerData ( pPlayer );
	local szCategory = "";
	
	if ( !szParams ) {
		
		SendPlayerSyntaxMessage ( pPlayer , "/Help <Category>" );
		MessagePlayer ( GetCoreTable ( ).Colours.Hex.White + "Help Categories: " + GetCoreTable ( ).Colours.Hex.LightGrey + "Account, Command, Vehicle, Job, Chat, Rules, Website" , pPlayer , GetCoreTable ( ).Colours.RGB.White );
		
		return false;
		
	}
	
	szCategory = GetTok ( szParams , " " , 1 );
	
	// == Account Help =============================
	// == Vehicle Help =============================
	// == Job Help =================================
	// == Chat Help ================================
	// == Server Rules =============================
	
	if ( szCategory.tolower ( ) == "account" ) {
		
		MessagePlayer ( "== Account Help =============================" , pPlayer , GetCoreTable ( ).Colours.RGB.White );
		MessagePlayer ( "- Do not share your password with anybody else." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
		MessagePlayer ( "- The server staff will never ask for your password." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
		MessagePlayer ( "- Use /iplogin or /luidlogin to automatically log you in with your IP or LUID" , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
		MessagePlayer ( "- Use /changepass to change your password." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
		
		return true;
		
	}
	
	if ( szCategory.tolower ( ) == "vehicle" ) {
		
		MessagePlayer ( "== Vehicle Help =============================" , pPlayer , GetCoreTable ( ).Colours.RGB.White );
		MessagePlayer ( "- Visit the dealership in Portland to buy vehicles." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
		MessagePlayer ( "- Use /lock to unlock your car." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
		MessagePlayer ( "- The /lights command can turn on and off your headlights." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
		MessagePlayer ( "- To turn an engine on or off, use /engine" , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
		MessagePlayer ( "- To sell your car to another player, use /sellcar" , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
		
		return true;
		
	}

	if ( szCategory.tolower ( ) == "job" ) {
		
		if ( pPlayerData.iJob != -1 ) {
			
			MessagePlayer ( "== Job Help =================================" , pPlayer , GetCoreTable ( ).Colours.RGB.White );
			MessagePlayer ( "- Jobs are a good way to make money." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
			MessagePlayer ( "- Visit any job site, and use /takejob to get a job." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
			
		}
		
		if ( pPlayerData.iJob == 0 ) {
			
			MessagePlayer ( "== Job Help =================================" , pPlayer , GetCoreTable ( ).Colours.RGB.White );
			MessagePlayer ( "- Jobs are a good way to make money." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
			MessagePlayer ( "- Visit any job site, and use /takejob to get a job." , pPlayer , GetCoreTable ( ).Colours.RGB.LightGrey );
			
		}
		
		return true;
		
	}
	
	if ( szCategory.tolower ( ) == "command" ) {
	
		if ( NumTok ( szParams , " " ) == 2 ) {
		
			local szCommandParam = GetTok ( szParams , " " , 2 );
			
			if ( !DoesCommandHandlerExist ( szCommandParam.tolower ( ) ) ) {
			
				SendPlayerErrorMessage ( pPlayer , "Command not found!" );
			
				return false;
		  
			}
			
			GetCoreTable ( ).Commands.rawget ( szCommandParam.tolower ( ) ) [ "pListener" ] ( pPlayer , szCommandParam.tolower ( ) , false , true );
		
		} else {
		
			SendPlayerSyntaxMessage ( pPlayer , "/Help Command <Command>" );
			
			return false;
		
		}
	
	}
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function SendPlayerCommandInfoMessage ( pPlayer , szDescription , pAliases , szExtraInfo ) {

	local szAliases = "None";
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !DoesCommandHandlerExist ( szCommand ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "Command not found!" );
		
		return false;
		
	}
	
	local pCommandData = GetCoreTable ( ).Commands [ szCommand.tolower ( ) ];

	MessagePlayer ( "== COMMAND INFO ====================================" , pPlayer , GetCoreTable ( ).Colours.RGB.Lime );
	
	MessagePlayer ( GetCoreTable ( ).Colours.ByType.CommandInfoHeader + GetPlayerLocaleMessage ( pPlayer , "CommandInfoHeader" ) + ": " + GetCoreTable ( ).Colours.ByType.CommandInfoMessage + szDescription , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	if ( pAliases.len ( ) > 0 ) {
	
		szAliases = "";
		
		foreach ( ii , iv in pAliases ) {
		
			if ( szAliases.len ( ) == 0 ) {
			
				szAliases = "/" + iv.tolower ( );
			
			} else {
			
				szAliases = szAliases + ", /" + iv.tolower ( );
			
			}
		
		}
	
	}
	
	MessagePlayer ( GetCoreTable ( ).Colours.ByType.CommandInfoHeader + GetPlayerLocaleMessage ( pPlayer , "CommandAliasesHeader" ) + ": " + GetCoreTable ( ).Colours.ByType.CommandInfoMessage + szAliases , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	if ( szExtraInfo != "" ) {
	
		MessagePlayer ( GetCoreTable ( ).Colours.ByType.CommandInfoHeader + GetPlayerLocaleMessage ( pPlayer , "CommandExtraInfoHeader" ) + ": " + GetCoreTable ( ).Colours.ByType.CommandInfoMessage + szExtraInfo , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	}
	
	if ( pCommandData.iStaffFlags != 0 && !HasBitFlag ( pPlayerData.iStaffFlags , pCommandData.iStaffFlags ) ) {
	
		SendPlayerAlertMessage ( pPlayer , "You can't use this command." );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerInfoMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetCoreTable ( ).Colours.ByType.InfoMessageHeader + GetPlayerLocaleMessage ( pPlayer , "InfoMessageHeader" ) + ": " + GetCoreTable ( ).Colours.ByType.InfoMessageHeader + szMessage , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Messaging]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
