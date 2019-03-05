//
//  Controle.swift
//  Portail G9
//
//  Created by WBA_ORCA on 05/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

class Controle: NSObject {

    var id: Int64 = -1
    var titre: String = ""
    var nom: String = ""
    var prenom: String = ""
    var cible: String = ""
    var debut: Date! = nil
    var fin: Date! = nil
    var statut: Int = 1 //en cours = 1 terminé = 2
    var compteRendu: String = ""
    
}
