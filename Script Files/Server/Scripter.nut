// NAME: Moderation.nut
// DESC: Handles anything related to script management and manipulation.

// ** SERVER OWNERS: This script file provides abilities and commands to modify anything via scripts with unrestricted usage.
// ** YOU HAVE BEEN WARNED !!!

// -- COMMANDS -------------------------------------------------------------------------------------

// - SE, ServerExecute                      ExecuteCodeCommand                              Scripter
// - SR, ServerReturn                       ExecuteReturnCodeCommand                        Scripter

// -------------------------------------------------------------------------------------------------

function AddScripterCommandHandlers ( ) {

    AddCommandHandler ( "se" , ExecuteCodeCommand , GetCoreTable ( ).BitFlags.StaffFlags.Scripter );
    AddCommandHandler ( "sr" , ExecuteReturnCodeCommand , GetCoreTable ( ).BitFlags.StaffFlags.Scripter );
    
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
        
			local pResult = compilestring ( szParams );
            
			if ( !pResult ) {
            
				print ( "There was an error in your code!" );
                
                return;
			}
			
			pResult( );
			
			print ( "SE: " + szParams );
            
            return;
            
        case "sr":
        
			local pResult = compilestring ( "return " + szParams );
            
			if ( !pResult ) {
            
				print ( "There was an error in your code!" );
                
                return;
                
			}
			
			local pReturns = pResult( );
			
			print ( "SR: " + pReturns + " (" + szParams + ")" );
            
            return;            
    
    }

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Scripter]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------