//
//  Famille.swift
//  Portail G9
//
//  Created by WBA_ORCA on 14/06/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class Famille: NSObject ,Mappable{

    var RubriqueTitle : String = ""
    var RubriqueId : Int = 0
    var categories : [CategorieFamille]! = [CategorieFamille]()
    
    var kpisRassembles : [KPICategorieFamille]! = [KPICategorieFamille]()
    
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
        
        RubriqueTitle <- map["RubriqueTitle"]
        RubriqueId <- map["RubriqueId"]
        categories <- map["categories"]
        
    }
    
    // *****************************************
    // *****************************************
    // ******
    // *****************************************
    // *****************************************
    func rassemblerKPI()
    {
        self.kpisRassembles.removeAll()
        for i in (0 ..< self.categories.count)
        {
            let categorie = self.categories[i]
            for j in (0 ..< categorie.kpis.count)
            {
                let kpi = categorie.kpis[j]
                self.kpisRassembles.append(kpi)
            }
            
        }
    }
    
}
