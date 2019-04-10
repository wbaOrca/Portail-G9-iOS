//
//  Pilier.swift
//  Portail G9
//
//  Created by WBA_ORCA on 04/04/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper
import RSSelectionMenu

class Pilier: NSObject, Mappable , NSCoding, UniqueProperty {

    var pilierId : Int64 = -1
    var pilierLibelle : String = ""
    var pilierIcone : String = ""
    var pilierStatut : String = ""
    var pilierStatutCodeCouleur : String = ""
    
    //******
    //******
    //******
    func uniquePropertyName() -> String {
        return "pilierId"
    }
    
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
        
        pilierId <- map["pilierId"]
        pilierLibelle <- map["pilierLibelle"]
        pilierIcone <- map["pilierIcone"]
        pilierStatut <- map["pilierStatut"]
        pilierStatutCodeCouleur <- map["pilierStatutCodeCouleur"]
        
        pilierStatutCodeCouleur = pilierStatutCodeCouleur + "FF"
        
    }
    
    // *****************************************
    // *****************************************
    // ****** encode
    // *****************************************
    // *****************************************
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(pilierId, forKey: "pilierId")
        aCoder.encode(pilierLibelle, forKey: "pilierLibelle")
        aCoder.encode(pilierIcone, forKey: "pilierIcone")
        aCoder.encode(pilierStatut, forKey: "pilierStatut")
        aCoder.encode(pilierStatutCodeCouleur, forKey: "pilierStatutCodeCouleur")
        
    }
    
    // *****************************************
    // *****************************************
    // ****** init
    // *****************************************
    // *****************************************
    required init(coder decoder: NSCoder) {
        
        self.pilierId = decoder.decodeInt64(forKey: "pilierId")
        self.pilierLibelle = decoder.decodeObject(forKey: "pilierLibelle") as? String ?? ""
        self.pilierIcone = decoder.decodeObject(forKey: "pilierIcone") as? String ?? ""
        self.pilierStatut = decoder.decodeObject(forKey: "pilierStatut") as? String ?? ""
        self.pilierStatutCodeCouleur = decoder.decodeObject(forKey: "pilierStatutCodeCouleur") as? String ?? ""
        
    }
}
