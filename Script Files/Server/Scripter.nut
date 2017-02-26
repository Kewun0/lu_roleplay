// NAME: Moderation.nut
// DESC: Handles anything related to script management and manipulation.

// ** SERVER OWNERS: This script file provides abilities and commands to modify anything via scripts with unrestricted usage.
// ** YOU HAVE BEEN WARNED !!!

// -- COMMANDS -------------------------------------------------------------------------------------

// - SE, ServerExecute					  ExecuteCodeCommand							  Scripter
// - SR, ServerReturn					   ExecuteReturnCodeCommand						Scripter
// - FuncAlias								AddFunctionAliasCommand						 Scripter
// - Bug					   				SubmitBugCommand								None
// - Idea					   			SubmitIdeaCommand								None
// - Position					  			SubmitPositionCommand							None

// -------------------------------------------------------------------------------------------------

function AddScripterCommandHandlers ( ) {

	AddCommandHandler ( "SE" , ExecuteCodeCommand , GetStaffFlagValue ( "Scripter" ) );
	AddCommandHandler ( "SR" , ExecuteReturnCodeCommand , GetStaffFlagValue ( "Scripter" ) );
	AddCommandHandler ( "FuncAlias" , AddFunctionAliasCommand , GetStaffFlagValue ( "Scripter" ) );
	
	AddCommandHandler ( "Bug" , SubmitBugCommand , GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Idea" , SubmitIdeaCommand , GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Position" , SubmitPositionCommand , GetStaffFlagValue ( "None" ) );	
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ExecuteCodeCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Executes custom squirrel code server-side" , [ "SE" , "ServerExecute" ] , "Full script access, including root table." );
		
		return false;
	
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/ServerExecute <Code>" );
		
		return false;
	
	}
	
	local cCodeClosure = compilestring ( szParams );
	
	if ( !cCodeClosure ) {
	
		SendPlayerErrorMessage ( pPlayer , "Your code contains an error, and cannot be executed." );
		
		return false;
	
	}

	cCodeClosure ( );
	
	SendPlayerSuccessMessage ( pPlayer , "Your code was executed ( " + szParams + " ) " );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function ExecuteReturnCodeCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Executes squirrel code server-side, and returns the result." , [ "SR" , "ServerReturn" ] , "Full script access, including root table." );
		
		return false;
	
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/ServerReturn <Code>" );
		
		return false;
	
	}
	
	local cCodeClosure = compilestring ( "return " + szParams );
	
	if ( !cCodeClosure ) {
	
		SendPlayerErrorMessage ( pPlayer , "Your code contains an error, and cannot be executed." );
		
		return false;
	
	}

	local pReturnOutput = cCodeClosure ( );
	
	SendPlayerSuccessMessage ( pPlayer , "Your code was executed, and returned: " + pReturnOutput );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function onConsoleInput ( szCommand , szParams ) {
	
	switch ( szCommand.tolower ( ) ) {
	
		case "se":
		
			if ( !szParams ) {

				print ( "[DEBUG]: You need to enter some code!" );
				
				return;			
			
			}
		
			local pResult = compilestring ( szParams );
			
			if ( !pResult ) {
			
				print ( "[DEBUG]: There was an error in your code!" );
				
				return;
				
			}
			
			pResult( );
			
			print ( "SE: " + szParams );
			
			return;
			
		case "sr":

			if ( !szParams ) {

				print ( "[DEBUG]: You need to enter some code!" );
				
				return;			
			
			}		
		
			local pResult = compilestring ( "return " + szParams );
			
			if ( !pResult ) {
			
				print ( "[DEBUG]: There was an error in your code!" );
				
				return;
				
			}
			
			local pReturns = pResult( );
			
			print ( "SR: " + pReturns + " (" + szParams + ")" );
			
			return;	

		case "luid":
			
			if ( !szParams ) {

				print ( "[DEBUG]: You need to enter a player name or ID!" );
				
				return;			
			
			}
			
			local pTarget = !FindPlayer ( szParams );
			
			if ( !pTarget ) {
			
				print ( "[DEBUG]: Player not found" );
			
			}
			
			print ( "[DEBUG]: " + GetPlayerNameAndIDForConsole ( pTarget ) + " LUID: " + pTarget.LUID );
			
			break;
	
	}

}

// -------------------------------------------------------------------------------------------------

function SubmitBugCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Reports a bug to the scripters" , [ "Bug" ] , "" );

		return false;

	}		

	local iBugCount = ReadIniInteger ( "Bugs.ini" , "General" , "iBugCount" );
	local pPlayerData = GetPlayerData ( pPlayer );
	
	iBugCount++;
	
	WriteIniInteger ( "Bugs.ini" , "General" , "iBugCount" , iBugCount );
	
	local szSafeIniString = CreateSafeIniString ( szParams );
	
	WriteIniString ( "Bugs.ini" , "Bug " + iBugCount , "szMessage" , szSafeIniString );
	WriteIniString ( "Bugs.ini" , "Bug " + iBugCount , "szAddedBy" , pPlayer.Name );
	WriteIniString ( "Bugs.ini" , "Bug " + iBugCount , "szTimestamp" , ParseDateForDisplay ( time( ) ) );
	WriteIniInteger ( "Bugs.ini" , "Bug " + iBugCount , "iScriptVersion" , GetCoreTable ( ).Utilities.iScriptVersion );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SubmitIdeaCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Sends an idea to the scripters" , [ "Idea" ] , "" );

		return false;

	}		

	local iIdeaCount = ReadIniInteger ( "Ideas.ini" , "General" , "iIdeaCount" );
	local pPlayerData = GetPlayerData ( pPlayer );
	
	iIdeaCount++;
	
	WriteIniInteger ( "Ideas.ini" , "General" , "iIdeaCount" , iIdeaCount );
	
	local szSafeIniString = CreateSafeIniString ( szParams );
	
	WriteIniString ( "Ideas.ini" , "Idea " + iIdeaCount , "szMessage" , szSafeIniString );
	WriteIniString ( "Ideas.ini" , "Idea " + iIdeaCount , "szAddedBy" , pPlayer.Name );
	WriteIniString ( "Ideas.ini" , "Idea " + iIdeaCount , "szTimestamp" , ParseDateForDisplay ( time( ) ) );
	WriteIniInteger ( "Ideas.ini" , "Idea " + iIdeaCount , "iScriptVersion" , GetCoreTable ( ).Utilities.iScriptVersion );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SubmitPositionCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Saves a position for reference" , [ "Position" ] , "" );

		return false;

	}		

	local iPositionCount = ReadIniInteger ( "Positions.ini" , "General" , "iPositionCount" );
	local pPlayerData = GetPlayerData ( pPlayer );
	
	iPositionCount++;
	
	WriteIniInteger ( "Positions.ini" , "General" , "iPositionCount" , iPositionCount );
	
	local szSafeIniString = CreateSafeIniString ( szParams );
	
	local szPosition = pPlayer.Pos.x + " , " + pPlayer.Pos.y + " , " + pPlayer.Pos.z;
	
	WriteIniString ( "Positions.ini" , "Position " + iPositionCount , "szMessage" , szSafeIniString );
	WriteIniString ( "Positions.ini" , "Position " + iPositionCount , "szPosition" , szPosition );
	WriteIniString ( "Positions.ini" , "Position " + iPositionCount , "szAddedBy" , pPlayer.Name );
	WriteIniString ( "Positions.ini" , "Position " + iPositionCount , "szTimestamp" , ParseDateForDisplay ( time( ) ) );
	WriteIniInteger ( "Positions.ini" , "Position " + iPositionCount , "iScriptVersion" , GetCoreTable ( ).Utilities.iScriptVersion );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AddFunctionAliasCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Adds a function alias" , [ "FuncAlias" ] , "" );
		
		return false;
	
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/FuncAlias <Function> <Alias>" );
		
		return false;
	
	}
	
	if ( NumTok ( pPlayer , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/FuncAlias <Function> <Alias>" );
		
		return false;
	
	}
	
	local szFunction = GetTok ( pPlayer , " " , 1 );
	local pFunction = getroottable ( ).rawget ( szFunction );
	local szAlias = GetTok ( pPlayer , " " , 2 );
	
	if ( type ( pFunction ) != "function" ) {
		
		SendPlayerErrorMessage ( pPlayer , "The function " + szFunction + " does not exist!" );
		
		return false;
		
	}
	
	if ( getroottable ( ).rawin ( szAlias ) ) {
		
		SendPlayerErrorMessage ( pPlayer , "The function " + szAlias + " could not be created!" );
		
		return false;
		
	}
	
	getroottable ( ).rawset ( szAlias , pFunction );
	
	SendPlayerSuccessMessage ( pPlayer , "Function alias added! ( " + szFunction + " as " + szAlias + " ) " );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Scripter]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------