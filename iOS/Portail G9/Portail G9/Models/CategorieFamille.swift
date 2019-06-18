//
//  CategorieFamille.swift
//  Portail G9
//
//  Created by WBA_ORCA on 18/06/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class CategorieFamille: NSObject ,Mappable{

    var CategorieTitle : String = ""
    var CategorieId : Int = 0
    var kpis : [KPICategorieFamille]! = [KPICategorieFamille]()
    
    
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
        
        CategorieTitle <- map["CategorieTitle"]
        CategorieId <- map["CategorieId"]
        kpis <- map["kpis"]
        
    }
    
}
