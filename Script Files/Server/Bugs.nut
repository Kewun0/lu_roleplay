// -------------------------------------------------------------------------------------------------

function SubmitBugCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    local iBugCount = ReadIniInteger ( "Bugs.ini" , "General" , "iBugCount" );
    local pPlayerData = GetCoreTable ( ).Players [ pPlayer.ID ];
    
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

    local iIdeaCount = ReadIniInteger ( "Ideas.ini" , "General" , "ideaCount" );
    local pPlayerData = GetCoreTable ( ).Players [ pPlayer.ID ];
    
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

// -- THIS GOES LAST

print ( "[Server.Bugs]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------