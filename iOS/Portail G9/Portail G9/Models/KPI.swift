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
    
    
    // *****************************************
    // *****************************************
    // ****** mapping
    // *****************************************
    // *****************************************
    // Mappable
    static func translateKPIColonneToLigne (arrayKPI : [KPI]) -> [IndicateurKPISection]
    {
        var new_array = [IndicateurKPISection]()
        
        // 1 - récupérer toute les sections
        if(arrayKPI.count > 0)
        {
            let kpi_ = arrayKPI[0]
            for j in (0 ..< kpi_.lignes.count)
            {
                let ligne_ = kpi_.lignes[j]
                
                let section = IndicateurKPISection()
                if(ligne_.numero > 0)
                {
                    section.titreSection = String(ligne_.numero) + " - " + ligne_.libelle
                }else
                {
                    section.titreSection = ligne_.libelle
                }
                new_array.append(section);
            }
        }
        let nombre_section = new_array.count
        
        // 2 - récupérer toute les sections
        
        for compteur in (0 ..< nombre_section)
        {
            let section = new_array[compteur]
            for i in (0 ..< arrayKPI.count)
            {
                let kpi_ = arrayKPI[i]
                if (compteur < kpi_.lignes.count)
                {
                    let ligne_ = kpi_.lignes[compteur]
                    ligne_.libelle = kpi_.colonne
                    section.elementsSection.append(ligne_)
                }
            }
        }
        
        return new_array
    }
    
    
    // *****************************************
    // *****************************************
    // ****** translateIndicateurKPISectionToArrayString
    // *****************************************
    // *****************************************
    // Mappable
    static func translateIndicateurKPISectionToArrayString (arrayKPI : [IndicateurKPISection]) ->  [[String]]
    {
        var array = [[String]]()
        
        //recuperer les entetes : noms des variables kpi
        if(arrayKPI.count > 0)
        {
            let kpi = arrayKPI[0];
             var arrayHeader = [String]()
            arrayHeader.append("")
            for j in (0 ..< kpi.elementsSection.count)
            {
                let kpiColonne = kpi.elementsSection[j];
                arrayHeader.append(kpiColonne.libelle)
            }
            array.append(arrayHeader)
        }
        //recuperer les valeurs ligne
        for i in (0 ..< arrayKPI.count)
        {
            var arrayHeader = [String]()
            let kpi = arrayKPI[i];
            arrayHeader.append(kpi.titreSection)
            for j in (0 ..< kpi.elementsSection.count)
            {
                let kpiColonne = kpi.elementsSection[j];
                arrayHeader.append(kpiColonne.valeur)
            }
            
            array.append(arrayHeader)
        }
        return array;
    }
    
}
