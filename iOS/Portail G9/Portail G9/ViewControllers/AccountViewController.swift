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
    @IBOutlet weak var buttonDisconnect: UIButton!
    @IBOutlet weak var buttonAccount: UIButton!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Home", comment: "-")
        
        buttonAccount.layer.cornerRadius = buttonAccount.frame.width / 2
        buttonAccount.clipsToBounds = true
        
        buttonDisconnect.layer.cornerRadius = 5
        buttonDisconnect.clipsToBounds = true
        
        // **
        let appInfo = Bundle.main.infoDictionary! as Dictionary<String,AnyObject>
        let shortVersionString = appInfo["CFBundleShortVersionString"] as! String
        let bundleVersion      = appInfo["CFBundleVersion"] as! String
        let applicationVersion = shortVersionString + "." + bundleVersion
        labelVersion.text =  Version.VERSION + " " + applicationVersion
        
         let preferences = UserDefaults.standard
        let profil = preferences.object(forKey: Utils.SHARED_PREFERENCE_USER_PROFIL) as? String ?? "";
        //**
       
        let userData = preferences.data(forKey: Utils.SHARED_PREFERENCE_USER);
        if let user_ = NSKeyedUnarchiver.unarchiveObject(with: userData!)  {
            
            let user = user_ as! Utilisateur
            let userAsString = user.user_prenom + " " + user.user_nom
            
            let attributedText = NSMutableAttributedString(string: NSLocalizedString("Hello", comment: "-"), attributes: [NSAttributedString.Key.font: UIFont.init(name: "ArialMT", size: 17)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9991517663, green: 0.8007791638, blue: 0.198880434, alpha: 1)])
            
            attributedText.append(NSAttributedString(string: ("\n" + userAsString + "\n"), attributes: [NSAttributedString.Key.font: UIFont.init(name: "Arial-BoldMT", size: 22)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]))
            
            for i in (0 ..< user.user_roles.count)
            {
                attributedText.append(NSAttributedString(string:"\n"));
                if( profil == user.user_roles[i])
                {
                    
                    attributedText.append(NSAttributedString(string: (user.user_roles[i]), attributes: [NSAttributedString.Key.font: UIFont.init(name: "ArialMT", size: 15)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), NSAttributedString.Key.backgroundColor: #colorLiteral(red: 0.9991517663, green: 0.8007791638, blue: 0.198880434, alpha: 1)]))
                }else
                {
                    attributedText.append(NSAttributedString(string: (user.user_roles[i]), attributes: [NSAttributedString.Key.font: UIFont.init(name: "ArialMT", size: 15)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)]))
                }
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
