//
//  KPIColonne.swift
//  Portail G9
//
//  Created by WBA_ORCA on 15/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class KPI: NSObject ,Mappable{

    var colonne : String = ""
    var code_couleur : String = ""
    var lignes : [KPILigne] = [KPILigne]()
    
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
        
        colonne <- map["colonne"]
        code_couleur <- map["code_couleur"]
        lignes <- map["lignes"]
        
        
    }
}
