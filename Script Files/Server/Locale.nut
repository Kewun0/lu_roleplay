function InitLocaleGlobalTable ( ) {

    local pLocaleTable = [ 

        // 0 - English
        {
        
            ErrorMessageHeader = "ERROR" ,
            SyntaxMessageHeader = "USAGE" ,
            SuccessMessageHeader = "SUCCESS" ,
            AlertMessageHeader = "ALERT" ,
            AdminAnnounceHeader = "ADMIN" , 
            
			CommandInfoHeader = "USAGE" , 
			CommandAliasesHeader = "ALIAS" ,
			CommandExtraInfoHeader = "EXTRA" ,
			
            RandomHints = [

                "You can check your stats at any time with /stats" , 
                "Collect hidden packages for extra cash!" , 
                "Liberty City is a high-crime place. Buy a gun and protect yourself!" , 
                "Fun fact ... The police cause more crime than the criminals!" , 
                "Don't forget to exit the game when you're done playing!" , 
                "Remember, life has no /q command ... Don't bring the game to the real world :)" , 
                "What happens in this server, stays on YouTube"         
            
            ] ,
            
            NoCommandPermission = "You do not have permission to use this command!" ,
			UnknownCommand = "Unknown command!" ,
            MustBeNumber = "The %s must be a number!" , 
            MustBeBetween = "The %s must be between %d and %d characters" ,
            CommandSpamWait = "You must wait %d seconds before using another command." ,
            CommandSpamAlert = "You have been blocked from using commands for %d seconds." ,
            CommandSpamWarn = "Please do not spam commands!" ,
            
            PartReasons = [
            
                "Left" ,
                "Crashed" , 
                "Timed Out" , 
                "Kicked" , 
                "Banned"
            ] ,         
            
            CardinalDirections = [
            
                "North" , 
                "Northeast" , 
                "East" , 
                "Southeast" , 
                "South" , 
                "Southwest" , 
                "West" , 
                "Northwest" , 
                "Unknown"
            
            ] , 
            
            Weekdays = [
            
                "Sunday" , 
                "Monday" , 
                "Tuesday" , 
                "Wednesday" , 
                "Thursday" , 
                "Friday" , 
                "Saturday"
            
            ] , 
            
            Months = [
                "January" , 
                "February" , 
                "March" , 
                "April" , 
                "May" , 
                "June" , 
                "July" , 
                "August" , 
                "September" , 
                "October" , 
                "November" , 
                "December"
            
            ] , 
            
            VehicleIsLocked = "This vehicle is locked!" , 
            
            VehicleLocked = "The %s's doors have been locked" , 
            VehicleUnlocked = "The %s's doors have been unlocked" , 
            VehicleLightsOn = "The %s's lights have been turned on" , 
            VehicleLightsOff = "The %s's lights have been turned off" , 
            VehicleSirenLightOn = "The %s's siren light has been turned on" , 
            VehicleSirenLightOff = "The %s's siren light has been turned off" ,         
            VehicleTaxiLightOn = "The %s's taxi light has been turned on" , 
            VehicleTaxiLightOff = "The %s's taxi light has been turned off" , 
            VehicleSirenOn = "The %s's siren has been turned on" , 
            VehicleSirenOff = "The %s's siren has been turned off" , 
            VehicleEngineOn = "The %s's engine has been turned on" , 
            VehicleEngineOff = "The %s's engine has been turned off" ,

            NotAtPoliceStation = "You are not at a police station!" , 
            NotAtHospital =  "You are not at a hospital!" , 
            NotAtFireStation = "You are not at a fire station!" , 
            NotAtCarDealer = "You are not at a car dealership!" , 
            NotAtAnyBusiness = "You are not at any business!" , 
            
            PlayerNotFound = "That player could not be found!" , 
            VehicleNotFound = "That vehicle does not exist!" , 
            HouseNotFound = "That house does not exist!" , 
            BusinessNotFound = "That business does not exist!" , 
            
            LoginFailed = "You entered an invalid password. You have %d login attempts remaining." , 
            LoginAttemptsRemaining = "You have %d login attempts remaining." , 
            
			AllVehiclesExploded = "All vehicles exploded by %s",
			AllVehiclesRespawned = "All vehicles exploded by %s",
			AllVehiclesLocked = "All vehicles locked by %s",
			AllVehiclesUnlocked = "All vehicles unlocked by %s",
			
			TakeJobSuccessful = "You now have the %s job! Use /Help Job for info." );
			
            LastItem = false 
            
        }

    ];
    
    return pLocaleTable;
    
}

// -------------------------------------------------------------------------------------------------

function GetPlayerLocaleMessage ( pPlayer , szMessageType ) {

    local pPlayerData = GetPlayerData ( pPlayer );

    return GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szMessageType ];
    
}

// -------------------------------------------------------------------------------------------------

function GetPlayerGroupedLocaleMessage ( pPlayer , szGroup ) {

    local pPlayerData = GetPlayerData ( pPlayer );
    local pMessages = [ ];

    foreach ( ii , iv in GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szGroup ] ) {
    
        pMessages.push ( iv );
    
    }
    
    return pMessages;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Locale]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------