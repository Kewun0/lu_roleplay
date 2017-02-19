function AddCommandHandler ( szCommand , szListener , iStaffFlags ) {
    
    if ( typeof szCommand != "string" || typeof szListener != "function" ) {
        
        return false;
        
    }
    
    local pCommandData = { };

    pCommandData.szCommand <- szCommand.tolower ( );
    pCommandData.iStaffFlags <- iStaffFlags;
    pCommandData.bEnabled <- true;
	pCommandData.pListener <- szListener;
    
    GetCoreTable ( ).Commands.rawset ( szCommand.tolower ( ) , pCommandData );

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function RemoveCommandHandler ( szCommand ) {
    
    if ( typeof szCommand != "string" ) {
        
        return false;
        
    }
    

    GetCoreTable ( ).Commands.rawdelete ( szCommand );

    return true;    
    
}

// -------------------------------------------------------------------------------------------------

function DoesCommandHandlerExist ( szCommand ) {

    return GetCoreTable ( ).Commands.rawin ( szCommand );

}

// -------------------------------------------------------------------------------------------------

function AddAllCommandHandlers ( ) {

    //AddCommandHandler ( "Login" , PlayerLoginCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    //AddCommandHandler ( "Register" , PlayerRegisterCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );

    AddCommandHandler ( "Shout" , AreaShoutCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "S" , AreaShoutCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    
    AddCommandHandler ( "Talk" , AreaTalkCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "Local" , AreaTalkCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "L" , AreaTalkCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    
    AddCommandHandler ( "PM" , PrivateMessageCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "MSG" , PrivateMessageCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "Send" , PrivateMessageCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    
    AddCommandHandler ( "Bug" , SubmitBugCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "Idea" , SubmitIdeaCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
	
	AddCommandHandler ( "Help" , HelpCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    
    // AddCommandHandler ( "tazer" , ToggleTazerCommand );
    
    AddVehicleCommandHandlers ( );
    AddPlayerCommandHandlers ( );
    AddScripterCommandHandlers ( );
    AddClanCommandHandlers ( );
	AddModerationCommandHandlers ( );
    
}

// -------------------------------------------------------------------------------------------------

function IsCommandAllowedBeforeAuthentication ( szCommand ) {

    if ( szCommand.tolower ( ) == "login" ) {
    
        return true;
    
    }
    
    if ( szCommand.tolower ( ) == "register" ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Command]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
