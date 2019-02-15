//
//  KPILigne.swift
//  Portail G9
//
//  Created by WBA_ORCA on 15/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class KPILigne: NSObject ,Mappable{

    var libelle : String = ""
    var code_couleur : String = ""
    var bg_color : String = ""
    var valeur : String = ""
    var numero : Int = 0
    var style : StyleKPILigne! = StyleKPILigne()
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
        
        libelle <- map["libelle"]
        code_couleur <- map["code_couleur"]
        bg_color <- map["bg_color"]
        valeur <- map["valeur"]
        numero <- map["numero"]
        style <- map["style"]
        
        bg_color = bg_color + "FF"
    }
}
