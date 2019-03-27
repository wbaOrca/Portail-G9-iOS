//
//  AddCommentaireTacheViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 15/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

import Reachability
import NVActivityIndicatorView

// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
class AddCommentaireTacheViewController: UIViewController ,NVActivityIndicatorViewable {

    var tache : Tache = Tache();
    
    var mCommentaire : Comment = Comment();
    var mFichier : File! = nil;
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var buttonFile: UIButton!
    @IBOutlet weak var destinataireTextField: UITextField!
    
    // **************************
    // **************************
    // **************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // **************************
    // **************************
    // **************************
    @IBAction func scanAction(_ sender: Any) {
        
        let addFileTacheVC = self.storyboard?.instantiateViewController(withIdentifier: "AddFileTacheViewController") as? AddFileTacheViewController
        addFileTacheVC?.tache = self.tache
        addFileTacheVC?.isFromCommentaire = true
        addFileTacheVC?.screenCommentaire = self;
        
        self.mFichier = nil;
        
        self.navigationController?.pushViewController(addFileTacheVC!, animated: true);
        
    }
    
    // **************************
    // **************************
    // **************************
    @IBAction func saveCommentaire(_ sender: Any) {
        
        
        
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: "Pas de connexion internet.\nVeuillez vous connecter svp.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        let messageAsText = messageTextView.text
        if (messageAsText?.count == 0 ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: "Veuillez saisir un commentaire", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
       
        
        
        mCommentaire.message = messageAsText!
        mCommentaire.recipient = destinataireTextField.text!
        if(mFichier != nil)
        {
            mCommentaire.files.removeAll()
            mCommentaire.files.append(mFichier)
        }
        
        // All Correct OK
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Envoi du commentaire en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.addCommentToTaskForcesTerrains(delegate: self, taskId: self.tache.taskId, commentaire: self.mCommentaire);
        }
        
        
        
    }
    
    
    
    
    

}

// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
extension AddCommentaireTacheViewController : WSAddCommentToTaskForcesTerrainsDelegate
{
    func didFinishWSAddCommentToTask(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Succès", message: "Votre document est attaché avec succès.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (_) in
                    
                    self.tache.comments.append(self.mCommentaire)
                    self.navigationController?.popViewController(animated: true)
                    
                    let preferences = UserDefaults.standard
                    let path_last_document = preferences.string(forKey: Utils.SHARED_PREFERENCE_LAST_DOCUMENT)
                    if(path_last_document != nil)
                    {
                        Utils.deleteFile(fileName: path_last_document!)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            return;
            
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: (description + "\ncode erreur : " + String(code_erreur)), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
}

