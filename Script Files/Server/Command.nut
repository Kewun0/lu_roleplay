function AddCommandHandler ( szCommand , szListener , iStaffFlags ) {
    
    if ( typeof szCommand != "string" || typeof szListener != "function" ) {
        
        return false;
        
    }
    
    local pCommandData = { };

    pCommandData.szCommand = szCommand.tolower ( );
    pCommandData.iStaffFlags = iStaffFlags;
    pCommandData.bEnabled = true;
    
    GetCoreTable ( ).Commands.rawset ( szCommand , pCommandData );

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

    AddCommandHandler ( "shout" , AreaShoutCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "s" , AreaShoutCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    
    AddCommandHandler ( "talk" , AreaTalkCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "local" , AreaTalkCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "l" , AreaTalkCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    
    AddCommandHandler ( "pm" , PrivateMessageCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "msg" , PrivateMessageCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "send" , PrivateMessageCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    
    AddCommandHandler ( "bug" , SubmitBugCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "idea" , SubmitIdeaCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    
    AddCommandHandler ( "tazer" , ToggleTazerCommand );
    
    AddVehicleCommandHandlers ( );
    AddPlayerCommandHandlers ( );
    AddScripterCommandHandlers ( );
    
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