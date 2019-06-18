//
//  getActionPlansWSResponse.swift
//  Portail G9
//
//  Created by WBA_ORCA on 18/06/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class GetActionPlansWSResponse: NSObject, Mappable {
    
    
    var code_erreur : Int = 0
    var code : Int = 0
    var description_ : String = ""
    
    var familles : [Famille]! = [Famille]()
    
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
        familles <- map["data"]
        
    }
}

