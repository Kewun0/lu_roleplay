function AddPlayerCommandHandlers ( ) {

    AddCommandHandler ( "setskin" , SetPlayerSkinCommand , GetCoreTable ( ).BitFlags.StaffFlags.BasicModeration );
    
    AddCommandHandler ( "login" , LoginCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
    AddCommandHandler ( "register" , RegisterCommand , GetCoreTable ( ).BitFlags.StaffFlags.None );
        
    return true;
    
}

function SavePlayerToDatabase ( pPlayer ) {
    
    local pPlayerData = UnitedIslands.Players [ pPlayer.ID ];
    local pQuery = false;
    local iNewConnectTime = pPlayerData.iConnectTime + ( time ( ) - pPlayerData.pSession.iConnectedTime );
    
    local pPosition = ( ( pPlayer.Spawned ) ? pPlayer.Pos : pPlayerData.pPosition );
    local iAngle = ( ( pPlayer.Spawned ) ? pPlayer.Angle : pPlayerData.iAngle );
    
    if ( pPlayerData.iDatabaseID == 0 ) {
    
        local iDatabaseID = GetNumberOfRegisteredAccounts( );
        
        iDatabaseID = iDatabaseID + 1;
        
        WriteIniInteger ( "Scripts/United Islands RPG/Data/Index.ini" , "General" , "iAccountAmount" , iDatabaseID );
        
        pPlayerData.iDatabaseID = iDatabaseID;
        
        pPlayerData.szFileString = "Scripts/United Islands RPG/Data/Accounts/" + iDatabaseID + ".ini";
        
        WriteIniInteger ( pPlayerData.szFileString , "General" , "iDatabaseID" , iDatabaseID.tointeger ( ) );
        
        WriteIniInteger ( "Scripts/United Islands RPG/Data/Index.ini" , "Account Index" , pPlayer.Name , iDatabaseID.tointeger ( ) );
        
        pPosition = Vector ( -763.80 , -603.30 , 11.33 );
        iAngle = 268.556;
    
    }
    
    pPlayerData.iDatabaseID = pPlayerData.iDatabaseID;
            
    WriteIniString ( pPlayerData.szFileString , "General" , "szName" , pPlayerData.szName );
    WriteIniString ( pPlayerData.szFileString , "General" , "szPassword" , pPlayerData.szPassword );

    WriteIniInteger ( pPlayerData.szFileString , "General" , "iLastSession" , pPlayerData.iLastSession );

    WriteIniInteger ( pPlayerData.szFileString , "General" , "iRegisteredTimestamp" , pPlayerData.iRegisteredTimestamp.tointeger ( ) );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "ilastLoginTimestamp" , pPlayerData.iLastLoginTimestamp.tointeger ( ) );

    WriteIniInteger ( pPlayerData.szFileString , "General" , "iConnectTime" , iNewConnectTime.tointeger ( ) );
            
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iKills" , pPlayerData.iKills );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iDeaths" , pPlayerData.iDeaths );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iMaxKillStreak" , pPlayerData.iMaxKillStreak );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iHeadshots" , pPlayerData.iHeadshots );
    WriteIniFloat ( pPlayerData.szFileString , "General" , "fFurthestHeadshot" , pPlayerData.fFurthestHeadshot );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iPackagesPicked" , pPlayerData.iPackagesPicked );
            
    WriteIniFloat ( pPlayerData.szFileString , "General" , "fDistanceOnFoot" , pPlayerData.fDistanceOnFoot );
    WriteIniFloat ( pPlayerData.szFileString , "General" , "fDistanceCar" , pPlayerData.fDistanceCar );
    WriteIniFloat ( pPlayerData.szFileString , "General" , "fDistanceBoat" , pPlayerData.fDistanceBoat );
    WriteIniFloat ( pPlayerData.szFileString , "General" , "fDistancePlane" , pPlayerData.fDistancePlane );
            
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iHealthPicked" , pPlayerData.iHealthPicked );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iArmourPicked" , pPlayerData.iArmourPicked );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iWeaponsPicked" , pPlayerData.iWeaponsPicked );
            
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iCash" , pPlayerData.iCash );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iBank" , pPlayerData.iBank );
            
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iSkin" , pPlayerData.iSkin );
            
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iHealth" , pPlayerData.iHealth );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iArmour" , pPlayerData.iArmour );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iTimesBusted" , pPlayerData.iTimesBusted );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iStarsObtained" , pPlayerData.iStarsObtained );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iStarsEvaded" , pPlayerData.iStarsEvaded );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iHighestWantedLevel" , pPlayerData.iHighestWantedLevel );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iBusinessesPurchased" , pPlayerData.iBusinessesPurchased );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iHousesPurchased" , pPlayerData.iHousesPurchased );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iWeaponsPurchased" , pPlayerData.iWeaponsPurchased );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iSpentOnWeapons" , pPlayerData.iSpentOnWeapons );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iVehicleResprays" , pPlayerData.iVehicleResprays );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iWantedVehicleResprays" , pPlayerData.iWantedVehicleResprays );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iLongestGameTime" , pPlayerData.iLongestGameTime );

    WriteIniFloat ( pPlayerData.szFileString , "General" , "fPositionX" , pPosition.x );
    WriteIniFloat ( pPlayerData.szFileString , "General" , "fPositionY" , pPosition.y );
    WriteIniFloat ( pPlayerData.szFileString , "General" , "fPositionZ" , pPosition.z );
    WriteIniFloat ( pPlayerData.szFileString , "General" , "iAngle" , iAngle.tofloat ( ) );

    WriteIniInteger ( pPlayerData.szFileString , "General" , "iAccountSettings" , pPlayerData.iAccountSettings );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iLicenses" , pPlayerData.iLicenses );
    WriteIniInteger ( pPlayerData.szFileString , "General" , "iStaffFlags" , pPlayerData.iStaffFlags );        
        
    return true;
    
}
    
