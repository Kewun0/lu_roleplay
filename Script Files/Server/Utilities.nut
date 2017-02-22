function GetPlayerIsland ( pPlayer ) {

	local pPos = pPlayer.Pos;

	if ( pPos.x > 616 ) {
		
		return 1;
		
	}
	
	if ( pPos.x < -283 ) {
	
		return 3;
	
	}
	
	return 2;
	
}

// -------------------------------------------------------------------------------------------------

function KillDeathRatio ( iKills , iDeaths ) {
	
	if ( iDeaths == 0 || iKills == 0 ) {
	
		return 0.0;
		
	}
	

	local iRatio;
	
	iRatio = ( ( iKills * 100 / iDeaths ) * 0.01 ).tofloat ( );
	
	return iRatio;
	
}

// -------------------------------------------------------------------------------------------------

function GetVectorInFrontOfVector ( pVector = Vector ( 0.0 , 0.0 , 0.0 ) , fAngle = 0.0 , fDistance = 0.0 ) {

	fAngle = fAngle * PI / 180; 
	
	local fX = ( pVector.x + ( ( cos ( fAngle + ( PI / 2 ) ) ) * fDistance ) );
	local fY = ( pVector.y + ( ( sin ( fAngle + ( PI / 2 ) ) ) * fDistance ) );
	
	return Vector ( fX , fY , pVector.z );	
	
}

// -------------------------------------------------------------------------------------------------

function GetVectorBehindVector ( pVector = Vector ( 0.0 , 0.0 , 0.0 ) , fAngle = 0.0 , fDistance = 0.0 ) {

	fAngle = fAngle * PI / 180; 
	
	local fX = ( pVector.x + ( ( cos ( -fAngle + ( PI / 2 ) ) ) * fDistance ) );
	local fY = ( pVector.y + ( ( sin ( -fAngle + ( PI / 2 ) ) ) * fDistance ) );
	
	return Vector ( fX , fY , pVector.z );	
	
}

// -------------------------------------------------------------------------------------------------

function GetVectorInFrontOfPlayer ( pPlayer , fDistance = 0.0 ) {

	return GetVectorInFrontOfVector ( pPlayer.Pos , pPlayer.Angle , fDistance );
	
}

// -------------------------------------------------------------------------------------------------

function GetVectorBehindPlayer ( pPlayer , fDistance = 0.0 ) {

	return GetVectorBehindVector ( pPlayer.Pos , pPlayer.Angle , fDistance );

}

// -------------------------------------------------------------------------------------------------

function GetVectorInFrontOfVehicle ( pVehicle , fDistance = 0.0 ) {

	return GetVectorInFrontOfVector ( pvVehicle.Pos , pVehicle.Angle , fDistance );
	
}

// -------------------------------------------------------------------------------------------------

function GetVectorBehindVehicle ( pVehicle , fDistance = 0.0 ) {

	return GetVectorBehindVector ( pVehicle.Pos , pVehicle.Angle , fDistance );

}

// -------------------------------------------------------------------------------------------------

function GetVectorBelowVector ( pVector , fHeight = 0.0 ) {
	
	return Vector ( pVector.x , pVector.y , pVector.z - fHeight );
	
}

// -------------------------------------------------------------------------------------------------

function GetVectorAboveVector ( pVector , fHeight = 0.0 ) {
	
	return Vector ( pVector.x , pVector.y , pVector.z + fHeight );
	
}

// -------------------------------------------------------------------------------------------------

function GetOffsetFromVector ( pVector , pOffset = Vector( 0.0 , 0.0 , 0.0 ) ) {

	return Vector ( pVector.x + pOffset.x , pVector.y + pOffset.y , pVector.z + pOffset.z );
	
}

// -------------------------------------------------------------------------------------------------

function DegreesToRadians ( iDegrees ) {
	
	return iDegrees * PI / 180;
	
}

// -------------------------------------------------------------------------------------------------

function RadiansToDegrees ( fRadians ) {
	
	return fRadians * 180 / PI;
	
}

// -------------------------------------------------------------------------------------------------

function GetCardinalDirectionText ( iDirection ) {  
	
	return GetCoreTable ( ).Utilities.szCardinalDirections [ iDirection ];
	
}

// -------------------------------------------------------------------------------------------------

// -- THIS NEEDS REDONE
// -- Credit for this goes to Mex, from his VLE scripts he made for VCO.
// -- Edited by Vortrex, for Squirrel compatability.

