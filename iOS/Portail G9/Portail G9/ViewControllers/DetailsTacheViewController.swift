//
//  DetailsTacheViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 05/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class DetailsTacheViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    

    var tache : Tache = Tache();
    
    @IBOutlet weak var labelTache: UILabel!
    @IBOutlet weak var controlesTableView: UITableView!
    @IBOutlet weak var fichiersTableView: UITableView!
    @IBOutlet weak var commentairesTableView: UITableView!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDetailsTache()
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupDetailsTache()
    {
        labelTache.text = tache.taskTitle
        
        controlesTableView.reloadData()
        fichiersTableView.reloadData()
        commentairesTableView.reloadData()
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(tableView == controlesTableView)
        {
            return "Liste des controles"
        }
        else if(tableView == fichiersTableView)
        {
            return "Fichiers"
        }
        else if(tableView == commentairesTableView)
        {
            return "Commentaires"
        }
        return ""
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == controlesTableView)
        {
            return tache.checkLists.count
        }
        else if(tableView == fichiersTableView)
        {
            return tache.files.count
        }
        else if(tableView == commentairesTableView)
        {
            return tache.comments.count
        }
        
        return 0
    }
    
    // ********************************
    // *** heightForHeaderInSection
    // ********************************
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat
    {
        return 30;
    }
    // ********************************
    // *** viewForHeaderInSection
    // ********************************
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView?
    {
        
        if(tableView == controlesTableView)
        {
            // This is where you would change section header content
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCheckList") as? HeaderDetailsTableViewCell;
            cell?.labelHeader.text = self.tableView(tableView, titleForHeaderInSection: section)
            return cell;
        }
        else if(tableView == fichiersTableView)
        {
            // This is where you would change section header content
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderFile") as? HeaderDetailsTableViewCell;
            cell?.labelHeader.text = self.tableView(tableView, titleForHeaderInSection: section)
            return cell;
        }
        else if(tableView == commentairesTableView)
        {
            // This is where you would change section header content
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCommentaire") as? HeaderDetailsTableViewCell;
            cell?.labelHeader.text = self.tableView(tableView, titleForHeaderInSection: section)
            return cell;
        }
        
        
        return nil;
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == controlesTableView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ControleTableViewCell", for: indexPath) as! ControleTableViewCell
            cell.setupCell(checkList: tache.checkLists[indexPath.row])
            return cell
        }
        else if(tableView == fichiersTableView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FichierTableViewCell", for: indexPath) as! FichierTableViewCell
            cell.setupCell(file:  tache.files[indexPath.row])
            return cell
        }
        else if(tableView == commentairesTableView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentaireTableViewCell", for: indexPath) as! CommentaireTableViewCell
            cell.setupCell(comment: tache.comments[indexPath.row])
            return cell
        }
        
        return UITableViewCell();
        
    }
    

    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if(tableView == controlesTableView)
        {
            
        }
        else if(tableView == fichiersTableView)
        {
            let fichier = tache.files[indexPath.row];
            
            let documentVC = self.storyboard?.instantiateViewController(withIdentifier: "DocumentViewController") as? DocumentViewController
            documentVC?.url_document_string = fichier.fileName;
            self.navigationController?.pushViewController(documentVC!, animated: true);
            
        }
        else if(tableView == commentairesTableView)
        {
            let commentaire = tache.comments[indexPath.row];
            
            DispatchQueue.main.async {
            
                let alert = UIAlertController(title: commentaire.recipient, message: commentaire.message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            }
            return;
        }
    }
   
    
    
    // *******************************
    // **** addCommentaireAction
    // *******************************
    @IBAction func addCommentaireAction (_ sender: UIButton!) {
    
        let addCommentaireTacheVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCommentaireTacheViewController") as? AddCommentaireTacheViewController
        addCommentaireTacheVC?.tache = self.tache
        self.navigationController?.pushViewController(addCommentaireTacheVC!, animated: true);
    }
    
    // *******************************
    // **** addFileAction
    // *******************************
    @IBAction func addFileAction (_ sender: UIButton!) {
        
    }

    // *******************************
    // **** addCheckListAction
    // *******************************
    @IBAction func addCheckListAction (_ sender: UIButton!) {
        
        let addCheckListTacheVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCheckListTacheViewController") as? AddCheckListTacheViewController
        addCheckListTacheVC?.tache = self.tache
        self.navigationController?.pushViewController(addCheckListTacheVC!, animated: true);
    }
}

