//
//  Tache.swift
//  Portail G9
//
//  Created by WBA_ORCA on 05/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper
import MobileCoreServices

final class Tache: NSObject ,Mappable, NSItemProviderWriting, NSItemProviderReading, Codable {
    
    var taskId: Int64 = -1
    var taskTitle: String = ""
    var taskStatut: String = ""
    var taskZone: Int64! = nil
    var taskOrder: Int = -1
    
    var checkLists: [CheckList] = [CheckList]()
    var comments: [Comment] = [Comment]()
    var files: [File] = [File]()
    
    var boardId: Int64 = -1
    
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
        
        taskId <- map["taskId"]
        taskTitle <- map["taskTitle"]
        taskStatut <- map["taskStatut"]
        checkLists <- map["checkLists"]
        comments <- map["comments"]
        files <- map["files"]
        
        taskZone <- map["taskZone"]
        taskOrder <- map["taskOrder"]
    }
    
    
    // *************************
    // *************************
    // *************************
    static var writableTypeIdentifiersForItemProvider: [String] {
        //We know that we want to represent our object as a data type, so we'll specify that
        return [(kUTTypeData as String)]
    }
    // *************************
    // *************************
    // *************************
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            //Here the object is encoded to a JSON data object and sent to the completion handler
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
    // *************************
    // *************************
    // *************************
    static var readableTypeIdentifiersForItemProvider: [String] {
        //We know we want to accept our object as a data representation, so we'll specify that here
        return [(kUTTypeData) as String]
    }
    // *************************
    // *************************
    // *************************
    //This function actually has a return type of Self, but that really messes things up when you are trying to return your object, so if you mark your class as final as I've done above, the you can change the return type to return your class type.
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Tache {
        let decoder = JSONDecoder()
        do {
            //Here we decode the object back to it's class representation and return it
            let tache = try decoder.decode(Tache.self, from: data)
            return tache
        } catch {
            
            print("error!!!")
            return Tache()
            //return nil
            //fatalError(error)
        }
    }
    
    
    
    // *************************
    // *************************
    // *************************
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(taskId, forKey: "taskId")
        aCoder.encode(taskTitle, forKey: "taskTitle")
        aCoder.encode(taskStatut, forKey: "taskStatut")
        
        aCoder.encode(checkLists, forKey: "checkLists")
        aCoder.encode(comments, forKey: "comments")
        aCoder.encode(files, forKey: "files")
        aCoder.encode(taskZone, forKey: "taskZone")
        
        aCoder.encode(boardId, forKey: "boardId")
        aCoder.encode(taskOrder, forKey: "taskOrder")
        
    }
    
    // *************************
    // *************************
    // *************************
    required init(coder decoder: NSCoder) {
        
        taskId = decoder.decodeInt64(forKey: "taskId")
        taskTitle = decoder.decodeObject(forKey: "taskTitle") as? String ?? ""
        taskStatut = decoder.decodeObject(forKey: "taskStatut") as? String ?? ""
        taskZone = decoder.decodeInt64(forKey: "taskZone")
        taskOrder = decoder.decodeInteger(forKey: "taskOrder")
        checkLists = decoder.decodeObject(forKey: "checkLists") as? [CheckList] ??  [CheckList]()
        comments = decoder.decodeObject(forKey: "comments") as? [Comment] ?? [Comment]()
        files = decoder.decodeObject(forKey: "files") as? [File] ?? [File]()
        
        boardId = decoder.decodeInt64(forKey: "boardId")
        
    }
    
    // *************************
    // *************************
    // *************************
    private enum CodingKeys: String, CodingKey {
        case taskId
        case taskTitle
        case taskStatut
        case checkLists
        case comments
        case files
        case taskZone
        case taskOrder
        case boardId
    }
    
    
    // *************************
    // *************************
    // *************************
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        taskId = try values.decode(Int64.self, forKey: .taskId)
        taskTitle = try values.decode(String.self, forKey: .taskTitle)
        taskStatut = try values.decode(String.self, forKey: .taskStatut)
        checkLists = try values.decode([CheckList].self, forKey: .checkLists)
        comments = try values.decode([Comment].self, forKey: .comments)
        files = try values.decode([File].self, forKey: .files)
        taskZone = try values.decode(Int64.self, forKey: .taskZone)
        taskOrder = try values.decode(Int.self, forKey: .taskOrder)
        
        boardId = try values.decode(Int64.self, forKey: .boardId)
    }
    
    // *************************
    // *************************
    // *************************
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(taskTitle, forKey: .taskTitle)
        try container.encode(taskId, forKey: .taskId)
        try container.encode(taskStatut, forKey: .taskStatut)
        
        try container.encode(checkLists, forKey: .checkLists)
        try container.encode(comments, forKey: .comments)
        try container.encode(files, forKey: .files)
        
        try container.encode(taskZone, forKey: .taskZone)
        try container.encode(taskOrder, forKey: .taskOrder)
        try container.encode(boardId, forKey: .boardId)
    }
}



