//
//  CheckList.swift
//  Portail G9
//
//  Created by WBA_ORCA on 07/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class CheckList: NSObject,Mappable , Codable {

    var checkListId: Int64 = -1
    var checkListLibelle: String = ""
    var checkListNom: String = ""
    var checkListPrenom: String = ""
    var checkListTarget: String = ""
    var checkListStart: Date! = nil
    var checkListEnd: Date! = nil
    var checkListStatut: String = ""
    var checkListReport: String = ""
    
    // *************************
    // *************************
    // *************************
    private enum CodingKeys: String, CodingKey {
        case checkListId
        case checkListLibelle
        case checkListNom
        case checkListPrenom
        case checkListTarget
        case checkListStart
        case checkListEnd
        case checkListStatut
        case checkListReport
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        checkListId = try values.decode(Int64.self, forKey: .checkListId)
        checkListLibelle = try values.decode(String.self, forKey: .checkListLibelle)
        checkListNom = try values.decode(String.self, forKey: .checkListNom)
        checkListPrenom = try values.decode(String.self, forKey: .checkListPrenom)
        checkListTarget = try values.decode(String.self, forKey: .checkListTarget)
        checkListStart = try values.decode(Date.self, forKey: .checkListStart)
        checkListEnd = try values.decode(Date.self, forKey: .checkListEnd)
        checkListStatut = try values.decode(String.self, forKey: .checkListStatut)
        checkListReport = try values.decode(String.self, forKey: .checkListReport)
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(checkListId, forKey: .checkListId)
        try container.encode(checkListLibelle, forKey: .checkListLibelle)
        try container.encode(checkListNom, forKey: .checkListNom)
        try container.encode(checkListPrenom, forKey: .checkListPrenom)
        try container.encode(checkListTarget, forKey: .checkListTarget)
        try container.encode(checkListStart, forKey: .checkListStart)
        try container.encode(checkListEnd, forKey: .checkListEnd)
        try container.encode(checkListStatut, forKey: .checkListStatut)
        try container.encode(checkListReport, forKey: .checkListReport)
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
        
        checkListId <- map["checkListId"]
        checkListLibelle <- map["checkListLibelle"]
        checkListNom <- map["checkListNom"]
        checkListPrenom <- map["checkListPrenom"]
        checkListTarget <- map["checkListTarget"]
        checkListStart <- map["checkListStart"]
        checkListEnd <- map["checkListEnd"]
        checkListStatut <- map["checkListStatut"]
        checkListReport <- map["checkListReport"]
        
    }
}
