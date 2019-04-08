//
//  ItemQuestionPilier
//  Portail G9
//
//  Created by WBA_ORCA on 08/04/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class ItemQuestionPilier: NSObject , Mappable {

    
    var categoryId : Int64 = -1
    var category : String = ""
    var questions : [QuestionPilier] = [QuestionPilier]()
    
    
    
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
        
        categoryId <- map["categoryId"]
        category <- map["category"]
        questions <- map["questions"]
        
    }
}
