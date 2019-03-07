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
   
    // *************************
    // *************************
    // *************************
    private enum CodingKeys: String, CodingKey {
        case fileId
        case fileName
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fileId = try values.decode(Int64.self, forKey: .fileId)
        fileName = try values.decode(String.self, forKey: .fileName)
        
        
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(fileId, forKey: .fileId)
        try container.encode(fileName, forKey: .fileName)
        
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
        
        
    }
}
