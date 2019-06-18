//
//  KPICategorieFamille.swift
//  Portail G9
//
//  Created by WBA_ORCA on 18/06/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class KPICategorieFamille: NSObject ,Mappable{

    var title : String = ""
    var kpiId : Int = 0
    var isCible : Bool = false
    var isChecked : Bool = false
    var isAutoChecked : Bool = false
    
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
        
        title <- map["title"]
        kpiId <- map["kpiId"]
        isCible <- map["isCible"]
        isChecked <- map["isChecked"]
        isAutoChecked <- map["isAutoChecked"]
        
    }
}
