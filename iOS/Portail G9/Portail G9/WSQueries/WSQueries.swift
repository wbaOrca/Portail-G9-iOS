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
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    static func authenticateUser(login : String, password : String, delegate : WSAuthentificationDelegate)
    {
        let passwordChiffre = Utils.chiffrerPassword(password: password)
        
        let post_params: Parameters = [
            "login": login,
            "pwd": passwordChiffre,
            "isMobile" : 1
        ]
        
        
        let url_ = Version.URL_WS_PORTAIL_G9 + "/authUser"
        
        Alamofire.request(url_, method: .post, parameters: post_params, encoding:  URLEncoding.default, headers: nil).responseJSON {  response  in
            
            
            switch(response.result) {
            case .success(_):
                
                let responseJson = response.result.value
                //print("JSON: \(listResponseJson)")
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
    

}
