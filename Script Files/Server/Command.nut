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

    AddCommandHandler ( "Shout" , AreaShoutCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "S" , AreaShoutCommand , GetStaffFlagValue ( "None" ) );
    
    AddCommandHandler ( "Talk" , AreaTalkCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Local" , AreaTalkCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "L" , AreaTalkCommand , GetStaffFlagValue ( "None" ) );
    
    AddCommandHandler ( "PM" , PrivateMessageCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "MSG" , PrivateMessageCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Send" , PrivateMessageCommand , GetStaffFlagValue ( "None" ) );
	
	AddCommandHandler ( "Help" , HelpCommand , GetStaffFlagValue ( "None" ) );
    
    // AddCommandHandler ( "tazer" , ToggleTazerCommand );
    
    AddVehicleCommandHandlers ( );
    AddPlayerCommandHandlers ( );
    AddScripterCommandHandlers ( );
    AddClanCommandHandlers ( );
	AddModerationCommandHandlers ( );
	AddJobCommandHandlers ( );
    
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
