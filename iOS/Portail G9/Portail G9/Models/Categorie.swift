//
//  Categorie.swift
//  Portail G9
//
//  Created by WBA_ORCA on 14/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class Categorie: NSObject, Mappable {

    var categoryId   : Int64 = -1
    var categoryLibelle   : String = ""
    var categoryIcone   : String = ""
    
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
        
        categoryId <- map["categoryId"]
        categoryLibelle <- map["categoryLibelle"]
        categoryIcone <- map["categoryIcone"]
        
        categoryLibelle = categoryLibelle.uppercased()
    }
}
