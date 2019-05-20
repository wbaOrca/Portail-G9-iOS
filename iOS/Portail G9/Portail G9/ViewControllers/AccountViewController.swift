//
//  AccountViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 20/05/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var labelUserInfo: UILabel!
    @IBOutlet weak var labelVersion: UILabel!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Home", comment: "-")
        
        // **
        let appInfo = Bundle.main.infoDictionary! as Dictionary<String,AnyObject>
        let shortVersionString = appInfo["CFBundleShortVersionString"] as! String
        let bundleVersion      = appInfo["CFBundleVersion"] as! String
        let applicationVersion = shortVersionString + "." + bundleVersion
        labelVersion.text =  Version.VERSION + " " + applicationVersion
        
        //**
        let preferences = UserDefaults.standard
        let userData = preferences.data(forKey: Utils.SHARED_PREFERENCE_USER);
        if let user_ = NSKeyedUnarchiver.unarchiveObject(with: userData!)  {
            
            let user = user_ as! Utilisateur
            let userAsString = user.user_prenom + " " + user.user_nom
            
            let attributedText = NSMutableAttributedString(string: NSLocalizedString("Hello", comment: "-"), attributes: [NSAttributedString.Key.font: UIFont.init(name: "ArialMT", size: 17)!])
            
            attributedText.append(NSAttributedString(string: ("\n" + userAsString + "\n"), attributes: [NSAttributedString.Key.font: UIFont.init(name: "Arial-BoldMT", size: 22)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1394602358, green: 0.3745498061, blue: 0.5070775747, alpha: 1)]))
            
            for i in (0 ..< user.user_roles.count)
            {
                attributedText.append(NSAttributedString(string: ("\n" + user.user_roles[i]), attributes: [NSAttributedString.Key.font: UIFont.init(name: "ArialMT", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.black]))
            }
            
            
            labelUserInfo.attributedText = attributedText
        }
    }
    

    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func disconnectUser() {
        
        Utils.disconnectUser(goBackAnimated: true);
    }
    
    

}
