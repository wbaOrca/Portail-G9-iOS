//
//  MonthQuestionPilier.swift
//  Portail G9
//
//  Created by WBA_ORCA on 15/04/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class MonthQuestionPilier: NSObject , Mappable {
    
    
    var month : String = ""
    var order : Int = -1
    var isTargeted : Bool! = nil
    var value : Bool! = nil
    
    
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
        
        month <- map["month"]
        order <- map["order"]
        isTargeted <- map["isTargeted"]
        value <- map["value"]
        
        
    }
}
