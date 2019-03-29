//
//  DataTask.swift
//  Portail G9
//
//  Created by WBA_ORCA on 29/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class DataTask: NSObject, Mappable {

    var task : Tache! = nil
    
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
        
       
        task <- map["task"]
        
        
    }
}
