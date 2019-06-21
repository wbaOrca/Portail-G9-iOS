//
//  Direction.swift
//  Portail G9
//
//  Created by WBA_ORCA on 21/06/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper
import RSSelectionMenu

class Direction: NSObject , Mappable , NSCoding , UniqueProperty {
    
    
    var id   : Int64 = -1
    var libelle   : String = ""
    var zoneIdClient   : String = ""
    
    var zones   : [Zone] = [Zone]()
    var groupes   : [Groupe] = [Groupe]()
    
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
        
        zones <- map["zones"]
        groupes <- map["groupes"]
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
        
        aCoder.encode(zones, forKey: "zones")
        aCoder.encode(groupes, forKey: "groupes")
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
        
        self.zones = decoder.decodeObject(forKey: "zones") as? [Zone] ?? [Zone] ()
        self.groupes = decoder.decodeObject(forKey: "groupes") as? [Groupe] ?? [Groupe]()
        
    }
}
