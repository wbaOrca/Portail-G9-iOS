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
    // *****************************************
    // *****************************************
    // ******
    // *****************************************
    // *****************************************
    public static func initStaticTable() -> [Famille]
    {
        var arrayFamille = [Famille]()
        
        let famille1 = Famille()
        famille1.RubriqueTitle = NSLocalizedString("Vente", comment: "")
        famille1.RubriqueId = 1
        for i in (1 ..< 3)
        {
           let categorieF = CategorieFamille()
            categorieF.CategorieTitle = "categorie " + String(i)
            
            for j in (1 ..< 5)
            {
                let kpi = KPICategorieFamille()
                kpi.title = "kpi indicateur " + String(i) + " - " + String(j)
                if(j % 2 == 0)
                {
                    kpi.isCible = true
                }
                categorieF.kpis.append(kpi)
            }
            
            famille1.categories.append(categorieF)
        }
        
        arrayFamille.append(famille1)
        
        let famille2 = Famille()
        famille2.RubriqueTitle = NSLocalizedString("Après ventes", comment: "")
        famille2.RubriqueId = 2
        for i in (1 ..< 3)
        {
            let categorieF = CategorieFamille()
            categorieF.CategorieTitle = "categorie " + String(i)
            
            for j in (1 ..< 4)
            {
                let kpi = KPICategorieFamille()
                kpi.title = "kpi indicateur " + String(i) + " - " + String(j)
                if(j % 2 == 0)
                {
                    kpi.isCible = true
                }
                categorieF.kpis.append(kpi)
            }
            
            famille2.categories.append(categorieF)
        }
        arrayFamille.append(famille2)
        
        let famille3 = Famille()
        famille3.RubriqueTitle = NSLocalizedString("Clients", comment: "")
        famille3.RubriqueId = 3
        for i in (1 ..< 2)
        {
            let categorieF = CategorieFamille()
            categorieF.CategorieTitle = "categorie " + String(i)
            
            for j in (1 ..< 3)
            {
                let kpi = KPICategorieFamille()
                kpi.title = "kpi indicateur " + String(i) + " - " + String(j)
                if(j % 2 == 0)
                {
                    kpi.isCible = true
                }
                categorieF.kpis.append(kpi)
            }
            
            famille3.categories.append(categorieF)
        }
        arrayFamille.append(famille3)
        
        let famille4 = Famille()
        famille4.RubriqueTitle = NSLocalizedString("Image de marque", comment: "")
        famille4.RubriqueId = 4
        for i in (1 ..< 2)
        {
            let categorieF = CategorieFamille()
            categorieF.CategorieTitle = "categorie " + String(i)
            
            for j in (1 ..< 3)
            {
                let kpi = KPICategorieFamille()
                kpi.title = "kpi indicateur " + String(i) + " - " + String(j)
                if(j % 2 == 0)
                {
                    kpi.isCible = true
                }
                categorieF.kpis.append(kpi)
            }
            
            famille4.categories.append(categorieF)
        }
        arrayFamille.append(famille4)
        
        famille1.rassemblerKPI()
        famille2.rassemblerKPI()
        famille3.rassemblerKPI()
        famille4.rassemblerKPI()
        
        return arrayFamille;
    }
}