function GetCardinalDirection ( pVector1 , pVector2 ) {
	
	local a = pVector1.x - pVector2.x;
	local b = pVector1.y - pVector2.y;
	local c = pVector1.z - pVector2.z;
	
	local x = abs ( a );
	local y = abs ( b );
	local z = abs ( c );
	
	local no = 0;
	local ne = 1;
	local ea = 2;
	local se = 3;
	local so = 4;
	local sw = 5;
	local we = 6;
	local nw = 7;
	local na = 8;
	
	if ( b < 0 && a < 0 ) {
	   
		if ( x < ( y / 2 ) ) {
			
			return no;
		
		} else if ( y < ( x / 2 ) ) {
			
			return ea;
		
		} else {
			
			return ne;
		}
		
	} else if ( b < 0 && a >= 0 ) {
		
		if( x < ( y / 2 ) ) {
			
			return no;
		
		} else if ( y < ( x / 2 ) ) {
			
			return we;
		
		} else {
			
			return nw;
		
		}
		
	} else if ( b >= 0 && a >= 0 ) {
		
		if ( x < ( y / 2 ) ) {
			
			return so;
		
		} else if ( y < ( x / 2 ) ) {
			
			return w;
		
		} else {
		   
			return sw;
			
		}
	
	} else if ( b >= 0 && a < 0 ) {
		
		if ( x < ( y / 2 ) ) {
			
			return s;
	   
		} else if ( y < ( x / 2 ) ) {
		   
			return e;
		
		} else {
			
			return se;
		
		}
	
	} else {
		
		return na;
	
	}
	
	return na;
	
}

// --------------------------------------------------------------------------------------------------

function AddPickupToWorld ( pPosition , iModel , iPickupDataType , iPickupDataID ) {

	local pPickup = false;
	
	pPickup = CreatePickup ( iModel , pPosition );
	
	GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataType <- iPickupDataType;
	GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID <- iPickupDataID;
	
	return pPickup;

}

// --------------------------------------------------------------------------------------------------

function AttemptHiddenPackagePickup ( pPlayer , iHiddenPackageID ) {

	pPlayer.Cash += GetCoreTable ( ).Locations.HiddenPackages [ iHiddenPackageID ].iCashWin;

	return true;
	
}

// --------------------------------------------------------------------------------------------------

function CreateHiddenPackages ( ) {
 
	local iPackageCount = 0;
	local iSpawnedPackages = array ( GetCoreTable ( ).Utilities.iMaxHiddenPackages , { } );
	local iRandomPackageID = -1;
	local pPickup = false;
	
	// -- Keep loop running while there are less than 50 spawned packages
	
	while ( iPackageCount < GetCoreTable ( ).Utilities.iMaxHiddenPackages ) {
		
		// -- Pick a random slot from the hidden packages array
		
		iRandomPackageID = ceil( ( 1.0 * rand ( ) / RAND_MAX ) * ( GetCoreTable ( ).Locations.HiddenPackages.len( ) - 1 ) );
		
		// -- See if the random package slot is already taken. If not, spawn a package and add 1 to the package count
		
		if ( !GetCoreTable ( ).Locations.HiddenPackages [ iRandomPackageID ].pPickup ) {
			
			pPickup = CreatePickup ( 1321 , GetCoreTable ( ).Locations.HiddenPackages [ iRandomPackageID ].pPosition );
			
			GetCoreTable ( ).Locations.HiddenPackages [ iRandomPackageID ].pPickup <- pPickup;
			
			GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataType <- 1;
			GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID <- iRandomPackageID;
			
			iPackageCount++;
			
		}
		
	}
	
	print ( "[ServerStart]: Hidden packages created" );
	
}

// -------------------------------------------------------------------------------------------------

// -- Need finished.

