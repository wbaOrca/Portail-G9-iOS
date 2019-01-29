//
//  AuthentificationViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 29/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class AuthentificationViewController: UIViewController {

    @IBOutlet weak var textFieldLogin: UITextField?
    @IBOutlet weak var textFieldPassword: UITextField?
    @IBOutlet var labelVersion: UILabel!
    @IBOutlet weak var buttonConnexion: UIButton!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appInfo = Bundle.main.infoDictionary! as Dictionary<String,AnyObject>
        let shortVersionString = appInfo["CFBundleShortVersionString"] as! String
        let bundleVersion      = appInfo["CFBundleVersion"] as! String
        let applicationVersion = shortVersionString + "." + bundleVersion
        labelVersion.text =  Version.VERSION + " " + applicationVersion
        
        self.textFieldLogin?.placeholder = "Login"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    // ******************************
    // *** viewWillAppear
    // ******************************
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let preferences = UserDefaults.standard
        if(preferences.bool(forKey: Utils.SHARED_PREFERENCE_USER_CONNECTED))
        {
            let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(homeVC, animated: true)
        }else
        {
            textFieldPassword?.text = "";
        }
        
    }
    

    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func connectAction()
    {
        let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController?.pushViewController(homeVC, animated: true)
    
        
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
