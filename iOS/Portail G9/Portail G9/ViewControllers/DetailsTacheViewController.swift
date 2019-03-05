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
        labelTache.text = tache.titre
        
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
            return 2
            return tache.controles.count
        }
        else if(tableView == fichiersTableView)
        {
            return tache.fichiers.count
        }
        else if(tableView == commentairesTableView)
        {
            return tache.commentaires.count
        }
        
        return 0
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == controlesTableView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ControleTableViewCell", for: indexPath) as! ControleTableViewCell
            
            return cell
        }
        else if(tableView == fichiersTableView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FichierTableViewCell", for: indexPath) as! FichierTableViewCell
            
            return cell
        }
        else if(tableView == commentairesTableView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentaireTableViewCell", for: indexPath) as! CommentaireTableViewCell
            
            return cell
        }
        
        return UITableViewCell();
        
    }
    

   

}

