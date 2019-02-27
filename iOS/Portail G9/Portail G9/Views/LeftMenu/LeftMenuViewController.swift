//
//  LeftMenuViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 30/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//


import UIKit
import CollapsibleTableSectionViewController

// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
class LeftMenuViewController: CollapsibleTableSectionViewController {
    
    var sections: [Section] = sectionsData
    
    // *****************************
    // *****************************
    // *****************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
}
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
extension LeftMenuViewController: CollapsibleTableSectionDelegate {
    
    // *****************************
    // *****************************
    // *****************************
    func numberOfSections(_ tableView: UITableView) -> Int {
        return sections.count
    }
    // *****************************
    // *****************************
    // *****************************
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    // *****************************
    // *****************************
    // *****************************
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomCell ??
            CustomCell(style: .default, reuseIdentifier: "Cell")
        
        let item: Item = sections[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = item.name
        cell.detailLabel.text = item.detail
        
        return cell
    }
    // *****************************
    // *****************************
    // *****************************
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:// KPI indicateurs Lot 1
           
            let famille_id = Int(indexPath.row + 1)
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "#voirCategorieFamille"), object: famille_id)
           
            break;
            
        case 1://Process
            
            let process_id = Int(indexPath.row + 1)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "#voirProcess"), object: process_id)
            break;
            
        case 2://Plan d'action
            
            let plan_action_id = Int(indexPath.row + 1)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "#voirPlanAction"), object: plan_action_id)
            break;
            
        case 3://Action commerciale
            break;
        
        case 4://Force Terrains
            break;
        
        case 5://Escalation process
            break;
        
        case 6://Reporting
            let reporting_id = Int(indexPath.row + 1)
            if(indexPath.row == 0)
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "#Reporting"), object: reporting_id)
            }
            break;
        
        case 7: // deconnexion
        
            if(indexPath.row == 0)
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "#DisconnectUser"), object: nil)
                
            }
            break;
            
        default:
            break;
        }
    }
    
    // *****************************
    // *****************************
    // *****************************
    func collapsibleTableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    // *****************************
    // *****************************
    // *****************************
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    // *****************************
    // *****************************
    // *****************************
    func shouldCollapseByDefault(_ tableView: UITableView) -> Bool {
        return true
    }
    // *****************************
    // *****************************
    // *****************************
    func shouldCollapseOthers(_ tableView: UITableView) -> Bool {
        return true
    }
    
    
    
    
    
}



