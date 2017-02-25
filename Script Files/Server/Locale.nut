// -------------------------------------------------------------------------------------------------

function InitLocaleGlobalTable ( ) {

	// 0 - English
	// 1 - Spanish
	// 2 - Russian
	// 3 - Dutch
	// 4 - Croatian
	
	local pLocaleTable = [ 

		// 0 - English
		{
		
			WelcomeToServer = "Welcome to Life in Liberty City RP.",
			ServerUnderDevelopment = "This server is under development, and may restart often" , 
			PleaseWaitAccountLoading = "Please wait while your account is loaded ..." , 
			
			AlreadyRegistered = "You are already registered! Use /login to access this account."
			AccountCreated = "Your account has been created! Please wait a moment ..."
			AlreadyLoggedIn = "You are already logged in!"
			AccountReadyToUse = "Your account is now ready to use. Please press left CTRL to spawn."
			
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
			
			JobHelpUnemployed = [
			
				"== Job Help =================================" , 
				"- Jobs are a good way to make money." , 
				"- Visit any job site, and use /takejob to get a job."
			
			] , 
			
			VehicleHelp = [
			
				"== Vehicle Help =============================" , 
				"- Visit the dealership in Portland to buy vehicles." , 
				"- Use /lock to unlock your car." , 
				"- The /lights command can turn on and off your headlights." , 
				"- To turn an engine on or off, use /engine" , 
				"- To sell your car to another player, use /sellcar"
			
			] , 
			
			AccountHelp = [ 
			
				"== Account Help =============================" , 
				"- Do not share your password with anybody else." , 
				"- The server staff will never ask for your password." , 
				"- Use /iplogin or /luidlogin to automatically log you in with your IP or LUID" , 
				"- Use /changepass to change your password."		
			
			] , 
			
			NoCommandPermission = "You do not have permission to use this command!" ,
			UnknownCommand = "Unknown command!" ,
			MustBeNumber = "The %s must be a number!" , 
			MustBeBetween = "The %s must be between %d and %d characters" ,
			MustHaveCaps = "The %s must have at least 1 uppercase letter." , 
			MustHaveNumber = "The %s must have at least 1 number." , 
			MustHaveSymbol = "The %s must have at least 1 special symbol." , 
			CommandSpamWait = "You must wait %d seconds before using another command." ,
			CommandSpamAlert = "You have been blocked from using commands for %d seconds." ,
			CommandSpamWarn = "Please do not spam commands!" , 
			YouAreMuted = "You are muted, and cannot speak or use commands!" , 
			
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
			LoginFailed = "You entered an invalid password too many times!" , 
			LoginAttemptsRemaining = "You have %d login attempts remaining." , 
			
			AllVehiclesExploded = "All vehicles exploded by %s",
			AllVehiclesRespawned = "All vehicles exploded by %s",
			AllVehiclesLocked = "All vehicles locked by %s",
			AllVehiclesUnlocked = "All vehicles unlocked by %s",
			
			TakeJobSuccessful = "You now have the %s job! Use /Help Job for info.",
			
			LoggedInByIP = "Welcome back, %s. You have been automatically logged in with your IP!",
			LoggedInByLUID = "Welcome back, %s. You have been automatically logged in with your LUID!",
			
			CommandUsageDescShout = "Shouts to nearby players" , 
			CommandUsageDescTalk = "Talks to nearby players." , 
			CommandUsageDescLogin = "Allows you to login to your account" , 
			CommandUsageDescChangePass = "Allows you to change your password" , 
			CommandUsageDescRegister = "Allows you to create an account" , 
			CommandUsageDescIPLogin = "Toggles ON/OFF automatic login by IP." , 
			CommandUsageDescLUIDLogin = "Toggles ON/OFF automatic login by LUID." , 
			CommandUsageDescPM = "Sends a private message to another player" , 
			CommandUsageDescBug = "Reports a bug to the scripters" , 
			CommandUsageDescIdea = "Submits an idea to the scripters" , 
			CommandUsageDescBan = "Bans a player from the server" , 
			CommandUsageDescTempBan = "Temporarily bans a player from the server" , 
			CommandUsageDescKick = "Kicks a player from the server" , 
			CommandUsageDescMute = "Mutes a player. Keeps them from using any chat." , 
			CommandUsageDescUnmute = "Unmutes a player so they can use chat again." , 
			CommandUsageDescFreeze = "Freezes a player so they can't move." , 
			CommandUsageDescUnfreeze = "Unfreezes a player so they can move again." , 
			CommandUsageDescGoto = "Teleports you to a player" , 
			CommandUsageDescGotoVeh = "Teleports you to a vehicle." , 
			CommandUsageDescGiveStaffFlag = "Gives a staff flag to a player" , 
			CommandUsageDescTakeStaffFlag = "Takes a staff flag from a player" , 
			CommandUsageDescStaffFlags = "Shows a list of all staff flags." , 
			CommandUsageDescReport = "Reports a player or message to admins" , 
			CommandUsageDescReports = "Shows all unhandled staff reports" , 
			CommandUsageDescAR = "Accepts a report submitted by a player" , 
			CommandUsageDescDR = "Denies a report submitted by a player" , 
			CommandUsageDescForumReport = "Sets a report as needing to be put on forum" , 
			CommandUsageDescResetReport = "Resets a handled staff report to handle it again" , 
			
			CommandExtraDescIPLogin = "Only uses your last IP to automatically login" , 
			CommandExtraDescLUIDLogin = "Only uses your last LUID to automatically login" , 
			CommandExtraDescMute = "This also blocks chat-related commands (ME, DO, etc)" , 
			CommandExtraDescGoto = "You can provide offset X, Y, and Z." , 
			CommandExtraDescFreeze = "They can still look around with their mouse." , 
			
			IPLoginON = "You will now be logged in by your IP." , 
			IPLoginOFF = "You will not be logged in by your IP." , 
			LUIDLoginON = "You will now be logged in by your LUID." , 
			LUIDLoginOFF = "You will not be logged in by your LUID." , 
			
			LastItem = false 
			
		}
		
		// 0 - Spanish
		{
		
			WelcomeToServer = "Welcome to Life in Liberty City RP.",
			ServerUnderDevelopment = "This server is under development, and may restart often" , 
			PleaseWaitAccountLoading = "Please wait while your account is loaded ..." , 
			
			AlreadyRegistered = "You are already registered! Use /login to access this account."
			AccountCreated = "Your account has been created! Please wait a moment ..."
			AlreadyLoggedIn = "You are already logged in!"
			AccountReadyToUse = "Your account is now ready to use. Please press left CTRL to spawn."
			
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
			
			JobHelpUnemployed = [
			
				"== Job Help =================================" , 
				"- Jobs are a good way to make money." , 
				"- Visit any job site, and use /takejob to get a job."
			
			] , 
			
			VehicleHelp = [
			
				"== Vehicle Help =============================" , 
				"- Visit the dealership in Portland to buy vehicles." , 
				"- Use /lock to unlock your car." , 
				"- The /lights command can turn on and off your headlights." , 
				"- To turn an engine on or off, use /engine" , 
				"- To sell your car to another player, use /sellcar"
			
			] , 
			
			AccountHelp = [ 
			
				"== Account Help =============================" , 
				"- Do not share your password with anybody else." , 
				"- The server staff will never ask for your password." , 
				"- Use /iplogin or /luidlogin to automatically log you in with your IP or LUID" , 
				"- Use /changepass to change your password."		
			
			] , 
			
			NoCommandPermission = "You do not have permission to use this command!" ,
			UnknownCommand = "Unknown command!" ,
			MustBeNumber = "The %s must be a number!" , 
			MustBeBetween = "The %s must be between %d and %d characters" ,
			MustHaveCaps = "The %s must have at least 1 uppercase letter." , 
			MustHaveNumber = "The %s must have at least 1 number." , 
			MustHaveSymbol = "The %s must have at least 1 special symbol." , 
			CommandSpamWait = "You must wait %d seconds before using another command." ,
			CommandSpamAlert = "You have been blocked from using commands for %d seconds." ,
			CommandSpamWarn = "Please do not spam commands!" , 
			YouAreMuted = "You are muted, and cannot speak or use commands!" , 
			
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
			LoginFailed = "You entered an invalid password too many times!" , 
			LoginAttemptsRemaining = "You have %d login attempts remaining." , 
			
			AllVehiclesExploded = "All vehicles exploded by %s",
			AllVehiclesRespawned = "All vehicles exploded by %s",
			AllVehiclesLocked = "All vehicles locked by %s",
			AllVehiclesUnlocked = "All vehicles unlocked by %s",
			
			TakeJobSuccessful = "You now have the %s job! Use /Help Job for info.",
			
			LoggedInByIP = "Welcome back, %s. You have been automatically logged in with your IP!",
			LoggedInByLUID = "Welcome back, %s. You have been automatically logged in with your LUID!",
			
			CommandUsageDescShout = "Shouts to nearby players" , 
			CommandUsageDescTalk = "Talks to nearby players." , 
			CommandUsageDescLogin = "Allows you to login to your account" , 
			CommandUsageDescChangePass = "Allows you to change your password" , 
			CommandUsageDescRegister = "Allows you to create an account" , 
			CommandUsageDescIPLogin = "Toggles ON/OFF automatic login by IP." , 
			CommandUsageDescLUIDLogin = "Toggles ON/OFF automatic login by LUID." , 
			CommandUsageDescPM = "Sends a private message to another player" , 
			CommandUsageDescBug = "Reports a bug to the scripters" , 
			CommandUsageDescIdea = "Submits an idea to the scripters" , 
			CommandUsageDescBan = "Bans a player from the server" , 
			CommandUsageDescTempBan = "Temporarily bans a player from the server" , 
			CommandUsageDescKick = "Kicks a player from the server" , 
			CommandUsageDescMute = "Mutes a player. Keeps them from using any chat." , 
			CommandUsageDescUnmute = "Unmutes a player so they can use chat again." , 
			CommandUsageDescFreeze = "Freezes a player so they can't move." , 
			CommandUsageDescUnfreeze = "Unfreezes a player so they can move again." , 
			CommandUsageDescGoto = "Teleports you to a player" , 
			CommandUsageDescGotoVeh = "Teleports you to a vehicle." , 
			CommandUsageDescGiveStaffFlag = "Gives a staff flag to a player" , 
			CommandUsageDescTakeStaffFlag = "Takes a staff flag from a player" , 
			CommandUsageDescStaffFlags = "Shows a list of all staff flags." , 
			CommandUsageDescReport = "Reports a player or message to admins" , 
			CommandUsageDescReports = "Shows all unhandled staff reports" , 
			CommandUsageDescAR = "Accepts a report submitted by a player" , 
			CommandUsageDescDR = "Denies a report submitted by a player" , 
			CommandUsageDescForumReport = "Sets a report as needing to be put on forum" , 
			CommandUsageDescResetReport = "Resets a handled staff report to handle it again" , 
			
			CommandExtraDescIPLogin = "Only uses your last IP to automatically login" , 
			CommandExtraDescLUIDLogin = "Only uses your last LUID to automatically login" , 
			CommandExtraDescMute = "This also blocks chat-related commands (ME, DO, etc)" , 
			CommandExtraDescGoto = "You can provide offset X, Y, and Z." , 
			CommandExtraDescFreeze = "They can still look around with their mouse." , 
			
			IPLoginON = "You will now be logged in by your IP." , 
			IPLoginOFF = "You will not be logged in by your IP." , 
			LUIDLoginON = "You will now be logged in by your LUID." , 
			LUIDLoginOFF = "You will not be logged in by your LUID." , 
			
			LastItem = false 
			
		}
		
		// 2 - Russian
		{
		
			WelcomeToServer = "Welcome to Life in Liberty City RP.",
			ServerUnderDevelopment = "This server is under development, and may restart often" , 
			PleaseWaitAccountLoading = "Please wait while your account is loaded ..." , 
			
			AlreadyRegistered = "You are already registered! Use /login to access this account."
			AccountCreated = "Your account has been created! Please wait a moment ..."
			AlreadyLoggedIn = "You are already logged in!"
			AccountReadyToUse = "Your account is now ready to use. Please press left CTRL to spawn."
			
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
			
			JobHelpUnemployed = [
			
				"== Job Help =================================" , 
				"- Jobs are a good way to make money." , 
				"- Visit any job site, and use /takejob to get a job."
			
			] , 
			
			VehicleHelp = [
			
				"== Vehicle Help =============================" , 
				"- Visit the dealership in Portland to buy vehicles." , 
				"- Use /lock to unlock your car." , 
				"- The /lights command can turn on and off your headlights." , 
				"- To turn an engine on or off, use /engine" , 
				"- To sell your car to another player, use /sellcar"
			
			] , 
			
			AccountHelp = [ 
			
				"== Account Help =============================" , 
				"- Do not share your password with anybody else." , 
				"- The server staff will never ask for your password." , 
				"- Use /iplogin or /luidlogin to automatically log you in with your IP or LUID" , 
				"- Use /changepass to change your password."		
			
			] , 
			
			NoCommandPermission = "You do not have permission to use this command!" ,
			UnknownCommand = "Unknown command!" ,
			MustBeNumber = "The %s must be a number!" , 
			MustBeBetween = "The %s must be between %d and %d characters" ,
			MustHaveCaps = "The %s must have at least 1 uppercase letter." , 
			MustHaveNumber = "The %s must have at least 1 number." , 
			MustHaveSymbol = "The %s must have at least 1 special symbol." , 
			CommandSpamWait = "You must wait %d seconds before using another command." ,
			CommandSpamAlert = "You have been blocked from using commands for %d seconds." ,
			CommandSpamWarn = "Please do not spam commands!" , 
			YouAreMuted = "You are muted, and cannot speak or use commands!" , 
			
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
			LoginFailed = "You entered an invalid password too many times!" , 
			LoginAttemptsRemaining = "You have %d login attempts remaining." , 
			
			AllVehiclesExploded = "All vehicles exploded by %s",
			AllVehiclesRespawned = "All vehicles exploded by %s",
			AllVehiclesLocked = "All vehicles locked by %s",
			AllVehiclesUnlocked = "All vehicles unlocked by %s",
			
			TakeJobSuccessful = "You now have the %s job! Use /Help Job for info.",
			
			LoggedInByIP = "Welcome back, %s. You have been automatically logged in with your IP!",
			LoggedInByLUID = "Welcome back, %s. You have been automatically logged in with your LUID!",
			
			CommandUsageDescShout = "Shouts to nearby players" , 
			CommandUsageDescTalk = "Talks to nearby players." , 
			CommandUsageDescLogin = "Allows you to login to your account" , 
			CommandUsageDescChangePass = "Allows you to change your password" , 
			CommandUsageDescRegister = "Allows you to create an account" , 
			CommandUsageDescIPLogin = "Toggles ON/OFF automatic login by IP." , 
			CommandUsageDescLUIDLogin = "Toggles ON/OFF automatic login by LUID." , 
			CommandUsageDescPM = "Sends a private message to another player" , 
			CommandUsageDescBug = "Reports a bug to the scripters" , 
			CommandUsageDescIdea = "Submits an idea to the scripters" , 
			CommandUsageDescBan = "Bans a player from the server" , 
			CommandUsageDescTempBan = "Temporarily bans a player from the server" , 
			CommandUsageDescKick = "Kicks a player from the server" , 
			CommandUsageDescMute = "Mutes a player. Keeps them from using any chat." , 
			CommandUsageDescUnmute = "Unmutes a player so they can use chat again." , 
			CommandUsageDescFreeze = "Freezes a player so they can't move." , 
			CommandUsageDescUnfreeze = "Unfreezes a player so they can move again." , 
			CommandUsageDescGoto = "Teleports you to a player" , 
			CommandUsageDescGotoVeh = "Teleports you to a vehicle." , 
			CommandUsageDescGiveStaffFlag = "Gives a staff flag to a player" , 
			CommandUsageDescTakeStaffFlag = "Takes a staff flag from a player" , 
			CommandUsageDescStaffFlags = "Shows a list of all staff flags." , 
			CommandUsageDescReport = "Reports a player or message to admins" , 
			CommandUsageDescReports = "Shows all unhandled staff reports" , 
			CommandUsageDescAR = "Accepts a report submitted by a player" , 
			CommandUsageDescDR = "Denies a report submitted by a player" , 
			CommandUsageDescForumReport = "Sets a report as needing to be put on forum" , 
			CommandUsageDescResetReport = "Resets a handled staff report to handle it again" , 
			
			CommandExtraDescIPLogin = "Only uses your last IP to automatically login" , 
			CommandExtraDescLUIDLogin = "Only uses your last LUID to automatically login" , 
			CommandExtraDescMute = "This also blocks chat-related commands (ME, DO, etc)" , 
			CommandExtraDescGoto = "You can provide offset X, Y, and Z." , 
			CommandExtraDescFreeze = "They can still look around with their mouse." , 
			
			IPLoginON = "You will now be logged in by your IP." , 
			IPLoginOFF = "You will not be logged in by your IP." , 
			LUIDLoginON = "You will now be logged in by your LUID." , 
			LUIDLoginOFF = "You will not be logged in by your LUID." , 
			
			LastItem = false 
			
		} ,		
		
		// 3 - Dutch
		{
		
			WelcomeToServer = "Welkom tot de Life in Liberty City RP.",
			ServerUnderDevelopment = "Deze server is nog in ontwikkeling, en kan regelmatig opnieuw worden opgestart" , 
			PleaseWaitAccountLoading = "Wacht terwijl je account wordt geladen ..." , 
			
			AlreadyRegistered = "Je bent al geregistreerd! Gebruik /login om toegang te krijgen."
			AccountCreated = "Je account is aangemaakt! Even wachten aub ..."
			AlreadyLoggedIn = "Je bent al ingelogd"
			AccountReadyToUse = "Je account is nu klaar voor gebruik. Druk op CTRL om te spawnen"
			
			ErrorMessageHeader = "FOUT" ,
			SyntaxMessageHeader = "GEBRUIK" ,
			SuccessMessageHeader = "SUCCES" ,
			AlertMessageHeader = "WAARSCHUWING" ,
			AdminAnnounceHeader = "ADMIN" , 
			
			CommandInfoHeader = "GEBRUIK" , 
			CommandAliasesHeader = "ALIAS" ,
			CommandExtraInfoHeader = "EXTRA" ,
			
			RandomHints = [

				"Je kunt op elk moment je statistieken bekijken /stats" , 
				"Vind verborgen pakketen voor extra geld!" , 
				"In Liberty City heerst criminaliteit. Koop een wapen en verdedig jezelf" , 
				"Fun fact ... De politie is crimineler dan de criminelen" , 
				"Vergeet het spel niet af te sluiten wanneer je klaar bent met spelen" , 
				"Onthoudt, het leven heeft geen /q commando ... Breng het spel niet naar de echte wereld :)" , 
				"What happens in this server, stays on YouTube"		 
			
			] , 
			
			JobHelpUnemployed = [
			
				"== Banen Help =================================" , 
				"- Banen zijn een goede manier om geld te verdienen." , 
				"- Bezoek een werkplek en gebruik /takejob om de baan te krijgen"
			
			] , 
			
			VehicleHelp = [
			
				"== Voortuigen Help =============================" , 
				"- Bezoek de autodealer in Portland om auto's te kopen" , 
				"- Gebruik /lock om je auto op slot te doen" , 
				"- Gebruik /lights om je autolampen aan of uit te zetten" , 
				"- Gebruik /engine om je motor af te zetten" , 
				"- Gebruik /sellcar om je auto aan een andere speler te verkopen"
			
			] , 
			
			AccountHelp = [ 
			
				"== Account Help =============================" , 
				"- Houd je wachtwoord voor jezelf" , 
				"- De server staff zal nooit om je wachtwoord vragen" , 
				"- Gebruik /iplogin of /luidlogin om automatisch in te loggen met je IP of LUID" , 
				"- Use /changepass to change your password."		
			
			] , 
			
			NoCommandPermission = "Je hebt geen toestemming om dit commando te gebruiken!" ,
			UnknownCommand = "Onbekend commando!" ,
			MustBeNumber = "De %s moet een nummer zijn!" , 
			MustBeBetween = "De %s moet tussen %d en %d karakters zijn." ,
			MustHaveCaps = "De %s moet tenminste 1 hoofdletter bevatten." , 
			MustHaveNumber = "De %s moet tenminste 1 nummer bevatten." , 
			MustHaveSymbol = "De %s moet tenminste 1 speciaal teken bevatten." , 
			CommandSpamWait = "Je moet %d seconden wachten voor je een nieuw commando kunt gebruiken" ,
			CommandSpamAlert = "Je bent geblokkeerd voor het gebruiken van dit commando voor %d seconden." ,
			CommandSpamWarn = "Spam aub geen commando's!" , 
			YouAreMuted = "Je bent gemute en kunt niet praten of commando's gebruiken." , 
			
			PartReasons = [
			
				"Verlaten" ,
				"Gecrashed" , 
				"Timeout" , 
				"Gekicked" , 
				"Verbannen"
			] ,
			
			CardinalDirections = [
			
				"Noord" , 
				"Noordoost" , 
				"Oost" , 
				"Zuidoost" , 
				"Zuid" , 
				"Zuidwest" , 
				"West" , 
				"Noordwest" , 
				"Onbekend"
			
			] , 
			
			Weekdays = [
			
				"Zondag" , 
				"Maandag" , 
				"Dinsdag" , 
				"Woensdag" , 
				"Donderdag" , 
				"Vrijdag" , 
				"Zaterdag"
			
			] , 
			
			Months = [

				"Januari" , 
				"Februari" , 
				"Maart" , 
				"April" , 
				"Mei" , 
				"Juni" , 
				"Juli" , 
				"Augustus" , 
				"September" , 
				"Oktober" , 
				"November" , 
				"December"
			
			] , 
			
			
			
			VehicleIsLocked = "Deze wagen zit op slot!" , 
			
			VehicleLocked = "De deuren van de %s's zijn op slot gezet" , 
			VehicleUnlocked = "De deuren van de %s's zijn niet meer op slot" , 
			VehicleLightsOn = "De verlichting van de %s's zijn aangezet" , 
			VehicleLightsOff = "De verlichting van de %s's is uitgezet" , 
			VehicleSirenLightOn = "De zwaailamp van de %s's is aangezet" , 
			VehicleSirenLightOff = "De zwaailamp van de %s's is uitgezet" ,		 
			VehicleTaxiLightOn = "Het taxilicht van de %s's is aangezet" , 
			VehicleTaxiLightOff = "Het taxilicht van de %s's is uitgezet" , 
			VehicleSirenOn = "De sirene van de %s's is aangezet" , 
			VehicleSirenOff = "De sirene van de %s's is uitgezet" , 
			VehicleEngineOn = "De motor van de %s's is gestart" , 
			VehicleEngineOff = "De motor van de %s's is afgezet" ,

			NotAtPoliceStation = "Je bent niet bij een politiebureau!" , 
			NotAtHospital =  "Je bent niet bij een ziekenhuis!" , 
			NotAtFireStation = "Je bent niet bij een brandweerkazerne!" , 
			NotAtCarDealer = "Je bent niet bij een autodealer!" , 
			NotAtAnyBusiness = "Je bent niet bij een werkplek!" , 
			
			PlayerNotFound = "Die speler kon niet worden gevonden!" , 
			VehicleNotFound = "Dat voertuig bestaat niet!" , 
			HouseNotFound = "Dat huis bestaat niet!" , 
			BusinessNotFound = "Die werkplek bestaat niet!" , 
			
			LoginFailed = "Je hebt een ongeldig wachtwoord ingevuld. Je kunt het nog %d keer proberen." , 
			LoginFailed = "Je hebt te vaak een ongeldig wachtwoord ingevuld!" , 
			LoginAttemptsRemaining = "Je kunt nog %d keer proberen in te loggen." , 
			
			AllVehiclesExploded = "Alle voertuigen opgeblazen door %s",
			AllVehiclesRespawned = "Alle voertuigen gerespawned door %s",
			AllVehiclesLocked = "Alle voertuigen op slot gedaan door %s",
			AllVehiclesUnlocked = "Alle voertuigen van het slot gehaald door %s",
			
			TakeJobSuccessful = "Je hebt nu de %s baan! Gebruik /Help Job voor info.",
			
			LoggedInByIP = "Welkom terug, %s. Je bent automatisch ingelogd met je IP",
			LoggedInByLUID = "Welkom terug, %s. Je bent automatisch ingelogd met je LUID!",
			
			CommandUsageDescShout = "Schreeuwd naar dichtbijzijnde spelers" , 
			CommandUsageDescTalk = "Praat tegen dichtbijzijnde spelers" , 
			CommandUsageDescLogin = "Laat je inloggen tot je account" , 
			CommandUsageDescChangePass = "Laat je je wachtwoord veranderen" , 
			CommandUsageDescRegister = "Laat je een account aanmaken" , 
			CommandUsageDescIPLogin = "Zet automatisch inloggen via IP AAN/UIT." , 
			CommandUsageDescLUIDLogin = "Zet automatisch inloggen via LUID AAN/UIT" , 
			CommandUsageDescPM = "Verstuurd een privebericht naar een andere speler" , 
			CommandUsageDescBug = "Verstuurd een bugreport naar de scripters" , 
			CommandUsageDescIdea = "Verstuurd een idee naar de scripters" , 
			CommandUsageDescBan = "Verband een speler van de server" , 
			CommandUsageDescTempBan = "Verband een speler tijdelijk van de server" , 
			CommandUsageDescKick = "Kicked een speler van de server" , 
			CommandUsageDescMute = "Mute een speler. Deze kan daardoor niet meer praten." , 
			CommandUsageDescUnmute = "Unmute een speler zodat deze de chat weer kan gebruiken." , 
			CommandUsageDescFreeze = "Bevriest een speler zodat deze niet kan bewegen." , 
			CommandUsageDescUnfreeze = "Ontdooit een speler zodat deze weer kan bewegen." , 
			CommandUsageDescGoto = "Teleport je naar een speler" , 
			CommandUsageDescGotoVeh = "Teleport je naar een voertuig." , 
			CommandUsageDescGiveStaffFlag = "Geeft een staff flag aan een speler" , 
			CommandUsageDescTakeStaffFlag = "Neemt een staff flag van een speler" , 
			CommandUsageDescStaffFlags = "Toont een lijst van alle staff flags" , 
			CommandUsageDescReport = "Rapporteert een speler aan de admins" , 
			CommandUsageDescReports = "Toont alle onbehandelde staff rapporten" , 
			CommandUsageDescAR = "Accepteert een door een speler ingevoerd rapport" , 
			CommandUsageDescDR = "Weigert een door een speler ingevoerd rapport" , 
			CommandUsageDescForumReport = "Geeft aan dat het rapport op het forum moet worden geplaatst" , 
			CommandUsageDescResetReport = "Reset een rapport om opnieuw te worden behandeld" , 
			
			CommandExtraDescIPLogin = "Gebruikt alleen je laatste IP om automatisch in te loggen" , 
			CommandExtraDescLUIDLogin = "Gebruikt alleen je laatste LUID om automatisch in te loggen" , 
			CommandExtraDescMute = "Dit blokkeert ook chatgerelateerde commands (ME, DO, etc)" , 
			CommandExtraDescGoto = "Je kunt een X, Y en Z offset meegeven." , 
			CommandExtraDescFreeze = "Ze kunnen nog steeds rondkijken met hun muis." , 
			
			IPLoginON = "Je wordt nu ingelogd met je IP." , 
			IPLoginOFF = "Je wordt niet ingelogd met je IP." , 
			LUIDLoginON = "Je wordt nu ingelogd met je LUID." , 
			LUIDLoginOFF = "Je wordt niet ingelogd met je LUID." , 
			
			LastItem = false 
			
		} ,	

		// 4 - Croatian
		{
		
			WelcomeToServer = "Welcome to Life in Liberty City RP.",
			ServerUnderDevelopment = "This server is under development, and may restart often" , 
			PleaseWaitAccountLoading = "Please wait while your account is loaded ..." , 
			
			AlreadyRegistered = "You are already registered! Use /login to access this account."
			AccountCreated = "Your account has been created! Please wait a moment ..."
			AlreadyLoggedIn = "You are already logged in!"
			AccountReadyToUse = "Your account is now ready to use. Please press left CTRL to spawn."
			
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
			
			JobHelpUnemployed = [
			
				"== Job Help =================================" , 
				"- Jobs are a good way to make money." , 
				"- Visit any job site, and use /takejob to get a job."
			
			] , 
			
			VehicleHelp = [
			
				"== Vehicle Help =============================" , 
				"- Visit the dealership in Portland to buy vehicles." , 
				"- Use /lock to unlock your car." , 
				"- The /lights command can turn on and off your headlights." , 
				"- To turn an engine on or off, use /engine" , 
				"- To sell your car to another player, use /sellcar"
			
			] , 
			
			AccountHelp = [ 
			
				"== Account Help =============================" , 
				"- Do not share your password with anybody else." , 
				"- The server staff will never ask for your password." , 
				"- Use /iplogin or /luidlogin to automatically log you in with your IP or LUID" , 
				"- Use /changepass to change your password."		
			
			] , 
			
			NoCommandPermission = "You do not have permission to use this command!" ,
			UnknownCommand = "Unknown command!" ,
			MustBeNumber = "The %s must be a number!" , 
			MustBeBetween = "The %s must be between %d and %d characters" ,
			MustHaveCaps = "The %s must have at least 1 uppercase letter." , 
			MustHaveNumber = "The %s must have at least 1 number." , 
			MustHaveSymbol = "The %s must have at least 1 special symbol." , 
			CommandSpamWait = "You must wait %d seconds before using another command." ,
			CommandSpamAlert = "You have been blocked from using commands for %d seconds." ,
			CommandSpamWarn = "Please do not spam commands!" , 
			YouAreMuted = "You are muted, and cannot speak or use commands!" , 
			
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
			LoginFailed = "You entered an invalid password too many times!" , 
			LoginAttemptsRemaining = "You have %d login attempts remaining." , 
			
			AllVehiclesExploded = "All vehicles exploded by %s",
			AllVehiclesRespawned = "All vehicles exploded by %s",
			AllVehiclesLocked = "All vehicles locked by %s",
			AllVehiclesUnlocked = "All vehicles unlocked by %s",
			
			TakeJobSuccessful = "You now have the %s job! Use /Help Job for info.",
			
			LoggedInByIP = "Welcome back, %s. You have been automatically logged in with your IP!",
			LoggedInByLUID = "Welcome back, %s. You have been automatically logged in with your LUID!",
			
			CommandUsageDescShout = "Shouts to nearby players" , 
			CommandUsageDescTalk = "Talks to nearby players." , 
			CommandUsageDescLogin = "Allows you to login to your account" , 
			CommandUsageDescChangePass = "Allows you to change your password" , 
			CommandUsageDescRegister = "Allows you to create an account" , 
			CommandUsageDescIPLogin = "Toggles ON/OFF automatic login by IP." , 
			CommandUsageDescLUIDLogin = "Toggles ON/OFF automatic login by LUID." , 
			CommandUsageDescPM = "Sends a private message to another player" , 
			CommandUsageDescBug = "Reports a bug to the scripters" , 
			CommandUsageDescIdea = "Submits an idea to the scripters" , 
			CommandUsageDescBan = "Bans a player from the server" , 
			CommandUsageDescTempBan = "Temporarily bans a player from the server" , 
			CommandUsageDescKick = "Kicks a player from the server" , 
			CommandUsageDescMute = "Mutes a player. Keeps them from using any chat." , 
			CommandUsageDescUnmute = "Unmutes a player so they can use chat again." , 
			CommandUsageDescFreeze = "Freezes a player so they can't move." , 
			CommandUsageDescUnfreeze = "Unfreezes a player so they can move again." , 
			CommandUsageDescGoto = "Teleports you to a player" , 
			CommandUsageDescGotoVeh = "Teleports you to a vehicle." , 
			CommandUsageDescGiveStaffFlag = "Gives a staff flag to a player" , 
			CommandUsageDescTakeStaffFlag = "Takes a staff flag from a player" , 
			CommandUsageDescStaffFlags = "Shows a list of all staff flags." , 
			CommandUsageDescReport = "Reports a player or message to admins" , 
			CommandUsageDescReports = "Shows all unhandled staff reports" , 
			CommandUsageDescAR = "Accepts a report submitted by a player" , 
			CommandUsageDescDR = "Denies a report submitted by a player" , 
			CommandUsageDescForumReport = "Sets a report as needing to be put on forum" , 
			CommandUsageDescResetReport = "Resets a handled staff report to handle it again" , 
			
			CommandExtraDescIPLogin = "Only uses your last IP to automatically login" , 
			CommandExtraDescLUIDLogin = "Only uses your last LUID to automatically login" , 
			CommandExtraDescMute = "This also blocks chat-related commands (ME, DO, etc)" , 
			CommandExtraDescGoto = "You can provide offset X, Y, and Z." , 
			CommandExtraDescFreeze = "They can still look around with their mouse." , 
			
			IPLoginON = "You will now be logged in by your IP." , 
			IPLoginOFF = "You will not be logged in by your IP." , 
			LUIDLoginON = "You will now be logged in by your LUID." , 
			LUIDLoginOFF = "You will not be logged in by your LUID." , 
			
			LastItem = false 
			
		} ,				

	];
	
	return pLocaleTable;
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerLocaleMessage ( pPlayer , szMessageType ) {

	local pPlayerData = GetPlayerData ( pPlayer );

	return GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szMessageType ];
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerGroupedLocaleMessage ( pPlayer , szGroupName , szMessageType ) {

	local pPlayerData = GetPlayerData ( pPlayer );

	return GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szGroupName ] [ szMessageType ];
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerLocaleMultiMessage ( pPlayer , szGroupName ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	local pMessages = [ ];

	foreach ( ii , iv in GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szGroupName ] ) {
	
		pMessages.push ( iv );
	
	}
	
	return pMessages;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Locale]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------