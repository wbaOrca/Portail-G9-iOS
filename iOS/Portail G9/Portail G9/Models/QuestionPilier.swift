//
//  QuestionPilier
//  Portail G9
//
//  Created by WBA_ORCA on 08/04/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class QuestionPilier: NSObject , Mappable {

    
    var idQuestion : Int64 = -1
    var libelle : String = ""
    var description_ : String! = ""
    var frequence : String = ""
    var commentaire : String = ""
    var derniereMAJ : String = ""
    var values : [MonthQuestionPilier] = [MonthQuestionPilier]()
    
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
        
        idQuestion <- map["id"]
        libelle <- map["libelle"]
        description_ <- map["description"]
        frequence <- map["frequence"]
        commentaire <- map["commentaire"]
        derniereMAJ <- map["derniereMAJ"]
        values <- map["values"]
        
        values =  values.sorted(by: { $0.order < $1.order })
    }
}
