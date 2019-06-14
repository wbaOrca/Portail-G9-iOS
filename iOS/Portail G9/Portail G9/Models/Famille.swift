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

    var libelle : String = ""
    var id : Int = 0
    var indicateurs : [KPILigne]! = [KPILigne]()
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
        id <- map["id"]
        indicateurs <- map["indicateurs"]
        
    }
    
    // *****************************************
    // *****************************************
    // ******
    // *****************************************
    // *****************************************
    public static func initStaticTable() -> [Famille]
    {
        var arrayFamille = [Famille]()
        
        let famille1 = Famille()
        famille1.libelle = NSLocalizedString("Vente", comment: "")
        famille1.id = 1
        for i in (1 ..< 5)
        {
           let indicateur = KPILigne()
            indicateur.libelle = "Indicateur " + String(i)
            if(i % 2 == 0)
            {
                indicateur.isCoched = true
            }
            famille1.indicateurs.append(indicateur)
        }
        arrayFamille.append(famille1)
        
        let famille2 = Famille()
        famille2.libelle = NSLocalizedString("Après ventes", comment: "")
        famille2.id = 2
        for i in (1 ..< 6)
        {
            let indicateur = KPILigne()
            indicateur.libelle = "Indicateur " + String(i)
            if(i % 2 == 0)
            {
                indicateur.isCoched = true
            }
            famille2.indicateurs.append(indicateur)
            
        }
        arrayFamille.append(famille2)
        
        let famille3 = Famille()
        famille3.libelle = NSLocalizedString("Clients", comment: "")
        famille3.id = 3
        for i in (1 ..< 3)
        {
            let indicateur = KPILigne()
            indicateur.libelle = "Indicateur " + String(i)
            if(i % 2 == 0)
            {
                indicateur.isCoched = true
            }
            famille3.indicateurs.append(indicateur)
        }
        arrayFamille.append(famille3)
        
        let famille4 = Famille()
        famille4.libelle = NSLocalizedString("Image de marque", comment: "")
        famille4.id = 4
        for i in (1 ..< 4)
        {
            let indicateur = KPILigne()
            indicateur.libelle = "Indicateur " + String(i)
            if(i % 2 == 0)
            {
                indicateur.isCoched = true
            }
            famille4.indicateurs.append(indicateur)
        }
        arrayFamille.append(famille4)
        
        return arrayFamille;
    }
}
