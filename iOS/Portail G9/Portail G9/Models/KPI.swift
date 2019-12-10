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
    // *****************************************
    // *****************************************
    
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
                section.codeCouleur = ligne_.code_couleur
                section.style = ligne_.style
                
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
                    ligne_.code_couleur = kpi_.code_couleur
                    section.elementsSection.append(ligne_)
                }
            }
        }
        
        return new_array
    }
    
    // *****************************************
    // *****************************************
    // *****************************************
    // *****************************************
    static func translateKPIToIndicateurKPISection (arrayKPI : [KPI]) -> [IndicateurKPISection]
    {
        var new_array = [IndicateurKPISection]()
        
        for compteur in (0 ..< arrayKPI.count)
        {
            let kpi_ = arrayKPI[compteur];
            
            let section = IndicateurKPISection()
            
            section.titreSection = kpi_.colonne
            section.codeCouleur = kpi_.code_couleur
            
            for j in (0 ..< kpi_.lignes.count)
            {
                let ligne_ = kpi_.lignes[j]
                section.elementsSection.append(ligne_)
            }
            
            
            new_array.append(section);
        }
        
        
        return new_array
    }
    
    
    
    
    
    // *****************************************
    // *****************************************
    // ****** translateIndicateurKPISectionToArrayGrid
    // *****************************************
    // *****************************************
    
    static func translateIndicateurKPISectionToArrayGrid (arrayKPI : [IndicateurKPISection]) ->  [[IndicateurKPIGrid]]
    {
        var array = [[IndicateurKPIGrid]]()
        
        //recuperer les entetes : noms des variables kpi
        if(arrayKPI.count > 0)
        {
            let kpi = arrayKPI[0];
            var arrayHeader = [IndicateurKPIGrid]()
            
            // colonne 0-0
            let indicateurHeader = IndicateurKPIGrid()
            indicateurHeader.isHeaderLigne = true
            indicateurHeader.indicateurKPI.valeur = ""
            indicateurHeader.indicateurKPI.code_couleur = "#000000"
            arrayHeader.append(indicateurHeader)
            
            for j in (0 ..< kpi.elementsSection.count)
            {
                let kpiColonne = kpi.elementsSection[j];
                let indicateurHeader = IndicateurKPIGrid()
                indicateurHeader.isHeaderLigne = true
                indicateurHeader.indicateurKPI.valeur = kpiColonne.libelle
                indicateurHeader.indicateurKPI.code_couleur = kpiColonne.code_couleur
                arrayHeader.append(indicateurHeader)
                
            }
            array.append(arrayHeader)
        }
        //recuperer les valeurs ligne
        for i in (0 ..< arrayKPI.count)
        {
            var arrayHeader = [IndicateurKPIGrid]()
            let kpi = arrayKPI[i];
            
           
            let indicateurHeader = IndicateurKPIGrid()
            indicateurHeader.isColonneLigne = true
            indicateurHeader.indicateurKPI.valeur = kpi.titreSection
            indicateurHeader.indicateurKPI.style = kpi.style
            arrayHeader.append(indicateurHeader)
            
            for j in (0 ..< kpi.elementsSection.count)
            {
                let kpiColonne = kpi.elementsSection[j];
                let indicateurHeader = IndicateurKPIGrid()
                indicateurHeader.indicateurKPI = kpiColonne
                indicateurHeader.indicateurKPI.valeur = kpiColonne.valeur
                indicateurHeader.indicateurKPI.libelle = kpi.titreSection
                arrayHeader.append(indicateurHeader)
                
            }
            
            array.append(arrayHeader)
        }
        return array;
    }
    
    // *****************************************
    // *****************************************
    // ****** translateIndicateurKPISectionToArrayGrid
    // *****************************************
    // *****************************************
    static func translateIndicateurKPISectionToArrayGrid2 (arrayKPI : [IndicateurKPISection]) ->  [[IndicateurKPIGrid]]
    {
        var array = [[IndicateurKPIGrid]]()
        
        //recuperer les entetes : noms des variables kpi
        if(arrayKPI.count > 0)
        {
            let kpi = arrayKPI[0];
            var arrayHeader = [IndicateurKPIGrid]()
            
            //colonne 0-0
            let indicateurHeader = IndicateurKPIGrid()
            indicateurHeader.isHeaderLigne = true
            indicateurHeader.indicateurKPI.valeur = ""
            indicateurHeader.indicateurKPI.code_couleur = "#000000"
            arrayHeader.append(indicateurHeader)
            
            
            for j in (0 ..< kpi.elementsSection.count)
            {
                let kpiColonne = kpi.elementsSection[j];
                let indicateurHeader = IndicateurKPIGrid()
                indicateurHeader.isHeaderLigne = true
                indicateurHeader.indicateurKPI.valeur = kpiColonne.libelle
                indicateurHeader.indicateurKPI.code_couleur = kpiColonne.code_couleur
                arrayHeader.append(indicateurHeader)
                
            }
            array.append(arrayHeader)
        }
        //recuperer les valeurs ligne
        for i in (0 ..< arrayKPI.count)
        {
            var arrayHeader = [IndicateurKPIGrid]()
            let kpi = arrayKPI[i];
            
            
            let indicateurHeader = IndicateurKPIGrid()
            indicateurHeader.isColonneLigne = true
            indicateurHeader.indicateurKPI.valeur = kpi.titreSection
            indicateurHeader.indicateurKPI.style = kpi.style
            arrayHeader.append(indicateurHeader)
            
            for j in (0 ..< kpi.elementsSection.count)
            {
                let kpiColonne = kpi.elementsSection[j];
                let indicateurHeader = IndicateurKPIGrid()
                indicateurHeader.indicateurKPI = kpiColonne
                indicateurHeader.indicateurKPI.valeur = kpiColonne.valeur
               
                arrayHeader.append(indicateurHeader)
                
            }
            
            array.append(arrayHeader)
        }
        return array;
    }
    
    
    
   
    
}
