function SavePlayerDataByField ( pPlayer , szFieldName , pData ) {

    local pPlayerData = LURP.Players [ pPlayer.ID ];

    switch ( type ( pData ) ) {
    
        case "string":
        
            WriteIniString (  );
            
            break;
            
        case "integer":
        
            WriteIniInteger (  );
            
            break;
            
        case "float":
        
            WriteIniFloat (  );
            
            break;
            
        case "bool":

            WriteIniBool (  );
            
            break;
            
    }

    return true;

}