//
//  Langue.swift
//  Portail G9
//
//  Created by WBA_ORCA on 12/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class Langue: NSObject , Mappable , NSCoding {

    var languageId   : Int = -1
    var libelle   : String = ""
    var languageCode   : String = ""
    var languageIcone   : String = ""
    
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
        
        languageId <- map["languageId"]
        languageCode <- map["languageCode"]
        libelle    <- map["libelle"]
        languageIcone    <- map["languageIcone"]
        
    }
    
    // *****************************************
    // *****************************************
    // ****** encode
    // *****************************************
    // *****************************************
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(languageId, forKey: "languageId")
        aCoder.encode(languageCode, forKey: "languageCode")
        aCoder.encode(libelle, forKey: "libelle")
        aCoder.encode(languageIcone, forKey: "languageIcone")
        
    }
    
    // *****************************************
    // *****************************************
    // ****** init
    // *****************************************
    // *****************************************
    required init(coder decoder: NSCoder) {
        
        self.languageId = decoder.decodeInteger(forKey: "languageId") as? Int ?? -1
        self.languageCode = decoder.decodeObject(forKey: "languageCode") as? String ?? ""
        self.libelle = decoder.decodeObject(forKey: "libelle") as? String ?? ""
        self.languageIcone = decoder.decodeObject(forKey: "languageIcone") as? String ?? ""
        
        
    }
    
}
