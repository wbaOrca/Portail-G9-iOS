//
//  DataRadar.swift
//  Portail G9
//
//  Created by WBA_ORCA on 12/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import ObjectMapper

class DataRadar: NSObject , Mappable {

    var orderRenaultDelimiter : Double = 0
    var orderRenaultData : Double = 0
    var orderRenaultLibelle   : String = ""
    
    var orderDaciaDelimiter : Double = 0
    var orderDaciaData : Double = 0
    var orderDaciaLibelle   : String = ""
    
    var workshopPEDelimiter : Double = 0
    var workshopPEData : Double = 0
    var workshopPELibelle   : String = ""
    
    var spSellInEDelimiter : Double = 0
    var spSellInData : Double = 0
    var spSellInLibelle   : String = ""
    
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
        
        orderRenaultDelimiter <- map["orderRenaultDelimiter"]
        orderRenaultData <- map["orderRenaultData"]
        orderRenaultLibelle <- map["orderRenaultLibelle"]
        
        orderDaciaDelimiter <- map["orderDaciaDelimiter"]
        orderDaciaData <- map["orderDaciaData"]
        orderDaciaLibelle <- map["orderDaciaLibelle"]
        
        workshopPEDelimiter <- map["workshopPEDelimiter"]
        workshopPEData <- map["workshopPEData"]
        workshopPELibelle <- map["workshopPELibelle"]
        
        spSellInEDelimiter <- map["spSellInEDelimiter"]
        spSellInData <- map["spSellInData"]
        spSellInLibelle <- map["spSellInLibelle"]
        
    }
}
