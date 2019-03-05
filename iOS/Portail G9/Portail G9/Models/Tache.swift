//
//  Tache.swift
//  Portail G9
//
//  Created by WBA_ORCA on 05/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

class Tache: NSObject {

    var id: Int64 = -1
    var titre: String = ""
    var commentaires: [String] = [String]()
    var controles: [Controle] = [Controle]()
    var fichiers: [String] = [String]()
    
}
