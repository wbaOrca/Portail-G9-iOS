//
//  Comment.swift
//  Portail G9
//
//  Created by WBA_ORCA on 07/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class Comment: NSObject ,Mappable ,Codable{

    var commentId: Int64 = -1
    var message: String = ""
    var recipient: String = ""
    var files: [File] = [File]()
 
    
    // *************************
    // *************************
    // *************************
    private enum CodingKeys: String, CodingKey {
        case commentId
        case message
        case recipient
        case files
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        commentId = try values.decode(Int64.self, forKey: .commentId)
        message = try values.decode(String.self, forKey: .message)
        recipient = try values.decode(String.self, forKey: .recipient)
        files = try values.decode([File].self, forKey: .files)
        
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(commentId, forKey: .commentId)
        try container.encode(message, forKey: .message)
        try container.encode(recipient, forKey: .recipient)
        try container.encode(files, forKey: .files)
        
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
        
        commentId <- map["commentId"]
        message <- map["message"]
        recipient <- map["recipient"]
        files <- map["files"]
        
    }
}
