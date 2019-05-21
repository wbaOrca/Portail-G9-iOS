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
    var arrayIndicateurs : [String] = [String]();
    
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
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupIndicateurs(){
        
        self.title = NSLocalizedString("Indicateurs", comment: "")
        
       arrayIndicateurs = [ NSLocalizedString("Vente", comment: ""),
          NSLocalizedString("Après ventes", comment: ""),
          NSLocalizedString("Clients", comment: ""),
          NSLocalizedString("Image de marque", comment: "")] ;
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayIndicateurs.count
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListeIndicateurTableViewCell", for: indexPath) as! ListeIndicateurTableViewCell
        
        let row = indexPath.row
        
        if(row < arrayIndicateurs.count)
        {
            let indicateur = arrayIndicateurs[row] ;
            cell.setupIndicateurCell(indictauer: indicateur);
        }
        
        return cell;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indicateur = self.arrayIndicateurs[indexPath.row] ;
        
        let listeCategoriesVC = self.storyboard?.instantiateViewController(withIdentifier: "ListeCategoriesViewController") as? ListeCategoriesViewController
        listeCategoriesVC?.familleLibelle = indicateur ;
        listeCategoriesVC?.familleId = indexPath.row + 1 ;
        self.navigationController?.pushViewController(listeCategoriesVC!, animated: true);
        
        
        
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
