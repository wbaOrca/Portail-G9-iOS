//
//  HomeViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 29/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import SideMenu

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class HomeViewController: UIViewController {

    @IBOutlet weak var labelWelcome: UILabel!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Home", comment: "-")
        labelWelcome.text = NSLocalizedString("Hello", comment: "-")
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "ic_menu_"), style: .plain, target: self, action: #selector(menuTapped))
        navigationItem.leftBarButtonItems = [menuButton]
        
        let filtreButton = UIBarButtonItem(image: UIImage(named: "ic_filter_"), style: .plain, target: self, action: #selector(filtreTapped))
        navigationItem.rightBarButtonItems = [filtreButton]
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @objc func filtreTapped()
    {
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @objc func menuTapped()
    {
        let leftMenuVC = self.storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! UISideMenuNavigationController
        self.present(leftMenuVC, animated: true, completion: nil)
    }
    // *******************************************************************************
    // ******
    // ****** viewWillAppear
    // ******
    // *******************************************************************************
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}