//
//  DataUtiles.swift
//  Portail G9
//
//  Created by WBA_ORCA on 12/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class DataUtiles: NSObject , Mappable{

    var langues : [Langue] = [Langue]()
    var perimetre : [Pays] = [Pays]()
    
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
        
        
        langues <- map["langues"]
        perimetre <- map["perimetre"]
        
    }
}
