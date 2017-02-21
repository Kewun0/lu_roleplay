TrainStations <- [
	{
		szStationName = "Baillie" , 
		szLocation = "Saint Marks" , 
		pPosition = Vector ( 1303.7 , -530.3 , 44.26 ) ,
		iTripNextTime = 24 ,
		iLastTrain = 0 ,
	} ,
	
	{ 
		szStationName = "Rothwell" , 
		szLocation = "Hepburn Heights" , 
		pPosition = Vector ( 1039.8 , -159.25 , 23.95 ) ,
		iTripNextTime = 34 ,
		iLastTrain = 0 ,
	} ,

	{ 
		szStationName = "Kurowski" , 
		szLocation = "Chinatown" , 
		pPosition = Vector ( 769.8 , -586.3 , 23.86 ) ,
		iTripNextTime = 24 ,
		iLastTrain = 0 ,
	} ,

	{ 
		szStationName = "Portland" , 
		szLocation = "" , 
		pPosition = Vector ( 916.8 , -465.7 , -18.79 ) ,
		iTripNextTime = 24 ,
		iLastTrain = 0 ,
	} ,

	{ 
		szStationName = "Rockford" , 
		szLocation = "" , 
		pPosition = Vector ( 237.67 , -169.06 , -9.68 ) ,
		iTripNextTime = 24 ,
		iLastTrain = 0 ,
	} ,

	{ 
		szStationName = "Shoreside Terminal" , 
		szLocation = "" , 
		pPosition = Vector ( 0.0 , 0.0 , 0.0 ) ,
		iTripNextTime = 24 ,
		iLastTrain = 0 ,
	} ,	
	

	{ 
		szStationName = "Staunton South" , 
		szLocation = "" , 
		pPosition = Vector ( 195.61 , -1658.8 , -5.37 ) ,
		iTripNextTime = 24 ,
		iLastTrain = 0 ,
	} ,		

]

// -------------------------------------------------------------------------------------------------

function onClientEnteredTrain ( iTrain ) {

	

}

// -------------------------------------------------------------------------------------------------

function onClientExitedTrain ( iTrain ) {

	

}

// -------------------------------------------------------------------------------------------------

function onTrainArrive ( iTrain , iStation ) {



}

// -------------------------------------------------------------------------------------------------

function onTrainLeave ( iTrain , iStation ) {



}

// -------------------------------------------------------------------------------------------------

function GetClosestTrainStation ( pPosition ) {



}

// -------------------------------------------------------------------------------------------------

function GetCurrentTrainStation ( pPosition ) {

	local pClosestTrainStation = GetClosestTrainStation ( pPosition );
	
	if ( GetDistance ( pPosition , pClosestTrainStation.pPosition ) <= 20;
		
		return pClosestTrainStation;
		
	};

}

// -------------------------------------------------------------------------------------------------

function GetNextTrainStation ( iStation ) {

	local szSoundFile = "lctrain/train_appr_" + iStation + ".mp3";
	
	local pSound = FindSound ( szSoundFile );
	
	if ( pSound ) {
	
		pSound.Open ( );
		pSound.Play ( );
		
	}

}

// -------------------------------------------------------------------------------------------------

function PlayArrivalAnnouncement ( iStation ) {

	return true;

}