//
//  DetailsTacheViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 05/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class DetailsTacheViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable {
    

    var tache : Tache = Tache();
    
    var indexItemToDelete : Int = 999;
    
    @IBOutlet weak var labelTache: UILabel!
    @IBOutlet weak var buttonSupprimer: UIButton!
    
    @IBOutlet weak var controlesTableView: UITableView!
    @IBOutlet weak var fichiersTableView: UITableView!
    @IBOutlet weak var commentairesTableView: UITableView!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonSupprimer.layer.cornerRadius = 5
        buttonSupprimer.clipsToBounds = true
    }
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidAppear(_ animated: Bool) {
        
        setupDetailsTache()
        
        self.refreshTaskQuery()
    }
    
    
    // *******************************
    // ****
    // *******************************
    @IBAction func deleteThisTask(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Suppression de tache", message: "Voulez-vous vraiment supprimer cette tache ?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Oui", style: .default, handler: { (_) in
            self.deleteTache()
        }))
        
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        present(alertController, animated: true)
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
            
            var url_asString = fichier.path
            url_asString = url_asString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            documentVC?.url_document_string = url_asString;
            self.navigationController?.pushViewController(documentVC!, animated: true);
            
        }
        else if(tableView == commentairesTableView)
        {
            let commentaire = tache.comments[indexPath.row];
            
            DispatchQueue.main.async {
                /*
                 let alert = UIAlertController(title: commentaire.recipient, message: commentaire.message, preferredStyle: UIAlertController.Style.alert)
                 alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                 
                 
                 let imgView = UIImageView(frame: CGRect(x: 10, y: 10, width: 120, height: 80))
                 let url = URL(string: commentaire.files[0].path)
                 imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
                 alert.view.addSubview(imgView)
                 }
                 
                 self.present(alert, animated: true, completion: nil)*/
                //***
                let uiAlertControl = UIAlertController(title: commentaire.recipient, message: commentaire.message, preferredStyle: .alert)
                
                if(commentaire.files.count > 0)
                {
                    
                    
                    var url_asString = commentaire.files[0].path
                    url_asString = url_asString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    let url = URL(string:url_asString)
                    //let data = try? Data(contentsOf: url!)
                    //let image: UIImage = UIImage(data: data!)!
                    
                    let session = URLSession(configuration: .default)
                    //creating a dataTask
                    let getImageFromUrl = session.dataTask(with: url!) { (data, response, error) in
                        
                        //if there is any error
                        if let e = error {
                            //displaying the message
                            print("Error Occurred: \(e)")
                            
                        } else {
                            //in case of now error, checking wheather the response is nil or not
                            if (response as? HTTPURLResponse) != nil {
                                
                                //checking if the response contains an image
                                if let imageData = data {
                                    
                                    //getting the image
                                    let image = UIImage(data: imageData)
                                    if(image != nil){
                                    //displaying the image
                                        let scaleSze = CGSize(width: 245, height: 245/image!.size.width*image!.size.height)
                                        let reSizedImage = image!.resizeImage(targetSize: scaleSze)
                                    
                                        let uiImageAlertAction = UIAlertAction(title: "", style: .default, handler: nil)
                                        uiImageAlertAction.setValue(reSizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
                                        uiAlertControl.addAction(uiImageAlertAction)
                                    }
                                    uiAlertControl.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                                    self.present(uiAlertControl, animated: true, completion: nil)
                                    
                                } else {
                                    print("Image file is currupted")
                                }
                            } else {
                                print("No response from server")
                            }
                        }
                    }
                    
                    //starting the download task
                    getImageFromUrl.resume()
                    
                    
                    
                }else
                {
                    uiAlertControl.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(uiAlertControl, animated: true, completion: nil)
                }
               
                //***
                
            }
            return;
        }
    }
   
    // *******************************
    // **** commit editingStyleForRowAt delete
    // *******************************
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            if(tableView == controlesTableView)
            {
                self.indexItemToDelete = indexPath.row
                self.deleteCheckListQuery()
                
            }
            else if(tableView == fichiersTableView)
            {
                self.indexItemToDelete = indexPath.row
                self.deleteFileQuery()
               
            }
            else if(tableView == commentairesTableView)
            {
                self.indexItemToDelete = indexPath.row
                self.deleteCommentaireQuery()
                
            }
            
        }
    }
    // *******************************
    // ****  editingStyleForRowAt delete
    // *******************************
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
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
        
        let addFileTacheVC = self.storyboard?.instantiateViewController(withIdentifier: "AddFileTacheViewController") as? AddFileTacheViewController
        addFileTacheVC?.tache = self.tache
        self.navigationController?.pushViewController(addFileTacheVC!, animated: true);
    }

    // *******************************
    // **** addCheckListAction
    // *******************************
    @IBAction func addCheckListAction (_ sender: UIButton!) {
        
        let addCheckListTacheVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCheckListTacheViewController") as? AddCheckListTacheViewController
        addCheckListTacheVC?.tache = self.tache
        addCheckListTacheVC?.isFromAddTache = false
        self.navigationController?.pushViewController(addCheckListTacheVC!, animated: true);
    }
}



// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension DetailsTacheViewController: WSDeleteCommentaireForcesTerrainsDelegate {
   
    // *******************************
    // ****
    // *******************************
    func deleteCommentaireQuery() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: NSLocalizedString("no_internet_connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.indexItemToDelete = 999;
            
            return;
        }
        
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Suppression du commentaire en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            if(self.tache.comments.count > self.indexItemToDelete){
                let comment_ = self.tache.comments[self.indexItemToDelete]
                WSQueries.deleteCommentaireForcesTerrains(delegate: self, commentaire: comment_);
            }
        }
        return
    }
    
    // *******************************
    // ****
    // *******************************
    func didFinishWSDeleteCommentaire(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            DispatchQueue.main.async {
                self.tache.comments.remove(at: self.indexItemToDelete);
                self.commentairesTableView.deleteRows(at: [IndexPath.init(row: self.indexItemToDelete, section: 0)], with: .fade)
                
                self.indexItemToDelete = 999
            }
            return;
            
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: (description + "\ncode erreur : " + String(code_erreur)), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.commentairesTableView.reloadData()
                return;
            }
        }
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension DetailsTacheViewController: WSDeleteFileForcesTerrainsDelegate {
    
    // *******************************
    // ****
    // *******************************
    func deleteFileQuery() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: NSLocalizedString("no_internet_connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.indexItemToDelete = 999;
            
            return;
        }
        
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Suppression du fichier en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            if(self.tache.files.count > self.indexItemToDelete){
                let file_ = self.tache.files[self.indexItemToDelete]
                WSQueries.deleteFileForcesTerrains(delegate: self, file: file_);
            }
        }
        return
    }
    // *******************************
    // ****
    // *******************************
    func didFinishWSDeleteFile(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            DispatchQueue.main.async {
                self.tache.files.remove(at: self.indexItemToDelete);
                self.fichiersTableView.deleteRows(at: [IndexPath.init(row: self.indexItemToDelete, section: 0)], with: .fade)
                
                self.indexItemToDelete = 999
            }
            return;
            
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: (description + "\ncode erreur : " + String(code_erreur)), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.fichiersTableView.reloadData()
                return;
            }
        }
    }
    
    
}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension DetailsTacheViewController: WSDeleteCheckListForcesTerrainsDelegate {
    
    // *******************************
    // ****
    // *******************************
    func deleteCheckListQuery() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: NSLocalizedString("no_internet_connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.indexItemToDelete = 999;
            
            return;
        }
        
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Suppression du checkList en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            if(self.tache.checkLists.count > self.indexItemToDelete){
                let cl_ = self.tache.checkLists[self.indexItemToDelete]
                WSQueries.deleteCheckListForcesTerrains(delegate: self, checkList: cl_);
            }
        }
        return
    }
    
    // *******************************
    // ****
    // *******************************
    func didFinishWSDeleteCheckList(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            DispatchQueue.main.async {
                self.tache.checkLists.remove(at: self.indexItemToDelete);
                self.controlesTableView.deleteRows(at: [IndexPath.init(row: self.indexItemToDelete, section: 0)], with: .fade)
                
                self.indexItemToDelete = 999
            }
            return;
            
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: (description + "\ncode erreur : " + String(code_erreur)), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.controlesTableView.reloadData()
                return;
            }
        }
    }
    
    
}


// +++++++++++++++++++++++++
// +++++++++++++++++++++++++
// +++++++++++++++++++++++++
extension DetailsTacheViewController: WSDeleteTaskForcesTerrainsDelegate {
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func deleteTache(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: NSLocalizedString("no_internet_connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            
            return;
        }
        
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Suppression de la tache en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            
            WSQueries.deleteTaskForcesTerrains(delegate: self, task: self.tache);
            
        }
        return
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSDeleteTask(error: Bool, code_erreur: Int, description: String) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            DispatchQueue.main.async {
                
                self.navigationController?.popViewController(animated: true)
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

// +++++++++++++++++++++++++
// +++++++++++++++++++++++++
// +++++++++++++++++++++++++
extension DetailsTacheViewController: WSGetTaskForcesTerrainsDelegate {

    
    // *******************************
    // ****
    // *******************************
    func refreshTaskQuery()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: NSLocalizedString("no_internet_connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.indexItemToDelete = 999;
            
            return;
        }
        
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Récupération des détails de la tâche en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            
            WSQueries.getTacheForcesTerrains(delegate: self, taskId: self.tache.taskId);
        }
        return
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSGetTacheForcesTerrains(error: Bool, data: TacheForceTerrainWSResponse!) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            DispatchQueue.main.async {
                
                self.tache = data.data.task;
                self.setupDetailsTache();
            }
            return;
            
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: (data.description_ + "\ncode erreur : " + String(data.code_erreur)), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
}
