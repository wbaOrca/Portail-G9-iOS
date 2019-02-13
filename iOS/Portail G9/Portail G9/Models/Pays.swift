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
    var countryZoneCode   : String = ""
    var zones   : [Zone] = [Zone]()
    var groupes   : [Groupe] = [Groupe]()
    
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
        
        countryId <- map["countryId"]
        countryLib <- map["countryLib"]
        countryZoneCode <- map["countryZoneCode"]
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
        aCoder.encode(countryId, forKey: "countryId")
        aCoder.encode(countryLib, forKey: "countryLib")
        aCoder.encode(countryZoneCode, forKey: "countryZoneCode")
        aCoder.encode(zones, forKey: "zones")
        aCoder.encode(groupes, forKey: "groupes")
    }
    
    // *****************************************
    // *****************************************
    // ****** init
    // *****************************************
    // *****************************************
    required init(coder decoder: NSCoder) {
        
        self.countryId = decoder.decodeInt64(forKey: "countryId")
        self.countryLib = decoder.decodeObject(forKey: "countryLib") as? String ?? ""
        self.countryZoneCode = decoder.decodeObject(forKey: "countryZoneCode") as? String ?? ""
        self.zones = decoder.decodeObject(forKey: "zones") as? [Zone] ?? [Zone] ()
        self.groupes = decoder.decodeObject(forKey: "groupes") as? [Groupe] ?? [Groupe]()
        
    }
}
