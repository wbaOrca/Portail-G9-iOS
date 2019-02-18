//
//  ExampleData.swift
//  Examples
//
//  Created by Yong Su on 7/30/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import Foundation

//
// MARK: - Section Data Structure
//
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
public struct Item {
    public var name: String
    public var detail: String
    
    public init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
public struct Section {
    public var name: String
    public var items: [Item]
    
    public init(name: String, items: [Item]) {
        self.name = name
        self.items = items
    }
}
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
public var sectionsData: [Section] = [
    Section(name: NSLocalizedString("Indicateurs", comment: ""), items: [
        
        Item(name: NSLocalizedString("Vente", comment: ""), detail: "1"),
        Item(name: NSLocalizedString("Après ventes", comment: ""), detail: "2"),
        Item(name: NSLocalizedString("Clients", comment: ""), detail: "3"),
        Item(name: NSLocalizedString("Image de marque", comment: ""), detail: "4")
        
    ]),
    Section(name: NSLocalizedString("Process", comment: ""), items: [
        
        Item(name: NSLocalizedString("Radars", comment: ""), detail: ""),
        Item(name: NSLocalizedString("Piliers", comment: ""), detail: "")
    ]),
    Section(name: NSLocalizedString("Plan d'action", comment: ""), items: [
       
        Item(name: NSLocalizedString("Plan d'action zone", comment: ""), detail: ""),
        Item(name: NSLocalizedString("Synthèse plan d'actions", comment: ""), detail: "")
        
    ]),
    
    Section(name: NSLocalizedString("Actions commerciales", comment: ""), items: [
        
        ]),
    
    Section(name: NSLocalizedString("Forces Terrains", comment: ""), items: [
        
        Item(name: NSLocalizedString("Agenda", comment: ""), detail: ""),
        Item(name: NSLocalizedString("Todo list", comment: ""), detail: ""),
        Item(name: NSLocalizedString("Relevé de décisions", comment: ""), detail: "")
        ]),
    
    Section(name: NSLocalizedString("Escalation Process", comment: ""), items: [
        
        
        ]),
    Section(name: NSLocalizedString("Reporting", comment: ""), items: [
        Item(name: NSLocalizedString("Connexions Stats.", comment: ""), detail: "")
        
        ]),
    
    Section(name: NSLocalizedString("Déconnexion", comment: ""), items: [
        
        Item(name: NSLocalizedString("Se déconnecter", comment: ""), detail: "")
        
    
        ])
]

