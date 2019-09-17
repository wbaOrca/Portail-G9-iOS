//
//  UpdateQuestionPilierViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 18/04/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class UpdateQuestionPilierViewController: UIViewController , NVActivityIndicatorViewable{

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var labelQuestion: UILabel?
    @IBOutlet weak var labelMAJ: UILabel?
    
    @IBOutlet weak var textViewCommentaire: UITextView?
    @IBOutlet weak var segmentValue: UISegmentedControl?
    
    var mQuestionPilier : QuestionPilier = QuestionPilier()
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textViewCommentaire!.layer.borderWidth = 1.5
        textViewCommentaire!.layer.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        saveButton.layer.cornerRadius = 5
        saveButton.clipsToBounds = true
        
        self.setupQuestionPilierData();
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
     func setupQuestionPilierData() {
       
        labelQuestion?.text = mQuestionPilier.libelle
        labelMAJ?.text = mQuestionPilier.derniereMAJ
        
        
        textViewCommentaire?.text = mQuestionPilier.commentaire
        segmentValue?.selectedSegmentIndex = 1
        if(mQuestionPilier.values.count > 0)
        {
            let monthQP = mQuestionPilier.values.last
            if(monthQP?.value == true)
            {
                segmentValue?.selectedSegmentIndex = 0
            }
        }
    }
    
    
    // *******************************
    // **** updateQuestionAction
    // *******************************
    @IBAction func updateQuestionAction (_ sender: UIButton!) {
        
        if(textViewCommentaire?.text.count == 0)
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("empty_commentaire", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        self.updateQuestionPilierQuery()
        
    }
    
    

}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension UpdateQuestionPilierViewController : WSUpdateQuestionDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSUpdateQuestion(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && code_erreur == 0)
        {
            self.navigationController?.popViewController(animated: true)
            return;
        }
        else if(error)
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            DispatchQueue.main.async {
                
                let msg = description + "\nCode erreur = " + String(code_erreur)
                let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: msg, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
            
        }
        else
        {
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
    func updateQuestionPilierQuery()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("no_internet_connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        // All Correct OK
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: NSLocalizedString("DataSend_Query", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            var isOk = false
            if(self.segmentValue?.selectedSegmentIndex == 0)
            {
                isOk = true
            }
            WSQueries.updateQuestionsPilier(delegate: self, questionPilier: self.mQuestionPilier, statut: isOk , commentaire: (self.textViewCommentaire?.text)!)
        }
    }
    
}
