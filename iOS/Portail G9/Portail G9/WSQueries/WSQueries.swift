//
//  WSQueries.swift
//  Portail G9
//
//  Created by WBA_ORCA on 11/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSAuthentificationDelegate {
    
    func didFinishWSAuthentification(error: Bool,utilisateurResponse : UtilisateurResponseWSAuth!)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetDataUtilesDelegate {
    
    func didFinishWSGetDataUtiles(error: Bool , data : DataUtilesWSResponse!)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetDonneesRadarsDelegate {
    
    func didFinishWSGetDonneesRadars(error: Bool , data : DataRadarWSResponse!)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetFamillesDelegate {
    
    func didFinishWSGetActionsPlan(error: Bool , data : GetActionPlansWSResponse!)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetCategoriesDelegate {
    
    func didFinishWSGetCategories(error: Bool , data : DataCategoriesWSResponse!)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetGroupesKPIDelegate {
    
    func didFinishWSGetGroupesKPI(error: Bool , data : DataGroupeKPIWSResponse!)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetIndicateursKPIsDelegate {
    
    func didFinishWSGetIndicateursKPIs(error: Bool , data : DataKPIsWSResponse!)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetBoardsForcesTerrainsDelegate {
    
    func didFinishWSGetBoardsForcesTerrains(error: Bool , data : DataForceTerrainToDoListWSResponse!)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetTaskForcesTerrainsDelegate {
    
    func didFinishWSGetTacheForcesTerrains(error: Bool , data : TacheForceTerrainWSResponse!)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSAddBoardForcesTerrainsDelegate {
    
    func didFinishWSAddBoardForcesTerrains(error: Bool , code_erreur : Int, description : String)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSDragTaskForcesTerrainsDelegate {
    
    func didFinishWSDragTaskForcesTerrains(error: Bool , code_erreur : Int, description : String)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSAddTaskToBoardForcesTerrainsDelegate {
    
    func didFinishWSAddTaskToBoard(error: Bool , code_erreur : Int, description : String)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSAddCommentToTaskForcesTerrainsDelegate {
    
    func didFinishWSAddCommentToTask(error: Bool , code_erreur : Int, description : String)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSAddFileToTaskForcesTerrainsDelegate {
    
    func didFinishWSAddFileToTask(error: Bool , code_erreur : Int, description : String)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSAddCheckListToTaskForcesTerrainsDelegate {
    
    func didFinishWSAddCheckListToTask(error: Bool , code_erreur : Int, description : String)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSDeleteTaskForcesTerrainsDelegate {
    
    func didFinishWSDeleteTask(error: Bool , code_erreur : Int, description : String)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSDeleteFileForcesTerrainsDelegate {
    
    func didFinishWSDeleteFile(error: Bool , code_erreur : Int, description : String)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSDeleteBoardForcesTerrainsDelegate {
    
    func didFinishWSDeleteBoard(error: Bool , code_erreur : Int, description : String)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSDeleteCheckListForcesTerrainsDelegate {
    
    func didFinishWSDeleteCheckList(error: Bool , code_erreur : Int, description : String)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSDeleteCommentaireForcesTerrainsDelegate {
    
    func didFinishWSDeleteCommentaire(error: Bool , code_erreur : Int, description : String)
}


// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetListePiliersDelegate {
    
    func didFinishWSGetListePiliers(error: Bool , data : ListePiliersWSResponse!)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSGetQuestionPiliersDelegate {
    
    func didFinishWSQuestionPiliers(error: Bool , data : QuestionPiliersWSResponse!)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSTargetQuestionDelegate {
    
    func didFinishWSTargetQuestion(error: Bool , code_erreur : Int, description : String)
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol WSUpdateQuestionDelegate {
    
    func didFinishWSUpdateQuestion(error: Bool , code_erreur : Int, description : String)
}
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
class WSQueries: NSObject {
    
    public static let CODE_RETOUR_200 = 200 ;
    public static let CODE_ERREUR_0 = 0 ;
    public static let CODE_BAD_CREDENTIAL = 401 ;
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func authenticateUser(login : String, password : String, delegate : WSAuthentificationDelegate)
    {
        let passwordChiffre = Utils.chiffrerPassword(password: password)
        
        let post_params: Parameters = [
            "login": login,
            "pwd": passwordChiffre
        ]
        
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/authUser"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: nil).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value
                /*
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("Failure Response: \(json)")
                }
                */
                let responseAuthUser =  Mapper<UtilisateurResponseWSAuth>().map(JSONObject:responseJson)
                if(responseAuthUser != nil)
                {
                    delegate.didFinishWSAuthentification(error: false, utilisateurResponse: responseAuthUser!)
                    return
                }
                
                delegate.didFinishWSAuthentification(error: true, utilisateurResponse: nil)
                
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSAuthentification(error: true, utilisateurResponse: nil)
                break
                
            }
            
        }
    }
    
    
    
    // *****************************************
    // *****************************************
    // ****** refreshToken Synchronously
    // *****************************************
    // *****************************************
    static func refreshToken(completion: @escaping (_ code: Int) -> ())
    {
        
        let preferences = UserDefaults.standard
        let login =  preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_LOGIN) as? String ?? ""
        let password =  preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PASSWORD) as? String ?? ""
        let passwordChiffre = Utils.chiffrerPassword(password: password)
        
        let post_params: Parameters = [
            "login": login,
            "pwd": passwordChiffre
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getToken"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: nil).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value
                //print("JSON: \(listResponseJson)")
                let responseAuthUser =  Mapper<UtilisateurResponseWSAuth>().map(JSONObject:responseJson)
                if(responseAuthUser != nil && responseAuthUser?.code_erreur == WSQueries.CODE_ERREUR_0 && responseAuthUser?.code == WSQueries.CODE_RETOUR_200 && responseAuthUser?.dataUserResponseWSAuth != nil && (responseAuthUser?.dataUserResponseWSAuth.token.count)! > 3)
                {
                    
                    preferences.set(responseAuthUser?.dataUserResponseWSAuth.token , forKey: Utils.SHARED_PREFERENCE_USER_TOKEN)
                    //  Save to disk
                    preferences.synchronize()
                    
                    if(responseAuthUser!.code != WSQueries.CODE_RETOUR_200)//auth fail
                    {
                        Utils.disconnectUser(goBackAnimated: false);
                    }
                    completion(responseAuthUser!.code)
                    
                    return
                }
                //auth fail
                completion(-999)
                Utils.disconnectUser(goBackAnimated: false);
                
                
                break
                
            case .failure(_):
                //auth fail
                //print(response.result.error?.localizedDescription)
                completion(-999)
                Utils.disconnectUser(goBackAnimated: false);
                
                
                break
                
            }
            
        }
    }
    

    
    // ***********************************
    // ***********************************
    // ***********************************
    static func getDonneesUtiles(delegate : WSGetDataUtilesDelegate, langue : String!)
    {
       
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        let profil_ = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        
        
        // la langue
        var langue_user = "en-GB";
        if(langue == nil){
        let langueData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE);
        if(langueData_ != nil){
            if let langue_ = NSKeyedUnarchiver.unarchiveObject(with: langueData_!)  {
                
                let langue = langue_ as! Langue
               langue_user = langue.languageCode
                
            }
            }
        }else {
            langue_user = langue
        }
        
        let post_params: Parameters = [
            "profil": profil_,
            "code_langue" : langue_user
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getDonneesUtiles"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getDonneesUtiles(delegate: delegate,langue: langue)
                        }else
                        {
                            delegate.didFinishWSGetDataUtiles(error: true , data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseDataUtiles =  Mapper<DataUtilesWSResponse>().map(JSONObject:responseJson)
                if(responseDataUtiles != nil)
                {
                    delegate.didFinishWSGetDataUtiles(error: false,data:responseDataUtiles )
                    return
                }
                
               delegate.didFinishWSGetDataUtiles(error: true , data: nil)
                
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSGetDataUtiles(error: true , data: nil)
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func preparePerimetre() -> String
    {
        var perimetreAsString = "{\"langue\" : \"$LANGUE\", \"country\" : $COUNTRY_ID , \"zone\" : $ZONE_ID , \"group\" : $GROUPE_ID , \"dealer\" : $AFFAIRE_ID}"
        
        
         let preferences = UserDefaults.standard
       
        
        //1  la langue
        let langueData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE);
        if(langueData_ != nil){
            if let langue_ = NSKeyedUnarchiver.unarchiveObject(with: langueData_!)  {
                
                let langue = langue_ as! Langue
                perimetreAsString = perimetreAsString.replacingOccurrences(of: "$LANGUE", with: langue.languageCode);
                
            }
        }else
        {
            perimetreAsString = perimetreAsString.replacingOccurrences(of: "$LANGUE", with: "en");
        }
        
        //2 le pays
        let paysData = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS);
        if(paysData != nil){
            if let pays_ = NSKeyedUnarchiver.unarchiveObject(with: paysData!)  {
                
                let pays = pays_ as! Pays
                perimetreAsString = perimetreAsString.replacingOccurrences(of: "$COUNTRY_ID", with: String(pays.countryId));
                
            }
        }
        else
        {
            perimetreAsString = perimetreAsString.replacingOccurrences(of: "$COUNTRY_ID", with: "null");
        }
        
        //3 zone
        let zoneData = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_ZONE);
        if(zoneData != nil){
            if let zone_ = NSKeyedUnarchiver.unarchiveObject(with: zoneData!)  {
                
                let zone = zone_ as! Zone
                 perimetreAsString = perimetreAsString.replacingOccurrences(of: "$ZONE_ID", with: String(zone.id));
                
            }
        }else
        {
             perimetreAsString = perimetreAsString.replacingOccurrences(of: "$ZONE_ID", with: "null");
        }
        
        //4 Groupe
        let groupeData = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_GROUPE);
        if(groupeData != nil){
            if let groupe_ = NSKeyedUnarchiver.unarchiveObject(with: groupeData!)  {
                
                let grp = groupe_ as! Groupe
                perimetreAsString = perimetreAsString.replacingOccurrences(of: "$GROUPE_ID", with: String(grp.id));
                
            }
        }else
        {
            perimetreAsString = perimetreAsString.replacingOccurrences(of: "$GROUPE_ID", with: "null");
        }
        
        //5 Affaire
        let dealerData = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE);
        if(dealerData != nil){
            if let dealer_ = NSKeyedUnarchiver.unarchiveObject(with: dealerData!)  {
                
                let affaire = dealer_ as! Dealer
                perimetreAsString = perimetreAsString.replacingOccurrences(of: "$AFFAIRE_ID", with: String(affaire.id));
                
            }
        }else
        {
           perimetreAsString = perimetreAsString.replacingOccurrences(of: "$AFFAIRE_ID", with: "null");
        }
        
        return perimetreAsString
    }
    // ***********************************
    // ***********************************
    // ***********************************
    static func getRadarsData(delegate : WSGetDonneesRadarsDelegate )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getDonneesRadarAccueil"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getRadarsData(delegate: delegate);
                        }else
                        {
                            delegate.didFinishWSGetDonneesRadars(error: true, data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseDataRadars =  Mapper<DataRadarWSResponse>().map(JSONObject:responseJson)
                if(responseDataRadars != nil)
                {
                    delegate.didFinishWSGetDonneesRadars(error: false, data: responseDataRadars)
                    return
                }
                
                delegate.didFinishWSGetDonneesRadars(error: true, data: nil)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSGetDonneesRadars(error: true, data: nil)
                break
                
            }
            
        }
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func getFamilleData(delegate : WSGetFamillesDelegate )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        //post params
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre
            
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/get-action-plan"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getFamilleData(delegate: delegate);
                        }else
                        {
                            delegate.didFinishWSGetActionsPlan(error: false, data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseDataFamilles =  Mapper<GetActionPlansWSResponse>().map(JSONObject:responseJson)
                if(responseDataFamilles != nil)
                {
                    delegate.didFinishWSGetActionsPlan(error: false, data: responseDataFamilles)
                    return
                }
                
                delegate.didFinishWSGetActionsPlan(error: true, data: nil)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSGetActionsPlan(error: true, data: nil)
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func getCategoriesData(delegate : WSGetCategoriesDelegate , famille_id : Int)
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        //post params
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre,
            "id_famille" : famille_id
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getListeCategories"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getCategoriesData(delegate: delegate, famille_id: famille_id);
                        }else
                        {
                            delegate.didFinishWSGetCategories(error: true, data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseDataCategories =  Mapper<DataCategoriesWSResponse>().map(JSONObject:responseJson)
                if(responseDataCategories != nil)
                {
                    delegate.didFinishWSGetCategories(error: false, data: responseDataCategories)
                    return
                }
                
               delegate.didFinishWSGetCategories(error: true, data: nil)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSGetCategories(error: true, data: nil)
                break
                
            }
            
        }
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func getGroupesKPIData(delegate : WSGetGroupesKPIDelegate , categorie_id : Int64)
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        //post params
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre,
            "id_category" : categorie_id
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getListeGroupes"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getGroupesKPIData(delegate: delegate, categorie_id: categorie_id);
                        }else
                        {
                            delegate.didFinishWSGetGroupesKPI(error: true, data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseDataCategories =  Mapper<DataGroupeKPIWSResponse>().map(JSONObject:responseJson)
                if(responseDataCategories != nil)
                {
                    delegate.didFinishWSGetGroupesKPI(error: false, data: responseDataCategories)
                    return
                }
                
                delegate.didFinishWSGetGroupesKPI(error: true, data: nil)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSGetGroupesKPI(error: true, data: nil)
                break
                
            }
            
        }
    }
    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func getIndicateurKPIsData(delegate : WSGetIndicateursKPIsDelegate , groupe_id : Int64 , date : Date)
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        //post params
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateAsString = dateFormatter.string(from: date)
        
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre,
            "id_groupe" : groupe_id,
            "date" : dateAsString
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getKPIs"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getIndicateurKPIsData(delegate: delegate, groupe_id: groupe_id, date: date);
                        }else
                        {
                            delegate.didFinishWSGetIndicateursKPIs(error: true, data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseDataKpis =  Mapper<DataKPIsWSResponse>().map(JSONObject:responseJson)
                if(responseDataKpis != nil)
                {
                    delegate.didFinishWSGetIndicateursKPIs(error: false, data: responseDataKpis)
                    return
                }
                
                delegate.didFinishWSGetIndicateursKPIs(error: true, data: nil)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSGetIndicateursKPIs(error: true, data: nil)
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func getBoardForcesTerrains(delegate : WSGetBoardsForcesTerrainsDelegate )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getBoardsForcesTerrains"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getBoardForcesTerrains(delegate: delegate);
                        }else
                        {
                            delegate.didFinishWSGetBoardsForcesTerrains(error: true, data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseForceTerrainBoards =  Mapper<DataForceTerrainToDoListWSResponse>().map(JSONObject:responseJson)
                if(responseForceTerrainBoards != nil)
                {
                    
                    responseForceTerrainBoards?.toDoList =  (responseForceTerrainBoards?.toDoList.sorted(by: { $0.order < $1.order }))!
                    responseForceTerrainBoards?.toDoList =  (responseForceTerrainBoards?.toDoList.sorted(by: { $0.boardType > $1.boardType }))!
                    
                    for  board in (responseForceTerrainBoards?.toDoList)!
                    {
                        board.tasks = board.tasks.sorted(by: { $0.taskOrder < $1.taskOrder })
                        
                        for i in (0 ..< board.tasks.count)
                        {
                            let taskA = board.tasks[i]
                            taskA.taskOrder = i + 1
                        }
                    }
 
                    delegate.didFinishWSGetBoardsForcesTerrains(error: false, data: responseForceTerrainBoards)
                    
                    return
                }
                
                delegate.didFinishWSGetBoardsForcesTerrains(error: true, data: nil)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSGetBoardsForcesTerrains(error: true, data: nil)
                break
                
            }
            
        }
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func getTacheForcesTerrains(delegate : WSGetTaskForcesTerrainsDelegate, taskId : Int64 )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        //post params
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "task" : taskId
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getTache"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getTacheForcesTerrains(delegate: delegate, taskId: taskId);
                        }else
                        {
                            delegate.didFinishWSGetTacheForcesTerrains(error: true, data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseForceTerrainTache =  Mapper<TacheForceTerrainWSResponse>().map(JSONObject:responseJson)
                if(responseForceTerrainTache != nil)
                {
                    
                    delegate.didFinishWSGetTacheForcesTerrains(error: false, data: responseForceTerrainTache)
                    
                    return
                }
                
                delegate.didFinishWSGetTacheForcesTerrains(error: true, data: nil)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSGetTacheForcesTerrains(error: true, data: nil)
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func addBoardForcesTerrains(delegate : WSAddBoardForcesTerrainsDelegate, boardName : String , code_couleur : String )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        let indexEndOfColor = code_couleur.index(code_couleur.endIndex, offsetBy: -2)
        let code_couleur_sans_alpha = code_couleur[..<indexEndOfColor]
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "title": boardName,
            "color": code_couleur_sans_alpha
            //"perimetre" : perimetre
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/addBoard"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.addBoardForcesTerrains(delegate: delegate, boardName: boardName, code_couleur: code_couleur);
                        }else
                        {
                            delegate.didFinishWSAddBoardForcesTerrains(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSAddBoardForcesTerrains(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSAddBoardForcesTerrains(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSAddBoardForcesTerrains(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func addTaskToBoardForcesTerrains(delegate : WSAddTaskToBoardForcesTerrainsDelegate, boardId : Int64, task : Tache )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var checkList = CheckList()
        if(task.checkLists.count > 0)
        {
            checkList = task.checkLists[0]
        }
        
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "board": boardId,
            "task_title": task.taskTitle,
            
            "check_list_title": checkList.checkListLibelle,
            "check_list_lastname": checkList.checkListNom,
            "check_list_firstname": checkList.checkListPrenom,
            "check_list_target": checkList.checkListTarget,
            "check_list_start": dateFormatter.string(from: checkList.checkListStart),
            "check_list_end": dateFormatter.string(from: checkList.checkListEnd),
            "check_list_statut": checkList.checkListStatut,
            "check_list_report": checkList.checkListReport,
            "task_zone": task.taskZone
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/addTache"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.addTaskToBoardForcesTerrains(delegate: delegate, boardId: boardId, task: task);
                        }else
                        {
                            delegate.didFinishWSAddTaskToBoard(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSAddTaskToBoard(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSAddTaskToBoard(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
               delegate.didFinishWSAddTaskToBoard(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func addCommentToTaskForcesTerrains(delegate : WSAddCommentToTaskForcesTerrainsDelegate, taskId : Int64, commentaire : Comment )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        var image64 : String = ""
        
        if(commentaire.files.count > 0)
        {
            let filePath = "documents_img/" + commentaire.files[0].fileName;
            let path = Utils.getDocumentsDirectory();
            let fileURLasString = path.appendingPathComponent(filePath)
            let image = UIImage(contentsOfFile: fileURLasString.path);
            let imageData = image?.jpegData(compressionQuality: 1.0);
            image64 = (imageData?.base64EncodedString())!;
            image64 = "data:image/jpg;base64," + image64
        }
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "task": taskId,
            "message": commentaire.message,
            "recipient": commentaire.recipient,
            "file": image64
            
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/addCommentaire"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.addCommentToTaskForcesTerrains(delegate: delegate, taskId: taskId, commentaire: commentaire);
                        }else
                        {
                            delegate.didFinishWSAddCommentToTask(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSAddCommentToTask(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSAddCommentToTask(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSAddCommentToTask(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func addFileToTaskForcesTerrains(delegate : WSAddFileToTaskForcesTerrainsDelegate, taskId : Int64, fichier : File )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        var image64 : String = ""
        let filePath = "documents_img/" + fichier.fileName;
        let path = Utils.getDocumentsDirectory();
        let fileURLasString = path.appendingPathComponent(filePath)
        let image = UIImage(contentsOfFile: fileURLasString.path);
        let imageData = image?.jpegData(compressionQuality: 1.0);
        image64 = (imageData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0)))!;
        image64 = "data:image/jpg;base64," + image64
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "task": taskId,
            "file": image64
            
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/addFile"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.addFileToTaskForcesTerrains(delegate: delegate, taskId: taskId, fichier: fichier);
                        }else
                        {
                            delegate.didFinishWSAddFileToTask(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSAddFileToTask(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSAddFileToTask(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSAddFileToTask(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func addCheckListToTaskForcesTerrains(delegate : WSAddCheckListToTaskForcesTerrainsDelegate, taskId : Int64, checkList : CheckList )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "task": taskId,
            "check_list_title": checkList.checkListLibelle,
            "check_list_lastname": checkList.checkListNom,
            "check_list_firstname": checkList.checkListPrenom,
            "check_list_target": checkList.checkListTarget,
            "check_list_start": dateFormatter.string(from: checkList.checkListStart),
            "check_list_end": dateFormatter.string(from: checkList.checkListEnd),
            "check_list_statut": checkList.checkListStatut, //"InProgress", //Completed
            "check_list_report": checkList.checkListReport
            
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/addChecklist"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.addCheckListToTaskForcesTerrains(delegate: delegate, taskId: taskId, checkList: checkList);
                        }else
                        {
                            delegate.didFinishWSAddCheckListToTask(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSAddCheckListToTask(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSAddCheckListToTask(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                 //print(response.result.error?.localizedDescription)
                delegate.didFinishWSAddCheckListToTask(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func deleteTaskForcesTerrains(delegate : WSDeleteTaskForcesTerrainsDelegate,task : Tache )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "task": task.taskId
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/deleteTache"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.deleteTaskForcesTerrains(delegate: delegate, task: task);
                        }else
                        {
                            delegate.didFinishWSDeleteTask(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSDeleteTask(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSDeleteTask(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                //print(response.result.error?.localizedDescription)
                delegate.didFinishWSDeleteTask(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func deleteFileForcesTerrains(delegate : WSDeleteFileForcesTerrainsDelegate,file : File )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "file": file.fileId
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/deleteFile"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.deleteFileForcesTerrains(delegate: delegate, file: file);
                        }else
                        {
                            delegate.didFinishWSDeleteFile(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSDeleteFile(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSDeleteFile(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                //print(response.result.error?.localizedDescription)
                delegate.didFinishWSDeleteFile(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func deleteBoardForcesTerrains(delegate : WSDeleteBoardForcesTerrainsDelegate,board : Board )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "board": board.boardId
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/deleteBoard"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.deleteBoardForcesTerrains(delegate: delegate, board: board);
                        }else
                        {
                            delegate.didFinishWSDeleteBoard(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSDeleteBoard(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSDeleteBoard(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                //print(response.result.error?.localizedDescription)
                delegate.didFinishWSDeleteBoard(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func deleteCheckListForcesTerrains(delegate : WSDeleteCheckListForcesTerrainsDelegate,checkList : CheckList )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "checklist": checkList.checkListId
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/deleteChecklist"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.deleteCheckListForcesTerrains(delegate: delegate, checkList: checkList);
                        }else
                        {
                            delegate.didFinishWSDeleteCheckList(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSDeleteCheckList(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSDeleteCheckList(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                //print(response.result.error?.localizedDescription)
                delegate.didFinishWSDeleteCheckList(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func deleteCommentaireForcesTerrains(delegate : WSDeleteCommentaireForcesTerrainsDelegate,commentaire : Comment )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "comment": commentaire.commentId
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/deleteCommentaire"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.deleteCommentaireForcesTerrains(delegate: delegate, commentaire: commentaire);
                        }else
                        {
                            delegate.didFinishWSDeleteCommentaire(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSDeleteCommentaire(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSDeleteCommentaire(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                //print(response.result.error?.localizedDescription)
                delegate.didFinishWSDeleteCommentaire(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func dragTaskForcesTerrains(delegate : WSDragTaskForcesTerrainsDelegate, board : Board ,task : Tache )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        var taskOrderString : String  = "["
        for i in (0 ..< board.tasks.count)
        {
            let task = board.tasks[i]
            if(i > 0)
            {
                taskOrderString.append(" , ")
            }
            taskOrderString.append("{")
            taskOrderString.append(" \"taskId\" : " + String(task.taskId) + ",")
            taskOrderString.append(" \"taskOrder\" : " + String(task.taskOrder) + "")
            taskOrderString.append("}")
        }
        taskOrderString.append("]")
        
        //post params
        //let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "board": board.boardId,
            "task": task.taskId,
            "task_order" : taskOrderString
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/dragTask"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.dragTaskForcesTerrains(delegate: delegate, board: board, task : task);
                        }else
                        {
                            delegate.didFinishWSDragTaskForcesTerrains(error: true, code_erreur: -1,description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSDragTaskForcesTerrains(error: false, code_erreur: code_erreur,description: desc_erreur)
                    return
                }
                
                delegate.didFinishWSDragTaskForcesTerrains(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSDragTaskForcesTerrains(error: true, code_erreur: -1,description: "NA Unknown")
                break
                
            }
            
        }
    }
    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func getListePiliers(delegate : WSGetListePiliersDelegate )
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getListePiliers"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getListePiliers(delegate: delegate);
                        }else
                        {
                            delegate.didFinishWSGetListePiliers(error: true, data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseDataListePiliers =  Mapper<ListePiliersWSResponse>().map(JSONObject:responseJson)
                if(responseDataListePiliers != nil)
                {
                    delegate.didFinishWSGetListePiliers(error: false, data: responseDataListePiliers)
                    return
                }
                
                delegate.didFinishWSGetListePiliers(error: true, data: nil)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSGetListePiliers(error: true, data: nil)
                break
                
            }
            
        }
    }
    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func getQuestionsPilier(delegate : WSGetQuestionPiliersDelegate , idPilier : Int64)
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre,
            "pilier" : idPilier
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/getQuestionsPilier"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.getQuestionsPilier(delegate: delegate, idPilier: idPilier);
                        }else
                        {
                            delegate.didFinishWSQuestionPiliers(error: true, data: nil)
                            return
                        }
                    })
                    
                    return;
                }
                
                let responseDataListePiliers =  Mapper<QuestionPiliersWSResponse>().map(JSONObject:responseJson)
                if(responseDataListePiliers != nil)
                {
                    delegate.didFinishWSQuestionPiliers(error: false, data: responseDataListePiliers)
                    return
                }
                
                delegate.didFinishWSQuestionPiliers(error: true, data: nil)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSQuestionPiliers(error: true, data: nil)
                break
                
            }
            
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func targetQuestionsPilier(delegate : WSTargetQuestionDelegate , idQuestionPilier : Int64)
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre,
            "question" : idQuestionPilier
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/targetQuestion"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? NSDictionary()
                let code = responseJson["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.targetQuestionsPilier(delegate: delegate, idQuestionPilier: idQuestionPilier);
                        }else
                        {
                            delegate.didFinishWSTargetQuestion(error: true, code_erreur: -1, description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSTargetQuestion(error: false, code_erreur: code_erreur, description: "")
                    return
                }
                
                delegate.didFinishWSTargetQuestion(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSTargetQuestion(error: true, code_erreur: -1, description: (response.result.error?.localizedDescription)!)
                break
                
            }
            
        }
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func updateQuestionsPilier(delegate : WSUpdateQuestionDelegate , questionPilier : QuestionPilier, statut : Bool, commentaire : String)
    {
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        
        //post params
        
        let perimetre = WSQueries.preparePerimetre();
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil,
            "perimetre" : perimetre,
            "question" : questionPilier.idQuestion,
            "statut" : statut,
            "commentaire" : commentaire
        ]
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/updateQuestion"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: headers_params).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value as? NSDictionary ?? nil
                let code = responseJson!["code"] as? Int ?? -1
                if(code == WSQueries.CODE_BAD_CREDENTIAL) // bad credential need to refresh token
                {
                    WSQueries.refreshToken(completion: { (code) in
                        if(code == WSQueries.CODE_RETOUR_200)
                        {
                            WSQueries.updateQuestionsPilier(delegate: delegate, questionPilier: questionPilier, statut: statut, commentaire: commentaire);
                        }else
                        {
                            delegate.didFinishWSUpdateQuestion(error: true, code_erreur: -1, description: "NA")
                            return
                        }
                    })
                    
                    return;
                }
                
                let code_erreur = responseJson!["code_erreur"] as? Int ?? -1
                let desc_erreur = responseJson!["description"] as? String ?? "NA"
                if(code_erreur == 0)
                {
                    delegate.didFinishWSUpdateQuestion(error: false, code_erreur: code_erreur, description: "")
                    return
                }
                
                delegate.didFinishWSUpdateQuestion(error: true, code_erreur: code_erreur, description: desc_erreur)
                
                break
                
            case .failure(_):
                // print(response.result.error?.localizedDescription)
                delegate.didFinishWSUpdateQuestion(error: true, code_erreur: -1, description: (response.result.error?.localizedDescription)!)
                break
                
            }
            
        }
    }
}
