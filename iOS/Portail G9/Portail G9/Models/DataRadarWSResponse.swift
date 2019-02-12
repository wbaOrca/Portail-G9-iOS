//
//  DataRadarWSResponse.swift
//  Portail G9
//
//  Created by WBA_ORCA on 12/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class DataRadarWSResponse: NSObject , Mappable {
    
    var code_erreur : Int = 0
    var code : Int = 0
    var description_ : String = ""
    
    var dataRadar : DataRadar! = nil
    
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
        
        code_erreur <- map["code_erreur"]
        code <- map["code"]
        description_ <- map["description"]
        
        dataRadar <- map["data"]
        
        
    }
}

