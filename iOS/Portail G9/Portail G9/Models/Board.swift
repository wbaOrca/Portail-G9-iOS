//
//  Board.swift
//  Orca Trello
//
//  Created by WBA_ORCA on 26/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

class Board: Codable {
    
    var title: String
    var items: [String]
    
    init(title: String, items: [String]) {
        self.title = title
        self.items = items
    }
}
