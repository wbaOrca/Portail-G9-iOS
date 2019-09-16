//
//  Perimetre.swift
//  Portail G9
//
//  Created by WBA_ORCA on 16/09/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class Perimetre: NSObject , Mappable , NSCoding {

    
    var pays : [Pays] = [Pays]()
    var directions   : [Direction] = [Direction]()
    var zones   : [Zone] = [Zone]()
    var groupes   : [Groupe] = [Groupe]()
    var dealers   : [Dealer] = [Dealer]()
    
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
        
        
        pays <- map["pays"]
        directions <- map["directions"]
        zones <- map["zones"]
        groupes <- map["groupes"]
        dealers <- map["dealers"]
        
    }
    
    
    // *****************************************
    // *****************************************
    // ****** encode
    // *****************************************
    // *****************************************
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(pays, forKey: "pays")
        aCoder.encode(directions, forKey: "directions")
        aCoder.encode(zones, forKey: "zones")
        aCoder.encode(groupes, forKey: "groupes")
        aCoder.encode(dealers, forKey: "dealers")
    }
    
    // *****************************************
    // *****************************************
    // ****** init
    // *****************************************
    // *****************************************
    required init(coder decoder: NSCoder) {
        
        self.pays = decoder.decodeObject(forKey: "pays") as? [Pays] ?? [Pays]()
        self.directions = decoder.decodeObject(forKey: "directions") as? [Direction] ?? [Direction]()
        self.zones = decoder.decodeObject(forKey: "zones") as? [Zone] ?? [Zone]()
        self.groupes = decoder.decodeObject(forKey: "groupes") as? [Groupe] ?? [Groupe]()
        self.dealers = decoder.decodeObject(forKey: "dealers") as? [Dealer] ?? [Dealer]()
        
    }
}
