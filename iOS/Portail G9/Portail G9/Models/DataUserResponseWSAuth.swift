//
//  DataUserResponseWSAuth.swift
//  Portail G9
//
//  Created by WBA_ORCA on 11/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class DataUserResponseWSAuth: NSObject  , Mappable {
    
    var token : String = ""
    var utilisateur : Utilisateur! = nil
    
    //******
    //******
    //******
    required init?(map: Map) {
        
    }
    
    //******
    //******
    //******
    override init() {
        super.init()
    }

    // *****************************************
    // *****************************************
    // ****** mapping
    // *****************************************
    // *****************************************
    // Mappable
    func mapping(map: Map) {
        
        
        token <- map["token"]
        utilisateur <- map["user"]
        
    }
    
}
