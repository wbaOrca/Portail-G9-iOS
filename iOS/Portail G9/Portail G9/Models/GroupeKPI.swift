//
//  GroupeKPI
//  Portail G9
//
//  Created by WBA_ORCA on 14/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class GroupeKPI: NSObject, Mappable {

    var groupId   : Int64 = -1
    var groupLibelle   : String = ""
    var groupIcon   : String = ""
    var status   : String = "#FFFFFF"
    var marque   : String = ""
    
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
        
        groupId <- map["groupId"]
        groupLibelle <- map["groupLibelle"]
        groupIcon <- map["groupIcon"]
        status <- map["status"]
        marque <- map["marque"]
        
        groupLibelle = groupLibelle.uppercased()
    }
}
