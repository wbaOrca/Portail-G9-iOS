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

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++

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
    

}
