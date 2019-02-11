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

    var userId  : Int64 = 0
    var ipn   : String = ""
    var nom   : String = ""
    var prenom   : String = ""
    var email_user    : String = ""
    var active    : Bool = false
    var pays    : String = ""
    var apporteur    : String = ""
    var apporteur_id  : Int64 = 0
    var fonction : NSDictionary! = nil
    var profil : NSDictionary! = nil
   
    
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
        
        userId    <- map["userId"]
        ipn    <- map["ipn"]
        nom    <- map["nom"]
        prenom    <- map["prenom"]
        email_user    <- map["email_user"]
        active    <- map["active"]
        pays    <- map["pays"]
        apporteur    <- map["apporteur"]
        apporteur_id    <- map["apporteur_id"]
       
        
        fonction    <- map["fonction"]
        profil    <- map["profil"]
       
        
    }
    
    // *****************************************
    // *****************************************
    // ****** encode
    // *****************************************
    // *****************************************
    func encode(with aCoder: NSCoder)
    {
       aCoder.encode(userId, forKey: "userId")
        aCoder.encode(ipn, forKey: "ipn")
       aCoder.encode(nom, forKey: "nom")
       aCoder.encode(prenom, forKey: "prenom")
       aCoder.encode(email_user, forKey: "email_user")
       aCoder.encode(active, forKey: "active")
       aCoder.encode(pays, forKey: "pays")
       aCoder.encode(apporteur, forKey: "apporteur")
       aCoder.encode(apporteur_id, forKey: "apporteur_id")
        
        
        aCoder.encode(fonction, forKey: "fonction")
        aCoder.encode(profil, forKey: "profil")
       
    }
    
    // *****************************************
    // *****************************************
    // ****** init
    // *****************************************
    // *****************************************
    required init(coder decoder: NSCoder) {
        
        self.userId = decoder.decodeInt64(forKey: "userId")
        self.ipn = decoder.decodeObject(forKey: "ipn") as? String ?? ""
        self.nom = decoder.decodeObject(forKey: "nom") as? String ?? ""
        self.prenom = decoder.decodeObject(forKey: "prenom") as? String ?? ""
        self.email_user = decoder.decodeObject(forKey: "email_user") as? String ?? ""
        self.active = decoder.decodeBool(forKey: "active")
        self.pays = decoder.decodeObject(forKey: "pays") as? String ?? ""
        
        self.apporteur = decoder.decodeObject(forKey: "apporteur") as? String ?? ""
        self.apporteur_id = decoder.decodeInt64(forKey: "apporteur_id")
        
        self.fonction = decoder.decodeObject(forKey: "fonction") as? NSDictionary ?? nil
        self.profil = decoder.decodeObject(forKey: "profil") as? NSDictionary ?? nil
       
        
    }
}