// -------------------------------------------------------------------------------------------------

function IsPlayerAutoLUIDLoginEnabled ( pPlayer ) {

    local pPlayerData = UnitedIslands.Players [ pPlayer.ID ];
    
    return ( HasBitFlag ( pPlayerData.iAccountSettings , UnitedIslands.BitFlags.AccountSettings.LUIDLogin ) );
    
}

// -------------------------------------------------------------------------------------------------

function IsPlayerAutoIPLoginEnabled ( pPlayer ) {
    
    local pPlayerData = UnitedIslands.Players [ pPlayer.ID ];
    
    return ( HasBitFlag ( pPlayerData.iAccountSettings , UnitedIslands.BitFlags.AccountSettings.IPLogin ) );
    
}

// -------------------------------------------------------------------------------------------------

function IsPlayerTwoStepAuthEnabled ( pPlayer ) {
    
    local pPlayerData = UnitedIslands.Players [ pPlayer.ID ];
    
    return ( HasBitFlag ( pPlayerData.iAccountSettings , UnitedIslands.BitFlags.AccountSettings.TwoStepAuth ) );

}

// -------------------------------------------------------------------------------------------------

function TogglePlayerAutoIPLogin ( pPlayer ) {

    local pPlayerData = UnitedIslands.Players [ pPlayer.ID ];

    if ( IsAutoIPLoginEnabled( pPlayerData.iAccountSettings ) ) {
        
        pPlayerData.iAccountSettings <- pPlayerData.iAccountSettings & ~pPlayerData.iAccountSettings.AutoIPLogin
    
    } else {
    
        pPlayerData.iAccountSettings <- pPlayerData.iAccountSettings | pPlayerData.iAccountSettings.AutoIPLogin
        
    }
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function TogglePlayerAutoLUIDLogin ( pPlayer ) {
    
    local pPlayerData = UnitedIslands.Players [ pPlayer.ID ];

    if ( IsAutoLUIDLoginEnabled( pPlayerData.iAccountSettings ) ) {
        
        pPlayerData.iAccountSettings <- pPlayerData.iAccountSettings & ~pPlayerData.iAccountSettings.AutoLUIDLogin
    
    } else {
    
        pPlayerData.iAccountSettings <- pPlayerData.iAccountSettings | pPlayerData.iAccountSettings.AutoLUIDLogin
        
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function InitPlayer ( pPlayer ) {
    
    for ( local i = 0 ; i < 20 ; i++ ) {
    
        MessagePlayer ( " " , pPlayer );
    
    }
    
    UnitedIslands.Players [ pPlayer.ID ] <- UnitedIslands.Classes.PlayerData ( pPlayer );
    
    UnitedIslands.Players [ pPlayer.ID ].pPlayer = pPlayer;
    
    UnitedIslands.Players [ pPlayer.ID ].pSession = UnitedIslands.Classes.SessionData ( pPlayer );
        
    SendWelcomeMessage ( pPlayer );
    
    NewTimer ( "InitPlayerData" , 1000 , 1 , pPlayer );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function InitPlayerData ( pPlayer ) {

    if ( !pPlayer ) {
    
        return false;
    
    }
    
    LoadPlayerFromDatabase ( pPlayer );
    
    NewTimer ( "SendIsRegisteredWelcomeOnConnect" , 2500 , 1 , pPlayer );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function LoadPlayerCrimesFromDatabase ( pPlayerData ) {

    local pPlayerCrimes = [ ];

    return pPlayerCrimes;

}

// -------------------------------------------------------------------------------------------------

function LoadPlayerStaffNotesFromDatabase ( pPlayerData ) {

    local pPlayerStaffNotes = [ ];

    return pPlayerStaffNotes;

}

// -------------------------------------------------------------------------------------------------

function LoginCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    local pPlayerData = UnitedIslands.Players [ pPlayer.ID ];
    
    // -- Let's make sure they aren't already logged in :)
    
    if ( pPlayerData.bAuthenticated ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are already logged in!" );
    
        return false;
        
    }
    
    // -- When a player connects, the server attempts to load their account. If no account exists, their iDatabaseID defaults to 0
    // -- So, to check if a player is not registered, see if their iDatabaseID is 0. This prevents having to re-query the database.
    
    if ( pPlayerData.iDatabaseID == 0 ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are not registered! Use /register to make an account!" );
        
        return false;        
    
    }
    
    // -- Is the password correct?
    
    if ( pPlayerData.szPassword != SaltAccountPassword ( szParams , pPlayer.Name ) ) {
    
        pPlayerData.iLoginAttemptsRemaining--;
       
        SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "LoginFailed" ) , pPlayerData.iLoginAttemptsRemaining ) );
        
        return false;
        
    }
    
    // -- Check to see if the account only allows certain IP's or LUID's to use it.
    // -- If so, let's make sure the IP and LUID are allowed to use the account
    
    if ( IsAccountWhitelistEnabled ( pPlayerData.iAccountSettings ) ) {
    
        if ( !IsIPAllowedToUseAccount ( pPlayer.IP ) ) {
        
            SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "AccountIPNotAllowed" ) , pPlayer.IP ) );
            
            SendAccountWhitelistAlert ( pPlayer.Name , pPlayer.IP , pPlayer.LUID );
            
            return false;
        
        }
        
        if ( !IsLUIDAllowedToUseAccount ( pPlayer.IP ) ) {
        
            SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "AccountLUIDNotAllowed" ) , pPlayer.LUID ) );
            
            SendAccountWhitelistAlert ( pPlayer.Name , pPlayer.IP , pPlayer.LUID );
            
            return false;
        
        }        
    
    }
    
    // -- Everything seems to be in order. I'm going to go across the street and get you some orange shebert.
    // -- Oh, and the player can have some gum :D ---- Austin Powers, for those who don't get it.
    
    pPlayerData.bAuthenticated = true;
    
    SendPlayerSuccessMessage ( pPlayer , "You have been successfully logged in. Press left CTRL to spawn." );
    
    pPlayerData.bCanSpawn = true
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function IsAccountWhitelistEnabled ( iAccountSettings ) {

    if ( HasBitFlag ( iAccountSettings , UnitedIslands.BitFlags.AccountSettings.WhiteList ) ) {
    
        return true
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

// -- Needs finished

function IsIPAllowedToUseAccount ( iAccountDatabaseID , szIPAddress ) {
    
    return true;

}

// -------------------------------------------------------------------------------------------------

// -- Needs finished

function IsLUIDAllowedToUseAccount ( iAccountDatabaseID , szIPAddress ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

// -- Needs finished

function SendAccountWhitelistAlert ( iAccountDatabaseID , szIPAddress , szLUID ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

function RegisterCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    local pPlayerData = UnitedIslands.Players [ pPlayer.ID ];
    
    if ( pPlayerData.bAuthenticated ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are already logged in!" );
        
        return false;
    
    }
    
    if ( pPlayerData.iDatabaseID.tointeger ( ) != 0 ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are already registered! Use /login to access this account." );
        
        return false;
    
    }
    
    if ( !szParams ) {
        
        SendPlayerSyntaxMessage ( pPlayer , "/register <password>" );
        
        return false;
    
    }
    
    if ( ( szParams.len ( ) < UnitedIslands.Security.iMinPasswordLen ) && ( szParams.len ( ) > UnitedIslands.Security.iMaxPasswordLen ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "The password must be between " + UnitedIslands.Security.iMinPasswordLen + " and " + UnitedIslands.Security.iMaxPasswordLen + " characters" );
        
        return false;
    
    }
    
    if ( UnitedIslands.Security.bForcePasswordCaps ) {
    
        if ( !DoesStringContainCaps ( szParams ) ) {
        
            SendPlayerErrorMessage ( pPlayer , "The password must have at least 1 uppercase letter." );
        
            return false;
        
        }
    
    }
    
    if ( UnitedIslands.Security.bForcePasswordNumbers ) {
    
        if ( !DoesStringContainNumbers ( szParams ) ) {
        
            SendPlayerErrorMessage ( pPlayer , "The password must have at least 1 number." );
        
            return false;
        
        }
    
    }

    if ( UnitedIslands.Security.bForcePasswordSymbols ) {
    
        if ( !DoesStringContainSymbols ( szParams ) ) {
        
            SendPlayerErrorMessage ( pPlayer , "The password must have at least 1 symbol." );
        
            return false;
        
        }
    
    }
    
    pPlayerData.szPassword = SaltAccountPassword ( szParams , CreateSafeIniString ( pPlayer.Name ) );
    
    SavePlayerToDatabase ( pPlayer );
    
    SendPlayerSuccessMessage ( pPlayer , "Your account has been created! Please wait a moment ... " );
    
    NewTimer ( "LoadPlayerAfterRegister" , 2000 , 1 , pPlayer );
    
    return;
    
}

// -------------------------------------------------------------------------------------------------

function LoadPlayerAfterRegister ( pPlayer ) {

    LoadPlayerFromDatabase ( pPlayer );
    
    NewTimer ( "PlayerRegistrationComplete" , 2000 , 1 , pPlayer );

}

// -------------------------------------------------------------------------------------------------

function PlayerRegistrationComplete ( pPlayer ) {

    MessagePlayer ( " " , pPlayer );
    MessagePlayer ( "Your account is now ready to use. Please press left CTRL to spawn." , pPlayer , UnitedIslands.Colours.RGB.White );
    
    UnitedIslands.Players [ pPlayer.ID ].bAuthenticated = true;
    UnitedIslands.Players [ pPlayer.ID ].bCanSpawn = true;

}

// -------------------------------------------------------------------------------------------------

function SaltAccountPassword ( szPassword , szAccountName ) {

    if ( szPassword != "" && szAccountName != "" ) {
    
        return SHA256 ( "[UnitedIslandsRPG] . " + szAccountName + " . " + szPassword );
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerDatabaseID ( szName ) {

    local iAccountID = ReadIniInteger ( "Scripts/United Islands RPG/Data/Index.ini" , "Account Index" , CreateSafeIniString ( szName ) );
    
    if ( !iAccountID ) {
    
        return 0;
    
    }
    
    return iAccountID;
    
}

// -------------------------------------------------------------------------------------------------

function LoadPlayerFromDatabase ( pPlayer ) {

    local szName                            = CreateSafeIniString ( pPlayer.Name );
    local pPlayerData                       = UnitedIslands.Players [ pPlayer.ID ];
    
    pPlayerData.iDatabaseID                 = GetPlayerDatabaseID ( pPlayer.Name );
    
    if ( pPlayerData.iDatabaseID == "0" ) {
    
        return false;
    
    }
    
    pPlayerData.szFileString                = "Scripts/United Islands RPG/Data/Accounts/" + pPlayerData.iDatabaseID + ".ini";
    
    pPlayerData.szName                      = ReadIniString ( pPlayerData.szFileString , "General" , "szName" );
    pPlayerData.szPassword                  = ReadIniString ( pPlayerData.szFileString , "General" , "szPassword" );
    
    pPlayerData.iLastSession                = ReadIniInteger ( pPlayerData.szFileString , "General" , "szLastSession" );
    
    pPlayerData.iRegisteredTimestamp        = ReadIniInteger ( pPlayerData.szFileString , "General" , "iRegisteredTimestamp" );
    pPlayerData.iLastLoginTimestamp         = ReadIniInteger ( pPlayerData.szFileString , "General" , "ilastLoginTimestamp" );
    
    pPlayerData.iConnectTime                = ReadIniInteger ( pPlayerData.szFileString , "General" , "iConnecTime" );
    
    pPlayerData.iKills                      = ReadIniInteger ( pPlayerData.szFileString , "General" , "iKills" );
    pPlayerData.iDeaths                     = ReadIniInteger ( pPlayerData.szFileString , "General" , "iDeaths" );
    pPlayerData.iMaxKillStreak              = ReadIniInteger ( pPlayerData.szFileString , "General" , "iMaxKillStreak" );
    pPlayerData.iHeadshots                  = ReadIniInteger ( pPlayerData.szFileString , "General" , "iHeadshots" );
    pPlayerData.fFurthestHeadshot           = ReadIniFloat ( pPlayerData.szFileString , "General" , "fFurthestHeadshot" );
    pPlayerData.iPackagesPicked             = ReadIniInteger ( pPlayerData.szFileString , "General" , "iPackagesPicked" );
    
    pPlayerData.fDistanceOnFoot             = ReadIniFloat ( pPlayerData.szFileString , "General" , "fDistanceOnFoot" );
    pPlayerData.fDistanceCar                = ReadIniFloat ( pPlayerData.szFileString , "General" , "fDistanceCar" );
    pPlayerData.fDistanceBoat               = ReadIniFloat ( pPlayerData.szFileString , "General" , "fDistanceBoat" );
    pPlayerData.fDistancePlane              = ReadIniFloat ( pPlayerData.szFileString , "General" , "fDistancePlane" );
    
    pPlayerData.iHealthPicked               = ReadIniInteger ( pPlayerData.szFileString , "General" , "iHealthPicked" );
    pPlayerData.iArmourPicked               = ReadIniInteger ( pPlayerData.szFileString , "General" , "iArmourPicked" );
    pPlayerData.iWeaponsPicked              = ReadIniInteger ( pPlayerData.szFileString , "General" , "iWeaponsPicked" );
    
    pPlayerData.iCash                       = ReadIniInteger ( pPlayerData.szFileString , "General" , "iCash" );
    pPlayerData.iBank                       = ReadIniInteger ( pPlayerData.szFileString , "General" , "iBank" );
    
    pPlayerData.iSkin                       = ReadIniInteger ( pPlayerData.szFileString , "General" , "iSkin" );
    
    pPlayerData.iHealth                     = ReadIniInteger ( pPlayerData.szFileString , "General" , "iHealth" );
    pPlayerData.iArmour                     = ReadIniInteger ( pPlayerData.szFileString , "General" , "iArmour" );
    pPlayerData.iTimesBusted                = ReadIniInteger ( pPlayerData.szFileString , "General" , "iTimesBusted" );
    pPlayerData.iStarsObtained              = ReadIniInteger ( pPlayerData.szFileString , "General" , "iStarsObtained" );
    pPlayerData.iStarsEvaded                = ReadIniInteger ( pPlayerData.szFileString , "General" , "iStarsEvaded" );
    pPlayerData.iHighestWantedLevel         = ReadIniInteger ( pPlayerData.szFileString , "General" , "iHighestWantedLevel" );
    pPlayerData.iBusinessesPurchased        = ReadIniInteger ( pPlayerData.szFileString , "General" , "iBusinessesPurchased" );
    pPlayerData.iHousesPurchased            = ReadIniInteger ( pPlayerData.szFileString , "General" , "iHousesPurchased" );
    pPlayerData.iWeaponsPurchased           = ReadIniInteger ( pPlayerData.szFileString , "General" , "iWeaponsPurchased" );
    pPlayerData.iSpentOnWeapons             = ReadIniInteger ( pPlayerData.szFileString , "General" , "iSpentOnWeapons" );
    pPlayerData.iVehicleResprays            = ReadIniInteger ( pPlayerData.szFileString , "General" , "iVehicleResprays" );
    pPlayerData.iWantedVehicleResprays      = ReadIniInteger ( pPlayerData.szFileString , "General" , "iWantedVehicleResprays" );
    pPlayerData.iLongestGameTime            = ReadIniInteger ( pPlayerData.szFileString , "General" , "iLongestGameTime" );

    pPlayerData.pPosition                   = Vector ( ReadIniFloat( pPlayerData.szFileString , "General" , "fPositionX" ) , ReadIniFloat( pPlayerData.szFileString , "General" , "fPositionY" ) , ReadIniFloat( pPlayerData.szFileString , "General" , "fPositionZ" ) );
    pPlayerData.iAngle                      = ReadIniInteger( pPlayerData.szFileString , "General" , "iAngle" );

    pPlayerData.iAccountSettings            = ReadIniInteger( pPlayerData.szFileString , "General" , "iAccountSettings" );
    pPlayerData.iLicenses                   = ReadIniInteger( pPlayerData.szFileString , "General" , "iLicenses" );
    pPlayerData.iStaffFlags                 = ReadIniInteger( pPlayerData.szFileString , "General" , "iStaffFlags" );
    
    // pPlayerData.pCrimes                     = ::LoadAccountCrimesByAccountID ( iDatabaseID );
    
    // pPlayerData.pStaffNotes                 = ::LoadPlayerStaffNotesByAccountID ( iDatabaseID );

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function SetPlayerSkinCommand ( pPlayer , szCommand , szParams ) {

    local szTargetParam = false;
    local szSkinParam = false;

    if( !DoesPlayerHaveStaffPermission ( pPlayer , "ManagePlayerStats" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
        
        return false;
    
    }
    
    if( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/setskin <player name/id> <skin id>" );
        
        return false;
    
    }
    
    if( NumTok ( szParams , " " ) != 2 ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/setskin <player name/id> <skin id>" );
        
        return false;
    
    }    
    
    szTargetParam = GetTok ( szParams , " " , 1 );
    szSkinParam = GetTok ( szParams , " " , 2 );
    
    if ( !FindPlayer ( szTargetParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "That player is invalid." );
        
        return false;
    
    }
    
    if ( !IsNum ( szSkinParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "The skin ID must be a number!" );
        
        return false;    
    
    }
    
    szSkinParam = szSkinParam.tointeger ( );
    
    if ( !IsValidSkinID ( szSkinParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "That skin ID is invalid!" );
        
        return false;    
    
    }
    
    local pTarget = FindPlayer ( szTargetParam );
    
    SendPlayerSuccessMessage ( pPlayer , "You set " + pTarget.Name + "'s skin to ID " + szSkinParam );
    SendPlayerAlertMessage ( pTarget , pTarget.Name + " has set your skin to ID " + szSkinParam );
    
    SetPlayerSkin ( pTarget , szSkinParam );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SetPlayerSkin ( pPlayer , iSkinID ) {

    if ( !IsNum ( iSkinID ) ) {
    
        return false;
    
    }
    
    if ( !IsValidSkinID ( iSkinID ) ) {
    
        return false;
    
    }
    
    UnitedIslands.Players [ pPlayer.ID ].iSkin = iSkinID;
    pPlayer.Skin = UnitedIslands.Players [ pPlayer.ID ].iSkin;
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SetPlayerCash ( pPlayer , iCash ) {

    if ( !iCash.tointeger ( ) ) {
    
        return false;
    
    }

    UnitedIslands.Players [ pPlayer.ID ].iCash = iCash;
    pPlayer.Cash = UnitedIslands.Players [ pPlayer.ID ].iCash;
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function TakePlayerCash ( pPlayer , iCash ) {

    if ( !iCash.tointeger ( ) ) {
    
        return false;
    
    }

    UnitedIslands.Players [ pPlayer.ID ].iCash = UnitedIslands.Players [ pPlayer.ID ].iCash - iCash;
    pPlayer.Cash = UnitedIslands.Players [ pPlayer.ID ].iCash;
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerCash ( pPlayer , iCash ) {

    if ( !iCash.tointeger ( ) ) {
    
        return false;
    
    }

    UnitedIslands.Players [ pPlayer.ID ].iCash = UnitedIslands.Players [ pPlayer.ID ].iCash + iCash;
    pPlayer.Cash = UnitedIslands.Players [ pPlayer.ID ].iCash;
    
    return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Player]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------