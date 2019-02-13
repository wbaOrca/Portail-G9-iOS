//
//  Zone.swift
//  Portail G9
//
//  Created by WBA_ORCA on 12/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper
import RSSelectionMenu

class Zone: NSObject , Mappable , NSCoding, UniqueProperty {

    var id   : Int64 = -1
    var libelle   : String = ""
    var zoneIdClient   : String = ""
    var dealers   : [Dealer] = [Dealer]()
    
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
        dealers <- map["dealers"]
        
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
        aCoder.encode(dealers, forKey: "dealers")
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
        self.dealers = decoder.decodeObject(forKey: "dealers") as? [Dealer] ?? [Dealer] ()
        
        
    }
    
}
