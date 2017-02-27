pLocalPlayer = null;

iCurrentTrain <- INVALID_TRAIN_ID;
iCurrentStation <- false;
pTrainSound = null;
iTrainTime = 0;
iAnnounceTime = 0;
iLastStation = 0;
iTrainTimer = null;

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

];

// -------------------------------------------------------------------------------------------------

function onScriptLoad ( ) {

	pLocalPlayer = FindLocalPlayer ( );
	
	NewTimer ( "ProcessTrains" , 1000 , 0 );

}

// -------------------------------------------------------------------------------------------------

function onClientEnteredTrain ( iTrain ) {

	iCurrentTrain = iTrain;

}

// -------------------------------------------------------------------------------------------------

function onClientExitedTrain ( iTrain ) {

	iCurrentTrain = INVALID_TRAIN_ID;

}

// -------------------------------------------------------------------------------------------------

function onTrainArrive ( iTrain , iStation ) {

	if ( iTrain == iCurrentTrain ) {
	
		if ( pTrainSound ) {
		
			pTrainSound.Close ( );
		
		}
		
		local szTrainSoundPath = "lctrain/train_arr_" + iStation + ".mp3";
	
		pTrainSound = FindSound ( szTrainSoundPath );
		
		if ( pTrainSound ) {
		
			pTrainSound.Open ( );
			pTrainSound.Play ( );
		
		}
		
		SmallMessage ( "~w~" + TrainStations.szName + " Station (" + TrainStations.szLocation + ")", 2500, 1 );
	
	}

}

// -------------------------------------------------------------------------------------------------

function onTrainLeave ( iTrain , iStation ) {

	if ( iTrain == iCurrentTrain ) {
	
		iLastStation = iStation;
		iTrainTime = 0;
		
		local szTrainSoundPath = "lctrain/train_leave_" + iStation + ".mp3";
	
		pTrainSound = FindSound ( szTrainSoundPath );
		
		if ( pTrainSound ) {
		
			pTrainSound.Open ( );
			pTrainSound.Play ( );
		
		}
		
		iNextStation = GetNextTrainStation ( iStation );
		
		iAnnounceTime = 2 * TrainStations [ iNextStation ].iTripNextTime / 3;		
	
	}

}

// -------------------------------------------------------------------------------------------------

function GetClosestTrainStation ( pPosition ) {

	pClosestStation = TrainStations [ 1 ];

	foreach ( ii , iv in TrainStations ) {
	
		if ( GetDistance ( pPosition , iv.pPosition ) < GetDistance ( pPosition , pClosestStation.pPosition ) ) {
		
			pClosestStation = iv;
		
		}
	
	}
	
	return pClosestStation;

}

// -------------------------------------------------------------------------------------------------

function GetCurrentTrainStation ( pPosition ) {

	local pClosestTrainStation = GetClosestTrainStation ( pPosition );
	
	if ( GetDistance ( pPosition , pClosestTrainStation.pPosition ) <= 20;
		
		return pClosestTrainStation;
		
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function GetNextTrainStation ( iStation ) {

	if ( iStation == 0 ) { // Elevated Line
		
		return 2;
	
	} else if ( iStation == 3 ) { // Subway Line
	
		return 6;
	
	}
	
	return iStation - 1;

}

// -------------------------------------------------------------------------------------------------

function ProcessTrains ( ) {

	iTrainTime++;
	
	if ( iAnnounceTime && iTrainTime >= iAnnounceTime ) {
	
	
	}

}

// -------------------------------------------------------------------------------------------------

function PlayArrivalAnnouncement ( iStation ) {

	return true;

}