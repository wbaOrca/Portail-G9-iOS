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
    static func getDonneesUtiles(delegate : WSGetDataUtilesDelegate)
    {
       
        
        
        // headers autorization
        var authorization_ = "Bearer "
        let preferences = UserDefaults.standard
        let token = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_TOKEN) as? String ?? "";
        authorization_ = authorization_ + token
        
        let headers_params = [
            "Authorization": authorization_
        ]
        
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        let post_params: Parameters = [
            "profil": profil
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
                            WSQueries.getDonneesUtiles(delegate: delegate)
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
    static func getRadarsData(delegate : WSGetDonneesRadarsDelegate , langue_code : String, pays_id : Int, zone_id : Int!, groupe_id : Int! , affaire_id : Int!)
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
        var perimetre = "{\"langue\" : \"$LANGUE\", \"country\" : $COUNTRY_ID , \"zone\" : $ZONE_ID , \"group\" : $GROUPE_ID , \"dealer\" : $AFFAIRE_ID}"
        perimetre = perimetre.replacingOccurrences(of: "$LANGUE", with: langue_code);
        perimetre = perimetre.replacingOccurrences(of: "$COUNTRY_ID", with: String(pays_id));
        if(zone_id == nil)
        {
            perimetre = perimetre.replacingOccurrences(of: "$ZONE_ID", with: "null");
        }else
        {
            perimetre = perimetre.replacingOccurrences(of: "$ZONE_ID", with: String(zone_id));
        }
        if(groupe_id == nil)
        {
            perimetre = perimetre.replacingOccurrences(of: "$GROUPE_ID", with: "null");
        }else
        {
            perimetre = perimetre.replacingOccurrences(of: "$GROUPE_ID", with: String(groupe_id));
        }
        if(affaire_id == nil)
        {
            perimetre = perimetre.replacingOccurrences(of: "$AFFAIRE_ID", with: "null");
        }else
        {
            perimetre = perimetre.replacingOccurrences(of: "$AFFAIRE_ID", with: String(affaire_id));
        }
        
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
                            WSQueries.getRadarsData(delegate: delegate,langue_code: langue_code,pays_id: pays_id,zone_id: zone_id,groupe_id: groupe_id,affaire_id: affaire_id);
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
}
