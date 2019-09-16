//
//  AddCheckListTacheViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 15/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView
import RSSelectionMenu

class AddCheckListTacheViewController: UIViewController, DateSelectionViewDelegate , NVActivityIndicatorViewable{

    var tache : Tache = Tache();
    var checkList : CheckList = CheckList();
    
    var isFromAddTache : Bool = false;
    
    let mArrayStatut : [String] = ["InProgress","Completed"]
    var mArraySelectedStatut : [String] = [String]()
    
    @IBOutlet weak var titreTextField: UITextField!
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var cibleTextField: UITextField!
    
    @IBOutlet weak var dateDebutTextField: UITextField!
    @IBOutlet weak var dateFinTextField: UITextField!
    @IBOutlet weak var dateDebutButton: UIButton!
    @IBOutlet weak var dateFinButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var statutButton: UIButton!
    @IBOutlet weak var compteRenduTextView: UITextView!
    
    var tag : Int = 0;
    
    // *******************************
    // **** viewDidLoad
    // *******************************
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.layer.cornerRadius = 5
        saveButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    // *******************************
    // **** viewDidAppear
    // *******************************
    override func viewDidAppear(_ animated: Bool) {
        self.setupDetailsCheckList()
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func setupDetailsCheckList()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
       
        dateDebutTextField.text = formatter.string(from: self.checkList.checkListStart)
        dateFinTextField.text = formatter.string(from: self.checkList.checkListEnd)
        statutButton.setTitle(self.checkList.checkListStatut, for: .normal)
        
    }
    // *******************************
    // ****
    // *******************************
    @IBAction func selectDateDebut(_ sender: Any) {
        
       
        DispatchQueue.main.async {
            self.tag = 1
            self.showDatePicker(tag: 1)
        }
    }
    // *******************************
    // ****
    // *******************************
    @IBAction func selectDateFin(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.tag = 2
            self.showDatePicker(tag: 2)
        }
    }
    // *******************************
    // ****
    // *******************************
    @IBAction func selectStatut(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let selectionMenu =  RSSelectionMenu(dataSource: mArrayStatut ) { (cell, object, indexPath) in
            cell.textLabel?.text = object
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        selectionMenu.setSelectedItems(items: mArraySelectedStatut) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.mArraySelectedStatut =  selectedItems
            if(self.mArraySelectedStatut.count > 0)
            {
                self.statutButton.setTitle(self.mArraySelectedStatut[0], for: .normal)
            }
        }
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        
        selectionMenu.show(style: .Actionsheet(title: "Select", action: NSLocalizedString("Vente", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-"), height: 400), from: self)
        
    }
    // *******************************
    // ****
    // *******************************
    func showDatePicker(tag : Int){
        //Formate Date
        
        let dateSelectionView = DateSelectionView.instanceFromNib();
        dateSelectionView.setupDateSelectionView(delegateS: self, type: DateSelectionView.PICKER_DATE_DAY);
        dateSelectionView.setPickerDate(date: Date());
        self.view.addSubview(dateSelectionView);
        dateSelectionView.center = CGPoint(x:self.view.bounds.size.width/2, y:self.view.bounds.size.height/2);
        dateSelectionView.showView();
        
    }
    
    
    // *******************************
    // **** sauvegarderCheckList
    // *******************************
    @IBAction func sauvegarderCheckList(_ sender: Any) {
        
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: "Pas de connexion internet.\nVeuillez vous connecter svp.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        let titreAsText = titreTextField.text
        let nomAsText = nomTextField.text
        let prenomAsText = prenomTextField.text
        let cibleAsText = cibleTextField.text
        
        if (titreAsText?.count == 0 || nomAsText?.count == 0 || prenomAsText?.count == 0 || cibleAsText?.count == 0) //champs obligatoires
        {
            let alert = UIAlertController(title: "Erreur", message: "Veuillez remplir les champs obligatoires", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        checkList.checkListLibelle = titreAsText!
        checkList.checkListNom = nomAsText!
        checkList.checkListPrenom = prenomAsText!
        checkList.checkListTarget = cibleAsText!
        
        checkList.checkListReport = compteRenduTextView.text
        checkList.checkListStatut = statutButton.title(for: .normal)!
        
        
        
        //1er cas ajout de task avec checklist to board
        if(isFromAddTache)
        {
            
            self.tache.checkLists.append(checkList);
            DispatchQueue.main.async {
                let size = CGSize(width: 150, height: 50)
                self.startAnimating(size, message: "Sauvegarde de la nouvelle tache en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
            }
            
            DispatchQueue.main.async{
                self.addTacheToBoardQuery(tache: self.tache);
            }
            return
        }
        
        //2er cas ajout de  checklist à une tache
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Envoi du checkList en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.addCheckListToTaskForcesTerrains(delegate: self, taskId: self.tache.taskId, checkList: self.checkList);
        }
    }
    
    // *****************************************
    // *****************************************
    // ****** didSelectDate
    // *****************************************
    // *****************************************
    func didSelectDate (date : Date,dateAsString : String )
    {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if(self.tag == 1)
        {
            dateDebutTextField.text = formatter.string(from: date)
            
            self.checkList.checkListStartAsString = formatter.string(from: date)
            self.checkList.checkListStart = date
            
            
        }else if(self.tag == 2)
        {
            dateFinTextField.text =  formatter.string(from: date)
           
            self.checkList.checkListEndAsString = formatter.string(from: date)
            self.checkList.checkListEnd = date
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


// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++
extension AddCheckListTacheViewController : WSAddCheckListToTaskForcesTerrainsDelegate
{
    func didFinishWSAddCheckListToTask(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Succès", message: "Votre checkList est ajouté avec succès.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (_) in
                    
                    self.tache.checkLists.append(self.checkList)
                    
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


// +++++++++++++++
// ++++++++++++++++
// ++++++++++++++++
extension AddCheckListTacheViewController: WSAddTaskToBoardForcesTerrainsDelegate {
    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func addTacheToBoardQuery(tache : Tache)
    {
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
            self.startAnimating(size, message: "Ajout de la tache en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.addTaskToBoardForcesTerrains(delegate: self, boardId: tache.boardId, task: tache);
        }
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSAddTaskToBoard(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            self.navigationController?.popViewController(animated: true);
        }else
        {
            let msg = "Une erreur est survenue lors de l'ajout de votre tache au tableau.\n" + description + "\ncode = " + String(code_erreur)
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: msg , preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
    
    
}
