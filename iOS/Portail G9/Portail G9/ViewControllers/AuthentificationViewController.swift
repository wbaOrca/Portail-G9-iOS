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


// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class AuthentificationViewController: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable, WSAuthentificationDelegate {

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
        
        self.textFieldLogin?.placeholder = "Identifient"
        self.textFieldPassword?.placeholder = "Mot de passe"
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
        
        if(loginAsString!.count == 0 || password!.count == 0 )
        {
            
            let alert = UIAlertController(title: "Erreur", message: "Veuillez saisir tous les champs", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        if(password!.count < 4)
        {
            
            let alert = UIAlertController(title: "Erreur", message: "Le mot de passe doit contenir au moins 4 caractères", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: "Pas de connexion internet.\nVeuillez vous connecter svp.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        // All Correct OK
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Authentification en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
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
                
            
                let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                navigationController?.pushViewController(homeVC, animated: true)
            
                return;
            }else
            {
                DispatchQueue.main.async {
                    let msgErreur = utilisateurResponse.description_ + "\n code = " + String(utilisateurResponse.code_erreur)
                    let alert = UIAlertController(title: "Erreur", message: msgErreur , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    return;
                }
            }
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: "Une erreur est survenue lors de l'authentification", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
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
