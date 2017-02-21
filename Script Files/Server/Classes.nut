function InitClassesCoreTable ( ) {

	local pClassesCoreTable = { };
	
    pClassesCoreTable.PlayerData <- ::InitPlayerDataClass ( );
    pClassesCoreTable.BusinessData <- ::InitBusinessDataClass ( );
    pClassesCoreTable.SessionData <- ::InitSessionDataClass ( );
    pClassesCoreTable.HouseData <- ::InitHouseDataClass ( );
    pClassesCoreTable.ClanData <- ::InitClanDataClass ( );
    pClassesCoreTable.CrimeData <- ::InitCrimeDataClass ( );
	pClassesCoreTable.SessionData <- ::InitFireDataClass ( );
	pClassesCoreTable.VehicleData <- ::InitVehicleDataClass ( );

    return pClassesCoreTable;
    
}

// -------------------------------------------------------------------------------------------------

function InitPlayerDataClass ( ) {

    return class {
        
        pPlayer                     = false;
        
        szFileString                = "";
        
        bCanSpawn                   = false;
        bCanUseCommands             = false;
        
        iDatabaseID                 = ")";
        szName                      = "";
        szPassword                  = "";
        
        iLastSession                = 0;
		szLastIP 					= "";
		szLastLUID					= "";
        
        szConnectToken              = 0;
		iConnectTime 				= 0;
        
        iRegisteredTimestamp        = 0;
        iLastLoginTimestamp         = 0;
        
        iConnectTime                = 0;
        
        iKills                      = 0;
        iDeaths                     = 0;
        iMaxKillStreak              = 0;
        iHeadshots                  = 0;
        fFurthestHeadshot           = 0;
        iPackagesPicked             = 0;
        
        fDistanceOnFoot             = 0; 
        fDistanceCar                = 0;
        fDistanceBoat               = 0;
        fDistancePlane              = 0;
        
        iHealthPicked               = 0;
        iArmourPicked               = 0;
        iWeaponsPicked              = 0;
        
        iSkin                       = 0;
        
        iCash                       = 5000;
        iBank                       = 0;

        iCharacterLevel             = 0;
        iCharacterExperience        = 0;
        
        iJob                        = 0;
        
        iClan                       = 0;
        
        iHealth                     = 0;
        iArmour                     = 0;
        iTimesBusted                = 0;
        iStarsObtained              = 0;
        iStarsEvaded                = 0;
        iHighestWantedLevel         = 0;
        
        iBusinessesPurchased        = 0;
        iHousesPurchased            = 0;
        iWeaponsPurchased           = 0;
        
        iSpentOnWeapons             = 0;
        
        iVehicleResprays            = 0;
        iWantedVehicleResprays      = 0;
        
        iLongestGameTime            = 0;

        iCharacterLevel             = 0;
        iCharacterExperience        = 0;

        pPosition                   = ::Vector ( -763.80 , -603.30 , 11.33 );
        iAngle                      = 268.556;

        bMuted                      = false;
        bFrozen                     = false;
        
        iAccountSettings            = 0;
        iLicenses                   = 0;
        iStaffFlags                 = 0;
        
        iLastUpdate                 = 0;
        iPingKickTicks              = 0;
        iLoginAttemptsRemaining     = 0;
        iDeadIsland                 = 0;
        bDead                       = false;
        iSpawnBug                   = 0;
        iLastIdleCheck              = 0;
        iLastSpamWarning            = 0;
        iMuteStart                  = 0;
        
        pSession                    = false;
        bAuthenticated              = false;
        
        bTazerArmed                 = false;
        bTazed                      = false;
        bCuffed                     = false;
        
        pAntiCheatPosition          = ::Vector ( 0.0 , 0.0 , 0.0 );
        
        pCrimes                     = [ ];
        
        pStaffNotes                 = [ ];
        
        pRentingVehicle             = false;
        
        iLocale                     = 0;
        
        constructor ( pPlayer ) {
            
            pPlayer                     = pPlayer;
            
        }
        
    };
    
}