function DoesStringContainCaps ( szString ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

// -- Need finished.

function DoesStringContainNumbers ( szString ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

// -- Need finished.

function DoesStringContainSymbols ( szString ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function GetNearestPoliceStation ( pPosition ) {

	local pClosestStation = GetCoreTable ( ).Locations.PoliceStations [ 0 ];

	foreach ( ii , iv in GetCoreTable ( ).Locations.PoliceStations ) {
	
		if ( GetDistance ( pPosition , iv.pPosition ) < GetDistance ( pPosition , pClosestStation.pPosition ) ) {
		
			pClosestStation = iv;
			
		}
	
	}
	
	return pClosestStation;

}

// -------------------------------------------------------------------------------------------------

function GetNearestFireStation ( pPosition ) {

	local pClosestStation = GetCoreTable ( ).Locations.FireStations [ 0 ];

	foreach ( ii , iv in GetCoreTable ( ).Locations.FireStations ) {
	
		if ( GetDistance ( pPosition , iv.pPosition ) < GetDistance ( pPosition , pClosestStation.pPosition ) ) {
		
			pClosestStation = iv;
			
		}
	
	}
	
	return pClosestStation;

}

// -------------------------------------------------------------------------------------------------

function GetNearestHospital ( pPosition ) {

	local pClosestHospital = GetCoreTable ( ).Locations.Hospitals [ 0 ];

	foreach ( ii , iv in GetCoreTable ( ).Locations.Hospitals ) {
	
		if ( GetDistance ( pPosition , iv.pPosition ) < GetDistance ( pPosition , pClosestHospital.pPosition ) ) {
		
			pClosestHospital = iv;
			
		}
	
	}
	
	return pClosestHospital;

}

// -------------------------------------------------------------------------------------------------

// -- Needs finished

function GetPlayerCountryCode ( pPlayer ) {

	return "??";

}

// -------------------------------------------------------------------------------------------------

function GetRemainingString ( szString , szDelimiter , iStartIndex ) {

	local iTotalIndexes = NumTok ( szString , szDelimiter );
	local szCompleteString = "";
	
	if ( iTotalIndexes > iStartIndex ) {
	
		for ( local i = iStartIndex ; i <= iTotalIndexes ; i++ ) {
		
			if ( szCompleteString.len ( ) == 0 ) {
				
				szCompleteString = GetTok ( szString , szDelimiter , i );
				
			} else {
				
				szCompleteString = szCompleteString + szDelimiter + GetTok ( szString , szDelimiter , i );
			
			}
			
		}
		
	} else {
	
		szCompleteString = GetTok ( szString , szDelimiter , iStartIndex );
	
	}
	
	return szCompleteString;

}

// -------------------------------------------------------------------------------------------------

function DoesPlayerHaveVehicleKeys ( pPlayer , pVehicle ) {
	
	local pVehicleData = GetVehicleDataFromVehicle ( pVehicle );
	local pPlayerData = GetPlayerData( pPlayer );

	// -- If the player can admin-manage vehicles, they automatically have access to all of them.
	
	if ( DoesPlayerHaveStaffPermission ( pPlayer , "ManageVehicles" ) ) {
	
		return true;
	
	}
	
	// -- If vehicle is personally owned by a player, check to see if the current player is the owner
	
	if ( pVehicleData.iOwnerType == GetCoreTable ( ).Utilities.pVehicleOwnerType.Player && ( pVehicleData.iOwnerID == pPlayerData.iDatabaseID ) ) {
	
		return true;
	
	}
	
	// -- If vehicle is personally owned by a clan, check to see if the current player is in the clan
	
	if ( pVehicleData.iOwnerType == GetCoreTable ( ).Utilities.pVehicleOwnerType.Clan && ( pVehicleData.iOwnerID == pPlayerData.iClan ) ) {
	
		return true;
	
	}
	
	// -- If vehicle is personally owned by a job, check to see if the current player has the job
	
	if ( pVehicleData.iOwnerType == GetCoreTable ( ).Utilities.pVehicleOwnerType.Job && ( pVehicleData.iOwnerID == pPlayerData.iJob ) ) {
	
		return true;
	
	}
	
	if ( pVehicleData.iRentPrice > 0 ) {
	
		if ( pVehicleData.pRenter != false ) {
		
			if ( pVehicleData.pRenter.ID == pPlayer.ID ) {
			
				return true;
			
			}
		
		}
	
	}
	
		
	// -- Nothing matched, so player does not have the keys.
	
	return false;
	
}

// -------------------------------------------------------------------------------------------------

function DoesPlayerHaveStaffPermission ( pPlayer , szPermission ) {

	local iBitFlag = GetCoreTable ( ).BitFlags.StaffFlags [ szPermission ];
	local pPlayerData = GetPlayerData( pPlayer );
	
	// -- If staff flags are -1, it's automatic override. Pretty much server-god.
	
	if ( pPlayerData.iStaffFlags == -1 ) {
	
		return true;
	
	}
	
	if ( HasBitFlag ( pPlayerData.iStaffFlags , iBitFlag ) ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function GetNumberOfRegisteredAccounts ( ) {
	
	return ReadIniInteger ( GetCoreTable ( ).Utilities.szScriptsPath + "Data/Index.ini" , "General" , "iAccountAmount" );

}

// -------------------------------------------------------------------------------------------------

function ParseDateForDisplay ( iTimeStamp ) {

	local pDate = date ( iTimeStamp );
	
	local iWeekDayID = pDate [ "wday" ];
	local szWeekDay = GetCoreTable ( ).Utilities.WeekDays [ iWeekDayID ];

	local iMonthID = pDate [ "month" ];
	local szMonth = GetCoreTable ( ).Utilities.Months [ iMonthID ];
	
	local iHour = pDate [ "hour" ];
	local iMinute = pDate [ "min" ];
	
	local szMeridian = "??";
	
	if ( iHour < 12 && iHour >= 0 ) {
		
		szMeridian = "AM"
		
		if ( iHour == 0 ) {
		
			iHour = 12;
		
		}
		
	} else {
	
		szMeridian = "PM";
		
		local iCalculate = iHour * ( iHour / 12 );
		
	}
	
	local szDateString = szWeekDay + ", " + szMonth + " " + pDate [ "day" ] + ", " + pDate [ "year" ] + " at " + iHour + ":" + iMinute + " " + szMeridian;
	
	return szDateString;
	
}

// -------------------------------------------------------------------------------------------------

function IsValidSkinID ( iSkinID ) {

	if ( iSkinID >= 0 && iSkinID <= 122 ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function AddStaffPermission ( pPlayer , szBitFlagName ) {

	if ( DoesPlayerHaveStaffPermission ( pPlayer , szBitFlagName ) ) {
	
		return false;
	
	}
	
	GetPlayerData( pPlayer ).iStaffFlags = GetPlayerData( pPlayer ).iStaffFlags | GetCoreTable ( ).BitFlags.StaffFlags [ szBitFlagName ];
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function RemoveStaffPermission ( pPlayer , szBitFlagName ) {

	if ( !DoesPlayerHaveStaffPermission ( pPlayer , szBitFlagName ) ) {
	
		return false;
	
	}
	
	GetPlayerData( pPlayer ).iStaffFlags = GetPlayerData( pPlayer ).iStaffFlags & ~GetCoreTable ( ).BitFlags.StaffFlags [ szBitFlagName ];
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerFireFighter ( pPlayer ) {

	local pPlayerData = GetPlayerData( pPlayer );
	
	if ( pPlayerData.iJob == GetCoreTable ( ).Utilities.Jobs.FireFighter ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerParamedic ( pPlayer ) {

	local pPlayerData = GetPlayerData( pPlayer );
	
	if ( pPlayerData.iJob == GetCoreTable ( ).Utilities.Jobs.Medical ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerAtPoliceStation ( pPlayer ) {
	
	local pPoliceStation = GetClosestPoliceStation ( pPlayer.Pos );
	
	if ( GetDistance ( pPlayer.Pos , pPoliceStation.pPosition ) <= GetCoreTable ( ).Utilities.fArrestRange ) {
		
	   return true;

	}
	
	return false;
	
}

// -------------------------------------------------------------------------------------------------

function IsPlayerAtHospital ( pPlayer ) {
	
	local pHospital = GetClosestHospital ( pPlayer.Pos );
	
	if ( GetDistance ( pPlayer.Pos , pHospital.pPosition ) <= GetCoreTable ( ).Utilities.fHospitalHealRange ) {
		
	   return true;

	}
	
	return false;
	
}

// -------------------------------------------------------------------------------------------------

function CreateSafeIniString ( szUnsafeString ) {
	
	local szSafeString = "";
	local pSplitString = [ ];
	local pStrippedCharacters = [ ];
	
	pSplitString = split ( szUnsafeString , GetCoreTable ( ).Security.szUnsafeCharacters );
	
	foreach ( ii , iv in pSplitString ) {
		
		szSafeString = szSafeString + iv;
		
	}
	
	return szSafeString;
	
}

// -------------------------------------------------------------------------------------------------

function IsPlayerImmobilized ( pPlayer ) {

	if ( pPlayerData.bTazed ) {
	
		return true;
	
	}
	
	if ( pPlayerData.bCuffed ) {
	
		return true;
	
	}	

	if ( pPlayerData.bDead ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function PlayerShotByTazer ( pShooter , pShot ) {

	local pShooterData = GetCoreTable ( ).Players [ pShooter.ID ];
	local pShotData = GetCoreTable ( ).Players [ pShot.ID ];
	
	if ( !pShooterData.bTazerArmed ) {
	
		return false;
	
	}
	
	if ( pShooter.Weapon != 2 ) {
	
		return false;
	
	}
	
	if ( IsPlayerImmobilized ( pShot ) ) {
	
		return false;
	
	}
	
	ResetPlayerAnimation ( pShot );
	pShot.SetAnim ( 18 );
	
	if ( !pShot.bMuted ) {
	
		onPlayerAction ( pShot , "gets electrified by " + pShooter.Name + "'s tazer, and falls to the ground" );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ResetPlayerAnimation ( pPlayer ) {

	pPlayer.Skin = pPlayer.Skin;
	pPlayer.Pos = pPlayer.Pos;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function GetTimeDifferenceDisplay ( iTimeOne , iTimeTwo ) {

	local iTimeDifference = ( iTimeOne - iTimeTwo );
	
	iHours = floor ( iTimeDifference / 3600 );
	iMinutes = floor ( iTimeDifference / 60 );
	
	if ( iHours == 1 ) {
		
		szHours = "1 hour";
		
	} else {
		
		szHours = iHours + " hours";
	
	}
	
	if ( iMinutes == 1 ) {
		
		szMinutes = "1 minute";
		
	} else {
		
		szMinutes = iMinutes + " minute";
	
	}
	
	return szHours + " and " + szMinutes;
	
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Utilities]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------