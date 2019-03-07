//
//  Board.swift
//  Orca Trello
//
//  Created by WBA_ORCA on 26/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class Board: NSObject , Mappable  {
    
    var boardId: Int64 = 0
    var boardType: String = ""
    var boardTitle: String = ""
    var boardColor: String = ""
    var tasks: [Tache]! = nil
    
    //******
    //******
    //******
    override init() {
        super.init()
    }
    
    //******
    //******
    //******
    required init?(map: Map) {
        
    }
    
    
    
    // *****************************************
    // *****************************************
    // ****** mapping
    // *****************************************
    // *****************************************
    // Mappable
    func mapping(map: Map) {
        
        boardId <- map["boardId"]
        boardType <- map["boardType"]
        boardTitle <- map["boardTitle"]
        boardColor <- map["boardColor"]
        
        tasks <- map["tasks"]
        
        
    }
    
    //******
  //******
 //******
    init(title: String, items: [String]) {
        
        self.boardTitle = title
        
    }
}