// -------------------------------------------------------------------------------------------------

function InitSessionDataClass ( ) {
    
    return class {
        
        iConnectedTime              = 0;
        iDisconnectedTime           = 0;
        
        szName                      = "";
        szLUID                      = "";
        szIP                        = "";
        
        pPlayer                     = false;
        
        constructor ( pPlayer ) {
            
            iConnectedTime              = ::time ( );
            
            szName                      = pPlayer.Name;
            szIP                        = pPlayer.IP;
            szLUID                      = pPlayer.LUID;
            
            pPlayer                     = pPlayer;
            
        }
        
    };

    return true;
    
}
    
// -------------------------------------------------------------------------------------------------

function InitCrimeDataClass ( ) {

    return class {

        iCrimeID                    = 0;
        iSuspectAccountID           = 0;
        
        szCrimeName                 = "Unknown";
        szCrimeDetails              = "None";
        
        iAddedTimestamp             = 0;
        iAddedWantedLevel           = 0;
        iAddedByAccountID           = 0;
        
        bServedSentence             = false;
        iSentenceType               = 0;
        iSentenceValue              = 0;
        
        constructor ( ) {
            
        }

    }

    return true;
    
}
    
// -------------------------------------------------------------------------------------------------

function InitClanDataClass ( ) {
    
    return class {

        iDatabaseID                 = 0;
        szName                      = "";
        szTag                       = "";
        szMotto                     = "";
        
        pAllowedVehicles            = [ ];
        pMembers                    = [ ];
        pAlliances                  = [ ];
        pTerritories                = [ ];
        
        iJoinType                   = 0;
        
        constructor ( ) {
        
        }

    }

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function InitBusinessDataClass ( ) {

    return class {
        
        iDatabaseID                 = 0;
        szName                      = "";
        bLocked                     = true;
        
        iBuyPrice                   = 0;
        
        iOwnerType                  = 0;
        iOwnerID                    = 0;
        
        pPickup                     = false;

        pPosition                   = ::Vector ( 0.0 , 0.0 , 0.0 );
        
        constructor ( ) {
            
        }
        
    }

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function InitVehicleDataClass ( ) {
    
    return class {
        
        szFileString                = "";
        
        iDatabaseID                 = 0;
        iModel                      = 0;
        pVehicle                    = false;
        
        // -- The Colour instances don't work properly, so we'll define the colours manually in a table
        pColour1                    = { r = 0 , g = 0 , b = 0 };
        pColour2                    = { r = 0 , g = 0 , b = 0 };
        
        pPosition                   = ::Vector ( 0.0 , 0.0 , 0.0 );
        pRotation                   = ::Vector ( 0.0 , 0.0 , 0.0 );
        fAngle                      = 0.0;
        
        iOwnerType                  = 0;
        iOwnerID                    = 0;
        
        iBuyPrice                   = 0;
        iRentPrice                  = 0;
        
        bEngine                     = false;
        bLocked                     = false;
        bLightState                 = false;
        bSirenLight                 = false;
        bTaxiLight                  = false;
        bSiren                      = false;                 
        
        fHealth                     = 0;
        fEngineDamage               = 0;
        
        pRenter                     = false;
        
        constructor ( ) {
        
        }
        
    }
    
    return true;
    
}
    
// -------------------------------------------------------------------------------------------------

function InitHouseDataClass ( ) {

    return class {
        
        iDatabaseID                 = 0;
        bLocked                     = true;
        
        iBuyPrice                   = 0;
        
        iOwnerType                  = 0;
        iOwnerID                    = 0;
        
        pPickup                     = false;
        
        pPosition                   = ::Vector ( 0.0 , 0.0 , 0.0 );
        
        constructor ( ) {
            
        }
        
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function InitFireDataClass ( ) {

   return class {
        
        pPosition                     = ::Vector ( 0.0 , 0.0 , 0.0 );
        pAttached                     = false;

        iFireType                     = 0;
        iStart                        = 0;

        iRadius                       = 0;

        pFire                         = false;

        constructor ( ) {

        }

    }

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Classes]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------