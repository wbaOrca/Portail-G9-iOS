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
public struct Item {
    public var name: String
    public var detail: String
    
    public init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

public struct Section {
    public var name: String
    public var items: [Item]
    
    public init(name: String, items: [Item]) {
        self.name = name
        self.items = items
    }
}

public var sectionsData: [Section] = [
    Section(name: "Indicateurs", items: [
        
        Item(name: "Vente", detail: ""),
        Item(name: "Après ventes", detail: ""),
        Item(name: "Clients", detail: ""),
        Item(name: "Image de marque", detail: "")
        
    ]),
    Section(name: "Process", items: [
        
        Item(name: "Radars", detail: ""),
        Item(name: "Piliers", detail: "")
    ]),
    Section(name: "Plan d'action", items: [
       
        Item(name: "Plan d'action zone", detail: ""),
        Item(name: "Synthèse plan d'actions", detail: "")
        
    ]),
    
    Section(name: "Actions commerciales", items: [
        
        
        ]),
    
    Section(name: "Forces Terrains", items: [
        
        Item(name: "Agenda", detail: ""),
        Item(name: "Todo list", detail: ""),
        Item(name: "Relevé de décisions", detail: "")
        ]),
    
    Section(name: "Escalation Process", items: [
        
        
        ]),
    Section(name: "Reporting", items: [
        Item(name: "Connexions Stats.", detail: "")
        
        ])
]

