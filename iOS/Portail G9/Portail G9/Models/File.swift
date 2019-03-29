//
//  File.swift
//  Portail G9
//
//  Created by WBA_ORCA on 07/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class File: NSObject ,Mappable , Codable {

    var fileId: Int64 = -1
    var fileName: String = ""
    var createdAt: String = ""
    var path: String = ""
    
    // *************************
    // *************************
    // *************************
    private enum CodingKeys: String, CodingKey {
        
        case fileId
        case fileName
        case createdAt
        case path
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fileId = try values.decode(Int64.self, forKey: .fileId)
        fileName = try values.decode(String.self, forKey: .fileName)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        path = try values.decode(String.self, forKey: .path)
        
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(fileId, forKey: .fileId)
        try container.encode(fileName, forKey: .fileName)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(path, forKey: .path)
        
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
        
        fileId <- map["fileId"]
        fileName <- map["fileName"]
        createdAt <- map["createdAt"]
        path <- map["path"]
        
    }
}
