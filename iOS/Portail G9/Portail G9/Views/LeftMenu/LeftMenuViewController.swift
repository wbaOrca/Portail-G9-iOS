//
//  LeftMenuViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 30/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//


import UIKit
import CollapsibleTableSectionViewController

class LeftMenuViewController: CollapsibleTableSectionViewController {
    
    var sections: [Section] = sectionsData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
}

extension LeftMenuViewController: CollapsibleTableSectionDelegate {
    
    func numberOfSections(_ tableView: UITableView) -> Int {
        return sections.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomCell ??
            CustomCell(style: .default, reuseIdentifier: "Cell")
        
        let item: Item = sections[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = item.name
        cell.detailLabel.text = item.detail
        
        return cell
    }
    
    func collapsibleTableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    func shouldCollapseByDefault(_ tableView: UITableView) -> Bool {
        return true
    }
    
    func shouldCollapseOthers(_ tableView: UITableView) -> Bool {
        return true
    }
    
}



