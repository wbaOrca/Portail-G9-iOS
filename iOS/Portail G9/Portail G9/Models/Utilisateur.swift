//
//  Utilisateur.swift
//  Octroi Etude
//
//  Created by WBA_ORCA on 04/06/2018.
//  Copyright © 2018 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class Utilisateur: NSObject , Mappable , NSCoding{

    var user_id  : Int64 = 0
    var user_ipn   : String = ""
    var user_nom   : String = ""
    var user_prenom   : String = ""
    var user_mail    : String = ""
    var code_country    : String = ""
    var preferred_lang    : String = ""
    var user_roles : [String] = [String]()
    var active    : Bool = false
    
   
    
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
        
        user_id <- map["user_id"]
        user_ipn <- map["user_ipn"]
        user_nom    <- map["user_nom"]
        user_prenom    <- map["user_prenom"]
        user_mail    <- map["user_mail"]
        active    <- map["active"]
        code_country    <- map["code_country"]
        preferred_lang    <- map["preferred_lang"]
        user_roles    <- map["user_roles"]
       
        
    }
    
    // *****************************************
    // *****************************************
    // ****** encode
    // *****************************************
    // *****************************************
    func encode(with aCoder: NSCoder)
    {
       aCoder.encode(user_id, forKey: "user_id")
        aCoder.encode(user_ipn, forKey: "user_ipn")
       aCoder.encode(user_nom, forKey: "user_nom")
       aCoder.encode(user_prenom, forKey: "user_prenom")
       aCoder.encode(user_mail, forKey: "user_mail")
       aCoder.encode(active, forKey: "active")
       aCoder.encode(code_country, forKey: "code_country")
       aCoder.encode(preferred_lang, forKey: "preferred_lang")
       aCoder.encode(user_roles, forKey: "user_roles")
        
        
    }
    
    // *****************************************
    // *****************************************
    // ****** init
    // *****************************************
    // *****************************************
    required init(coder decoder: NSCoder) {
        
        self.user_id = decoder.decodeInt64(forKey: "user_id")
        self.user_ipn = decoder.decodeObject(forKey: "user_ipn") as? String ?? ""
        self.user_nom = decoder.decodeObject(forKey: "user_nom") as? String ?? ""
        self.user_prenom = decoder.decodeObject(forKey: "user_prenom") as? String ?? ""
        self.user_mail = decoder.decodeObject(forKey: "user_mail") as? String ?? ""
        self.active = decoder.decodeBool(forKey: "active")
        self.code_country = decoder.decodeObject(forKey: "code_country") as? String ?? ""
        self.preferred_lang = decoder.decodeObject(forKey: "preferred_lang") as? String ?? ""
        self.user_roles = decoder.decodeObject(forKey: "user_roles") as? [String] ?? [String]()
       
        
    }
}
