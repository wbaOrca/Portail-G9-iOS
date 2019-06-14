//
//  ListeIndicateursViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 21/05/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class ListeIndicateursViewController: UIViewController {

    @IBOutlet weak var tableViewIndicateurs: UITableView!
    var arrayIndicateurs : [Famille] = [Famille]();
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // **
        self.setupIndicateurs()
        // **
        let filtreButton = UIBarButtonItem(image: UIImage(named: "ic_filter_"), style: .plain, target: self, action: #selector(filtreTapped))
        navigationItem.rightBarButtonItems = [filtreButton]
        //**
    }
    
    // *******************************
    // **** selectFamille
    // *******************************
    @IBAction func selectFamille (_ sender: UIButton!) {
        
        let tag = sender.tag
        let famille = self.arrayIndicateurs[tag] ;
        
        let listeCategoriesVC = self.storyboard?.instantiateViewController(withIdentifier: "ListeCategoriesViewController") as? ListeCategoriesViewController
        listeCategoriesVC?.familleLibelle = famille.libelle ;
        listeCategoriesVC?.familleId = famille.id ;
        self.navigationController?.pushViewController(listeCategoriesVC!, animated: true);
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupIndicateurs(){
        
        self.title = NSLocalizedString("Indicateurs", comment: "")
        
       arrayIndicateurs = Famille.initStaticTable();
        
        tableViewIndicateurs.reloadData()
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
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeIndicateursViewController : UITableViewDelegate , UITableViewDataSource {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arrayIndicateurs.count
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayIndicateurs[section].indicateurs.count
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListeIndicateurTableViewCell", for: indexPath) as! ListeIndicateurTableViewCell
        
        let famille = arrayIndicateurs[indexPath.section] ;
        let indicateur = famille.indicateurs[indexPath.row]
        
        cell.setupIndicateurCell(indictauer: indicateur);
        
        
        return cell;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListeIndicateurTableViewCellHeader") as! ListeIndicateurTableViewCell
        
        let famille = arrayIndicateurs[section] ;
        cell.setupIndicateurCellHeader(famille: famille)
        
        return cell
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeIndicateursViewController: FiltreMenuViewControllerDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltreMenuViewController() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeIndicateursViewController : FiltreViewDelegate {
    
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
        
        self.setupIndicateurs()
    }
    
    
}
