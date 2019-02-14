//
//  ListeCategoriesViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 14/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class ListeCategoriesViewController: UIViewController , NVActivityIndicatorViewable{

    @IBOutlet weak var filtreView : FiltreView!
    @IBOutlet weak var tableViewCategoris: UITableView!
    
    var familleId = 0;
    var isSynchronisedData = false;
    var arrayCategories : [Categorie] = [Categorie]();
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Categories", comment: "-")
        filtreView.delegate = self
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // filtreView
        filtreView.setupFiltreView()
        
        if(!isSynchronisedData)
        {
            self.getListeCatagoriesData()
        }
    }

    // ***********************************
    // ***********************************
    // ***********************************
    func getListeCatagoriesData()
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
            self.startAnimating(size, message: "Récupération des catégories en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.getCategoriesData(delegate: self, famille_id: self.familleId);
        }
    }
}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeCategoriesViewController : WSGetCategoriesDelegate {
    
    func didFinishWSGetCategories(error: Bool, data: DataCategoriesWSResponse!) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
            
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                arrayCategories = data.categories;
                
                DispatchQueue.main.async {
                    self.tableViewCategoris.reloadData()
                }
            }
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: "Une erreur est survenue lors de la récupération des catégories.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
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
extension ListeCategoriesViewController : UITableViewDelegate , UITableViewDataSource {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrayCategories.count
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListeCategoriesTableViewCell", for: indexPath) as! ListeCategoriesTableViewCell
        
        let row = indexPath.row
        
        if(row < arrayCategories.count)
        {
            let carteg = arrayCategories[row] ;
            cell.setupCategorieCell(categorie: carteg );
        }
        
        return cell;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let carteg = self.arrayCategories[indexPath.row] ;
        
        let listeGroupesVC = self.storyboard?.instantiateViewController(withIdentifier: "ListeGroupesViewController") as? ListeGroupesViewController
        listeGroupesVC?.categorieId = carteg.categoryId
        self.navigationController?.pushViewController(listeGroupesVC!, animated: true);
        
    }
    
    
}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeCategoriesViewController: FiltreViewDelegate {
    
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
extension ListeCategoriesViewController: FiltreMenuViewControllerDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltreMenuViewController() {
        
        self.dismiss(animated: true, completion: nil)
        self.getListeCatagoriesData()
    }
    
    
}
