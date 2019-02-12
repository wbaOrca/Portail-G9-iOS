//
//  Dealer.swift
//  Portail G9
//
//  Created by WBA_ORCA on 12/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class Dealer: NSObject, Mappable , NSCoding {

    var id   : Int64 = -1
    var libelle   : String = ""
    var zoneIdClient   : String = ""
    
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
        
    }
}
