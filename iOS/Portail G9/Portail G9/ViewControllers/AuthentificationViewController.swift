//
//  AuthentificationViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 29/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView
import RSSelectionMenu

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class AuthentificationViewController: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable, WSAuthentificationDelegate {

    @IBOutlet weak var textFieldLogin: UITextField?
    @IBOutlet weak var textFieldPassword: UITextField?
    @IBOutlet var labelVersion: UILabel!
    @IBOutlet weak var buttonConnexion: UIButton!
    @IBOutlet weak var labelWelcome: UILabel!
    
    var arraySelectedProfiles : [String] = [String]()
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        buttonConnexion.layer.cornerRadius = 5
        buttonConnexion.clipsToBounds = true
        
        setupScreenLanguage()
        
        // Do any additional setup after loading the view.
        let appInfo = Bundle.main.infoDictionary! as Dictionary<String,AnyObject>
        let shortVersionString = appInfo["CFBundleShortVersionString"] as! String
        let bundleVersion      = appInfo["CFBundleVersion"] as! String
        let applicationVersion = shortVersionString + "." + bundleVersion
        labelVersion.text =  "        " + Version.VERSION + " " + applicationVersion 
        
       
    }
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidAppear(_ animated: Bool) {
        setupScreenLanguage()
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func setupScreenLanguage()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = NSLocalizedString("Account", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        let attributedText = NSMutableAttributedString(string: NSLocalizedString("Welcome_in", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-"), attributes: [NSAttributedString.Key.font: UIFont.init(name: "ArialMT", size: 26)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9991517663, green: 0.8007791638, blue: 0.198880434, alpha: 1)])
        attributedText.append(NSAttributedString(string: (" Driver"), attributes: [NSAttributedString.Key.font: UIFont.init(name: "Arial-BoldMT", size: 30)!, NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        labelWelcome.attributedText = attributedText
        
        
        self.textFieldLogin?.placeholder = NSLocalizedString("Identifiant", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        self.textFieldPassword?.placeholder = NSLocalizedString("Mot de passe", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        
        buttonConnexion.setTitle(NSLocalizedString("Connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-"), for: .normal)
    }
    
    // ******************************
    // *** viewWillAppear
    // ******************************
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let preferences = UserDefaults.standard
        if(preferences.bool(forKey: Utils.SHARED_PREFERENCE_USER_CONNECTED))
        {
            let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "AccueilViewController") as! AccueilViewController
            navigationController?.pushViewController(homeVC, animated: false)
        }else
        {
            textFieldPassword?.text = "";
        }
        
    }
    
    // *****************************************
    // *****************************************
    // ****** textFieldShouldReturn
    // *****************************************
    // *****************************************
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        
        if(textField == textFieldLogin)
        {
            textFieldPassword?.becomeFirstResponder();
        }else if(textField == textFieldPassword)
        {
            self.loginAction(buttonConnexion)
        }
        
        
        return true;
    }
    

    // *******************************
    // **** loginAction
    // *******************************
    @IBAction func loginAction (_ sender: UIButton!) {
        
        
        textFieldLogin?.resignFirstResponder()
        textFieldPassword?.resignFirstResponder()
        
        let loginAsString = textFieldLogin?.text;
        let password = textFieldPassword?.text;
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(loginAsString!.count == 0 || password!.count == 0 )
        {
            
            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("Veuillez_saisir_tous_les_champs", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        if(password!.count < 4)
        {
            
            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("mot_passe_4_caractères", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "") , message: NSLocalizedString("no_internet_connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        // All Correct OK
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: NSLocalizedString("Authentification_Query", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            
            WSQueries.authenticateUser(login: loginAsString!, password: password!, delegate: self);
            
        }
        
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSAuthentification(error: Bool, utilisateurResponse : UtilisateurResponseWSAuth!)
    {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(!error && utilisateurResponse != nil)
        {
            if(utilisateurResponse.code == WSQueries.CODE_RETOUR_200 && utilisateurResponse.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                
                let preferences = UserDefaults.standard
                let dataUser = NSKeyedArchiver.archivedData(withRootObject: utilisateurResponse.dataUserResponseWSAuth.utilisateur)
                preferences.set(dataUser, forKey: Utils.SHARED_PREFERENCE_USER)
                preferences.set(true, forKey: Utils.SHARED_PREFERENCE_USER_CONNECTED)
                
                let loginAsString = self.textFieldLogin?.text;
                let password = self.textFieldPassword?.text;
                preferences.set(loginAsString, forKey: Utils.SHARED_PREFERENCE_USER_LOGIN)
                preferences.set(password, forKey: Utils.SHARED_PREFERENCE_USER_PASSWORD)
                preferences.set(utilisateurResponse.dataUserResponseWSAuth.token , forKey: Utils.SHARED_PREFERENCE_USER_TOKEN)
                
                
                //  Save to disk
                preferences.synchronize()
                
                selectUserProfileRole(arrayRole: utilisateurResponse.dataUserResponseWSAuth.utilisateur.user_roles)
            
                return;
            }else
            {
                DispatchQueue.main.async {
                    let msgErreur = utilisateurResponse.description_ + "\n code = " + String(utilisateurResponse.code_erreur)
                    let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: msgErreur , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    return;
                }
            }
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("erreur_survenue_request", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectUserProfileRole(arrayRole : [String]!)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(arrayRole.count == 0)
        {
            let alertController = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("Aucun Profil.", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: .alert)
            let action1 = UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let selectionMenu =  RSSelectionMenu(dataSource: arrayRole ) { (cell, object, indexPath) in
            cell.textLabel?.text = object
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arraySelectedProfiles) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arraySelectedProfiles = selectedItems
            
            if(self.arraySelectedProfiles.count > 0)
            {
                
                let preferences = UserDefaults.standard
                preferences.set(self.arraySelectedProfiles[0], forKey: Utils.SHARED_PREFERENCE_USER_PROFIL)
                preferences.synchronize()
                
                DispatchQueue.main.async {
                    let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "AccueilViewController") as! AccueilViewController
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
            
        }
        
        
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: NSLocalizedString("Profils", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-"), action: NSLocalizedString("Select", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-"), height: Utils.heightSelectionMenu()), from: self)
        
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
