//
//  ListeIndicateursViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 21/05/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class ListeIndicateursViewController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var tableViewIndicateurs: UITableView!
    var arrayFamille : [Famille] = [Famille]();
    var isSynchronisedData = false;
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Indicateurs", comment: "")
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(!isSynchronisedData)
        {
            self.getListeFamillesData()
        }
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func getListeFamillesData()
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
            self.startAnimating(size, message: "Récupération des familles en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.getFamilleData(delegate: self);
        }
    }
    // *******************************
    // **** selectFamille
    // *******************************
    @IBAction func selectFamille (_ sender: UIButton!) {
        
        let tag = sender.tag
        let famille = self.arrayFamille[tag] ;
        
        let listeCategoriesVC = self.storyboard?.instantiateViewController(withIdentifier: "ListeCategoriesViewController") as? ListeCategoriesViewController
        listeCategoriesVC?.familleLibelle = famille.RubriqueTitle ;
        listeCategoriesVC?.familleId = famille.RubriqueId ;
        self.navigationController?.pushViewController(listeCategoriesVC!, animated: true);
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupIndicateurs(){
        //arrayFamille = Famille.initStaticTable();
        //tableViewIndicateurs.reloadData()
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
        
        return arrayFamille.count
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayFamille[section].kpisRassembles.count
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListeIndicateurTableViewCell", for: indexPath) as! ListeIndicateurTableViewCell
        
        let famille = arrayFamille[indexPath.section] ;
        let kpi = famille.kpisRassembles[indexPath.row]
        
        cell.setupIndicateurCell(indictauer: kpi);
        
        
        return cell;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListeIndicateurTableViewCellHeader") as! ListeIndicateurTableViewCell
        
        let famille = arrayFamille[section] ;
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
    func dismissFiltreMenuViewController(isLangueChanged : Bool) {
        
        self.dismiss(animated: true, completion: nil)
        self.getListeFamillesData()
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

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeIndicateursViewController : WSGetFamillesDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSGetActionsPlan(error: Bool, data: GetActionPlansWSResponse!) {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
            
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                arrayFamille = data.familles;
                for i in (0 ..< arrayFamille.count)
                {
                    let famille = arrayFamille[i]
                    famille.rassemblerKPI()
                }
                
                DispatchQueue.main.async {
                    self.tableViewIndicateurs.reloadData()
                }
            }
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: "Une erreur est survenue lors de la récupération des familles.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
    
    
}
