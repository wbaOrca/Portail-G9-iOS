//
//  ListeQuestionPilierViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 04/04/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

import Reachability
import NVActivityIndicatorView
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class ListeQuestionPilierViewController: UIViewController, NVActivityIndicatorViewable {

    
    @IBOutlet weak var tableViewQuestionsPilier: UITableView!
    @IBOutlet weak var labelPilier: UILabel?
    
    var mPilier : Pilier = Pilier();
    var isSynchronisedData = false;
    var arrayQuestionPiliers : [ItemQuestionPilier] = [ItemQuestionPilier]();
    
    // *****************************************
    // *****************************************
    // ****** viewDidLoad
    // *****************************************
    // *****************************************
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = NSLocalizedString("Piliers", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        //**
        let filtreButton = UIBarButtonItem(image: UIImage(named: "ic_filter_"), style: .plain, target: self, action: #selector(filtreTapped))
        navigationItem.rightBarButtonItems = [filtreButton]
        //**
        
        labelPilier?.text = mPilier.pilierLibelle
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // filtreView
        if(!isSynchronisedData || true)
        {
            self.getListeQuestionPiliers()
        }
    }
    // ***********************************
    // ***********************************
    // ***********************************
    @objc func filtreTapped()
    {
        let filtreVC = self.storyboard?.instantiateViewController(withIdentifier: "FiltreMenuViewController") as? FiltreMenuViewController
        filtreVC?.delegate = self
        self.present(filtreVC!, animated: true, completion: nil)
        
        
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func getListeQuestionPiliers()
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
            self.startAnimating(size, message: NSLocalizedString("DataUtils_Query", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.getQuestionsPilier(delegate: self, idPilier: self.mPilier.pilierId)
        }
    }


    // ***********************************
    // ***********************************
    // ***********************************
    func planActionQuestionPilier (idQuestion : Int64)
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
            WSQueries.targetQuestionsPilier(delegate: self, idQuestionPilier: idQuestion);
        }
    }
}



// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeQuestionPilierViewController : UITableViewDelegate , UITableViewDataSource {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arrayQuestionPiliers.count
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayQuestionPiliers[section].questions.count
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderListeQuestionPilierTableViewCell") as! ListeQuestionPilierTableViewCell
        if(section < arrayQuestionPiliers.count)
        {
            let qpilier = arrayQuestionPiliers[section] ;
            cell.setupHeaderQuestionPilierCell(question_pilier: qpilier)
        }
        
        return cell;
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return arrayQuestionPiliers[section].category
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionPilierTableViewCell", for: indexPath) as! QuestionPilierTableViewCell
        
        let row = indexPath.row
        let section = indexPath.section
        
        let qpilier = arrayQuestionPiliers[section].questions[row] ;
        cell.setupQuestionPilierCell(delegate: self, question_pilier: qpilier);
        
        
        return cell;
        
        
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // let qpilier = self.arrayQuestionPiliers[indexPath.row] ;
        
    }
    
    /*
   
    // *******************************
    // ****  editingStyleForRowAt 
    // *******************************
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Plan action
        let paAction = UITableViewRowAction(style: .normal, title: "PA") { (rowAction, indexPath) in
            
            // Affaire par défaut
            let preferences = UserDefaults.standard
            let affaireData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE);
            if(affaireData_ == nil){
                
                let alert = UIAlertController(title: "Erreur", message: "Veuillez sélectionner une affaire", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
                
            }
            
             let row = indexPath.row
             let section = indexPath.section
             let qpilier = self.arrayQuestionPiliers[section].questions[row] ;
            
            var isLastMonthOk : Bool! = nil
            var isLastTargeted : Bool! = nil
            if(qpilier.values.count > 0)
            {
                isLastMonthOk = qpilier.values.last?.value
                isLastTargeted = qpilier.values.last?.isTargeted
            }
            if(isLastMonthOk == true || isLastTargeted == true)
            {
                let alert = UIAlertController(title: "Erreur", message: "Pas nécessaire de mettre un plan d'action", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
            }else{
                
                self.planActionQuestionPilier(idQuestion : qpilier.idQuestion )
            }
        }
        paAction.backgroundColor = #colorLiteral(red: 0.9653237462, green: 0.700186789, blue: 0.1992127001, alpha: 1)
        
        //modifier
        let modifierAction = UITableViewRowAction(style: .normal, title: "Modifier") { (rowAction, indexPath) in
            
            // Affaire par défaut
            let preferences = UserDefaults.standard
            let affaireData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE);
            if(affaireData_ == nil){
                
                let alert = UIAlertController(title: "Erreur", message: "Veuillez sélectionner une affaire", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
            
            
            let row = indexPath.row
            let section = indexPath.section
            let qpilier = self.arrayQuestionPiliers[section].questions[row] ;
            let updateQuestionPilierVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateQuestionPilierViewController") as? UpdateQuestionPilierViewController
            updateQuestionPilierVC?.mQuestionPilier = qpilier
            self.navigationController?.pushViewController(updateQuestionPilierVC!, animated: true);
            
        }
        modifierAction.backgroundColor = #colorLiteral(red: 0.2521760464, green: 0.5373173952, blue: 0.7852240801, alpha: 1)
        
        return [paAction,modifierAction]
    }
    */
}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeQuestionPilierViewController: FiltreViewDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func showFiltreMenuViewController() {
        let filtreVC = self.storyboard?.instantiateViewController(withIdentifier: "FiltreMenuViewController") as? FiltreMenuViewController
        filtreVC?.delegate = self
        self.present(filtreVC!, animated: true, completion: nil)
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltreView() {
        
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeQuestionPilierViewController: FiltreMenuViewControllerDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltreMenuViewController(isLangueChanged : Bool) {
        
        
        if(!isLangueChanged)
        {
            self.dismiss(animated: true, completion: nil)
            self.getListeQuestionPiliers()
        }else
        {
            self.dismiss(animated: true, completion: nil)
            let vcHome = self.navigationController?.viewControllers[1];
            self.navigationController?.popToViewController(vcHome!, animated: true);
        }
    }
    
    
}


// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeQuestionPilierViewController: WSGetQuestionPiliersDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSQuestionPiliers(error: Bool, data: QuestionPiliersWSResponse!) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
            
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                arrayQuestionPiliers = data.questionPiliers;
                
                DispatchQueue.main.async {
                    self.tableViewQuestionsPilier.reloadData()
                }
            }
        }
        else if(error && data != nil)
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            DispatchQueue.main.async {
                
                let msg = data.description_ + "\nCode erreur = " + String(data.code_erreur)
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
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeQuestionPilierViewController: WSTargetQuestionDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSTargetQuestion(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && code_erreur == 0)
        {
            self.getListeQuestionPiliers()
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
    



}


// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeQuestionPilierViewController: EditQuestionPilierDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func addCommentaireQuestionPilier(qp: QuestionPilier) {
        
        // Affaire par défaut
        let preferences = UserDefaults.standard
        let affaireData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE);
        if(affaireData_ == nil){
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("slect_affaire", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "") , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
       
        let updateQuestionPilierVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateQuestionPilierViewController") as? UpdateQuestionPilierViewController
        updateQuestionPilierVC?.mQuestionPilier = qp
        
        
        self.navigationController?.pushViewController(updateQuestionPilierVC!, animated: true);
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func planActionQuestionPilier(qp: QuestionPilier) {
        
        // Affaire par défaut
        let preferences = UserDefaults.standard
        let affaireData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE);
        if(affaireData_ == nil){
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("slect_affaire", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
            
        }
        
        let qpilier = qp ;
        
        var isLastMonthOk : Bool! = nil
        var isLastTargeted : Bool! = nil
        if(qpilier.values.count > 0)
        {
            isLastMonthOk = qpilier.values.last?.value
            isLastTargeted = qpilier.values.last?.isTargeted
        }
        if(isLastMonthOk == true || isLastTargeted == true)
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: "Pas nécessaire de mettre un plan d'action", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            return
        }else{
            
            self.planActionQuestionPilier(idQuestion : qpilier.idQuestion )
        }
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func okNokQuestionPilier(qp: QuestionPilier, isOk: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Affaire par défaut
        let preferences = UserDefaults.standard
        let affaireData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE);
        if(affaireData_ == nil){
            
            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("slect_affaire", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "") , style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.tableViewQuestionsPilier.reloadData();
            
            return;
            
        }
        
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
            
            WSQueries.updateQuestionsPilier(delegate: self, questionPilier: qp, statut: isOk , commentaire:qp.commentaire)
        }
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeQuestionPilierViewController : WSUpdateQuestionDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSUpdateQuestion(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && code_erreur == 0)
        {
            self.getListeQuestionPiliers()
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
}
