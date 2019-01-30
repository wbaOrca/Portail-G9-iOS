//
//  LeftMenuViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 30/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
class LeftMenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    let arrayOfMenu = ["Indicateurs", "Process", "Plan d'action","Actions commerciales","Forces Terrains","Escalation process","Reporting"]
    
    // *****************************
    // *****************************
    // *****************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
extension LeftMenuViewController: UITableViewDelegate
{
    
}

// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
extension LeftMenuViewController: UITableViewDataSource
{
    // *****************************
    // *****************************
    // *****************************
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // *****************************
    // *****************************
    // *****************************
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Menu"
    }
    // *****************************
    // *****************************
    // *****************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfMenu.count
    }
    // *****************************
    // *****************************
    // *****************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        let row = indexPath.row
        
        if(row < arrayOfMenu.count)
        {
            cell.labelTitle.text = arrayOfMenu[row]
        }
        
        return cell;
        
    }
    
    
}


