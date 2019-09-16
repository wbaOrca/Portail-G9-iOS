//
//  Groupe.swift
//  Portail G9
//
//  Created by WBA_ORCA on 12/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper
import RSSelectionMenu

class Groupe: NSObject, Mappable , NSCoding, UniqueProperty  {

    var id   : Int64 = -1
    var libelle   : String = ""
    var zoneIdClient   : String = ""
    var parentId   : [Int64] = [Int64]()
    
    //******
    //******
    //******
    func uniquePropertyName() -> String {
        return "id"
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
        
        id <- map["id"]
        libelle <- map["libelle"]
        zoneIdClient <- map["zoneIdClient"]
        parentId <- map["ParentId"]
        
    }
    
    // *****************************************
    // *****************************************
    // ****** encode
    // *****************************************
    // *****************************************
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(libelle, forKey: "libelle")
        aCoder.encode(zoneIdClient, forKey: "zoneIdClient")
        
        aCoder.encode(parentId, forKey: "parentId")
    }
    
    // *****************************************
    // *****************************************
    // ****** init
    // *****************************************
    // *****************************************
    required init(coder decoder: NSCoder) {
        
        self.id = decoder.decodeInt64(forKey: "id")
        self.libelle = decoder.decodeObject(forKey: "libelle") as? String ?? ""
        self.zoneIdClient = decoder.decodeObject(forKey: "zoneIdClient") as? String ?? ""
        self.parentId = decoder.decodeObject(forKey: "parentId") as? [Int64] ?? [Int64] ()
        
        
    }
}
