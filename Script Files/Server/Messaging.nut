// -------------------------------------------------------------------------------------------------

function ShowWelcomeMessage ( pPlayer ) {

	MessagePlayer ( "Welcome to Life in Liberty City RP!" , pPlayer , GetRGBColour ( "White" ) );
	MessagePlayer ( "This server is under development, and may restart often for updates." , pPlayer , GetRGBColour ( "BrightRed" ) );
	
	MessagePlayer ( " " , pPlayer );
	
	MessagePlayer ( "Please wait while your account is loaded ... " , pPlayer , GetRGBColour ( "White" ) );
	
	// print ( "- Welcome message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );
	
	return;
	
}

// -------------------------------------------------------------------------------------------------

function SendPlayerErrorMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetColourByType ( "GeneralErrorHeader" ) + GetPlayerLocaleMessage ( pPlayer , "ErrorMessageHeader" ) + ": " + GetColourByType ( "GeneralErrorMessage" ) + szMessage , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendAdminMessageToAll ( szMessage ) {

	Message ( GetColourByType ( "AdminAnnounceHeader" ) + "ADMIN: " + GetColourByType ( "AdminAnnounceMessage" ) + szMessage , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendMessageToAdmins ( szMessage ) {

	foreach ( ii , iv in GetCoreTable ( ).Players ) {
	
		if ( iv.iStaffFlags != 0 ) {
		
			MessagePlayer ( szMessage , iv.pPlayer , GetRGBColour ( "White" ) );
		
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerSyntaxMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetColourByType ( "GeneralSyntaxHeader" ) + GetPlayerLocaleMessage ( pPlayer , "SyntaxMessageHeader" ) + ": " + GetColourByType ( "GeneralSyntaxMessage" ) + szMessage , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerNormalMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetHexColour ( "White" ) + szMessage , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerAlertMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetColourByType ( "GeneralAlertHeader" ) + GetPlayerLocaleMessage ( pPlayer , "AlertMessageHeader" ) + ": " + GetColourByType ( "GeneralAlertMessage" ) + szMessage , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerSuccessMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetColourByType ( "GeneralSuccessHeader" ) + GetPlayerLocaleMessage ( pPlayer , "SuccessMessageHeader" ) + ": " + GetColourByType ( "GeneralSuccessMessage" ) + szMessage , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendIsRegisteredWelcomeOnConnect ( pPlayer ) {
	
	local pPlayerData = GetPlayerData ( pPlayer );
	
	ClearChat ( pPlayer );
	
	if ( pPlayerData.iDatabaseID.tointeger ( ) == 0 ) {
		
		MessagePlayer ( "Oops! It looks like you aren't registered. You'll need to create an account to join the game." , pPlayer , GetRGBColour ( "Orange" ) )
		MessagePlayer ( "Please use /register to create your account." , pPlayer , GetRGBColour ( "Yellow" ) );
		
		print ( "- NeedToRegister message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );
		
		return true;
		
	} else {
	
		if ( IsPlayerAutoIPLoginEnabled ( pPlayer ) ) {
			
			if ( IsIPAllowedToUseAccount ( pPlayerData , pPlayer.IP ) ) {
				
				MessagePlayer ( "Welcome back, " + pPlayer.Name + ". You have been automatically logged in with your IP!" , pPlayer , GetRGBColour ( "Yellow" ) );   
				MessagePlayer ( "Please use left CTRL to join the game." , pPlayer , GetRGBColour ( "Yellow" ) ); 
				
				pPlayerData.bAuthenticated = true;
				pPlayerData.bCanSpawn = true;
				pPlayerData.bCanUseCommands = true;
				
				print ( "- AutoIPLoggedIn message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );

				return true;
				
			}
			
		}
		
		if ( IsPlayerAutoLUIDLoginEnabled ( pPlayer ) ) {
			
			if ( IsLUIDAllowedToUseAccount ( pPlayerData , pPlayer.LUID ) ) {
				
				MessagePlayer ( "Welcome back, " + pPlayer.Name + ". You have been logged in with your LUID!" , pPlayer , GetRGBColour ( "Yellow" ) );   
				MessagePlayer ( "Please use left CTRL to join the game." , pPlayer , GetRGBColour ( "Yellow" ) ); 
				
				pPlayerData.bAuthenticated = true;
				pPlayerData.bCanSpawn = true;
				pPlayerData.bCanUseCommands = true;
				
				print ( "- AutoIPLoggedIn message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );
				
				return true;
				
			}
			
		}	
	
		MessagePlayer ( "Welcome back, " + pPlayer.Name + ". Your account has been loaded. Please use /login." , pPlayer , GetRGBColour ( "Yellow" ) );	
		
		print ( "- NeedToLogin message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );

		return true;	
	
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

	MessagePlayer ( GetHexColour ( "Lime" ) + "(MSG) " + GetHexColour ( "White" ) + " From " + pSender.Name + ": " + GetHexColour ( "LightGrey" ) + szMessage , pReceiver , GetRGBColour ( "White" ) );
	MessagePlayer ( GetHexColour ( "Lime" ) + "(MSG) " + GetHexColour ( "White" ) + " To " + pReceiver.Name + ": " + GetHexColour ( "LightGrey" ) + szMessage , pSender , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerAreaTalkMessage ( pPlayer , szMessage ) {

	if ( !pPlayer.Spawned ) {
	
		return false;
		
	}
	
	foreach ( ii , iv in ConnectedPlayers ) {
		
		if ( GetDistance ( pPlayer.Pos , iv.Pos ) < GetCoreTable ( ).Utilities.fAreaTalkRange ) {
	
			MessagePlayer ( GetColourByType ( "AreaTalkHeader" ) + "(Nearby) " + GetColourByType ( "AreaTalkName" ) + pPlayer.Name + ": " + GetColourByType ( "AreaTalkMessage" ) + szMessage , iv );
		
		}
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function PlayerAreaShoutMessage ( pPlayer , szMessage ) {

	if ( !pPlayer.Spawned ) {
	
		return false;
		
	}
	
	foreach ( ii , iv in ConnectedPlayers ) {
		
		if ( iv.Spawned ) {
		
			if ( GetDistance ( pPlayer.Pos , iv.Pos ) < GetCoreTable ( ).Utilities.fAreaShoutRange ) {
		
				MessagePlayer ( GetColourByType ( "AreaShoutHeader" ) + "(Shout) " + GetColourByType ( "AreaShoutName" ) + pPlayer.Name + ": " + GetColourByType ( "AreaShoutMessage" ) + szMessage + "!" , iv );
			
			}
		
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
		MessagePlayer ( GetHexColour ( "White" ) + "Help Categories: " + GetHexColour ( "LightGrey" ) + "Account, Command, Vehicle, Job, Chat, Rules, Website" , pPlayer , GetRGBColour ( "White" ) );
		
		return false;
		
	}
	
	szCategory = GetTok ( szParams , " " , 1 );
	
	// == Account Help =============================
	// == Vehicle Help =============================
	// == Job Help =================================
	// == Chat Help ================================
	// == Server Rules =============================
	
	if ( szCategory.tolower ( ) == "account" ) {
		
		local pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "AccountHelp" );
		
		foreach ( ii , iv in pMessages ) {
		
			if ( ii == 0 ) {
			
				MessagePlayer ( iv , pPlayer , GetRGBColour ( "White" ) );
			
			} else {
				
				MessagePlayer ( iv , pPlayer , GetRGBColour ( "LightGrey" ) );
			
			}
		
		}
		
		return true;
		
	}
	
	if ( szCategory.tolower ( ) == "vehicle" ) {
		
		local pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "VehicleHelp" );
		
		foreach ( ii , iv in pMessages ) {
		
			if ( ii == 0 ) {
			
				MessagePlayer ( iv , pPlayer , GetRGBColour ( "White" ) );
			
			} else {
				
				MessagePlayer ( iv , pPlayer , GetRGBColour ( "LightGrey" ) );
			
			}
		
		}
		
		return true;
		
	}

	if ( szCategory.tolower ( ) == "job" ) {
		
		if ( pPlayerData.iJob == 0 ) {
			
			local pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "JobHelpUnemployed" );
			
			foreach ( ii , iv in pMessages ) {
			
				if ( ii == 0 ) {
				
					MessagePlayer ( iv , pPlayer , GetRGBColour ( "White" ) );
				
				} else {
					
					MessagePlayer ( iv , pPlayer , GetRGBColour ( "LightGrey" ) );
				
				}
			
			}
			
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
	
	SendPlayerSyntaxMessage ( pPlayer , "/Help <Category>" );
	MessagePlayer ( GetHexColour ( "White" ) + "Help Categories: " + GetHexColour ( "LightGrey" ) + "Account, Command, Vehicle, Job, Chat, Rules, Website" , pPlayer , GetRGBColour ( "White" ) );
	
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

	MessagePlayer ( "== COMMAND INFO ====================================" , pPlayer , GetRGBColour ( "Lime" ) );
	
	MessagePlayer ( GetColourByType ( "CommandInfoHeader" ) + GetPlayerLocaleMessage ( pPlayer , "CommandInfoHeader" ) + ": " + GetColourByType ( "CommandInfoMessage" ) + szDescription , pPlayer , GetRGBColour ( "White" ) );
	
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
	
	MessagePlayer ( GetColourByType ( "CommandInfoHeader" ) + GetPlayerLocaleMessage ( pPlayer , "CommandAliasesHeader" ) + ": " + GetColourByType ( "CommandInfoMessage" ) + szAliases , pPlayer , GetRGBColour ( "White" ) );
	
	if ( szExtraInfo != "" ) {
	
		MessagePlayer ( GetColourByType ( "CommandInfoHeader" ) + GetPlayerLocaleMessage ( pPlayer , "CommandExtraInfoHeader" ) + ": " + GetColourByType ( "CommandInfoMessage" ) + szExtraInfo , pPlayer , GetRGBColour ( "White" ) );
	
	}
	
	if ( pCommandData.iStaffFlags != 0 && !HasBitFlag ( pPlayerData.iStaffFlags , pCommandData.iStaffFlags ) ) {
	
		SendPlayerAlertMessage ( pPlayer , "You can't use this command." );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerInfoMessage ( pPlayer , szMessage ) {

	//MessagePlayer ( GetColourByType ( "InfoMessageHeader" ) + GetPlayerLocaleMessage ( pPlayer , "InfoMessageHeader" ) + ": " + etColourByType ( "InfoMessageMessage" ) + szMessage , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	SendPlayerAlertMessage ( pPlayer , szMessage );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Messaging]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
