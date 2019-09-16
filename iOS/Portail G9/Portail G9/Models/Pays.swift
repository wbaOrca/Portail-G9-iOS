//
//  Pays.swift
//  Portail G9
//
//  Created by WBA_ORCA on 12/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper
import RSSelectionMenu

class Pays: NSObject , Mappable , NSCoding , UniqueProperty {

    
    var countryId   : Int64 = -1
    var countryLib   : String = ""
    var zoneIdClient   : String = ""
    var hasDr   : Bool = false
    var parentId   : [Int64] = [Int64]()
    
    //******
    //******
    //******
    func uniquePropertyName() -> String {
        return "countryId"
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
        
        countryId <- map["id"]
        countryLib <- map["libelle"]
        zoneIdClient <- map["zoneIdClient"]
        hasDr <- map["hasDr"]
        parentId <- map["ParentId"]
        
    }
    
    // *****************************************
    // *****************************************
    // ****** encode
    // *****************************************
    // *****************************************
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(countryId, forKey: "countryId")
        aCoder.encode(countryLib, forKey: "countryLib")
        aCoder.encode(zoneIdClient, forKey: "zoneIdClient")
        aCoder.encode(hasDr, forKey: "hasDr")
        aCoder.encode(parentId, forKey: "parentId")
    }
    
    // *****************************************
    // *****************************************
    // ****** init
    // *****************************************
    // *****************************************
    required init(coder decoder: NSCoder) {
        
        self.countryId = decoder.decodeInt64(forKey: "countryId")
        self.hasDr = decoder.decodeBool(forKey: "hasDr")
        self.countryLib = decoder.decodeObject(forKey: "countryLib") as? String ?? ""
        self.zoneIdClient = decoder.decodeObject(forKey: "zoneIdClient") as? String ?? ""
        self.parentId = decoder.decodeObject(forKey: "parentId") as? [Int64] ?? [Int64] ()
        
    }
}
