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
class ListeGroupesViewController: UIViewController , NVActivityIndicatorViewable{

    @IBOutlet weak var buttonIndicateur: UIButton!
    var familleLibelle = "";
    
    @IBOutlet weak var tableViewGroupes: UITableView!
    
    var categorie : Categorie = Categorie();
    var arrayGroupes : [GroupeKPI] = [GroupeKPI]();
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Groupes", comment: "-")
        buttonIndicateur.setTitle(familleLibelle, for: .normal) 
        
        // **
        let filtreButton = UIBarButtonItem(image: UIImage(named: "ic_filter_"), style: .plain, target: self, action: #selector(filtreTapped))
        navigationItem.rightBarButtonItems = [filtreButton]
        //**
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        if(animated)
        {
            self.getListeGroupeData()
        }
    }

    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func returnToIndicateurs(_ sender: Any) {
        
        let vcCategorie = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3];
        self.navigationController?.popToViewController(vcCategorie!, animated: true);
    }
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func returnToCategorie(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func getListeGroupeData()
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
            self.startAnimating(size, message: "Récupération des groupes en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.getGroupesKPIData(delegate: self, categorie_id: self.categorie.categoryId);
        }
    }
}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeGroupesViewController : WSGetGroupesKPIDelegate {
    
    func didFinishWSGetGroupesKPI(error: Bool, data: DataGroupeKPIWSResponse!) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
            
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                arrayGroupes = data.groupes;
                
                DispatchQueue.main.async {
                    self.tableViewGroupes.reloadData()
                }
            }
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: "Une erreur est survenue lors de la récupération des groupes.", preferredStyle: UIAlertController.Style.alert)
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
extension ListeGroupesViewController : UITableViewDelegate , UITableViewDataSource {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrayGroupes.count
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListeGroupesTableViewCell", for: indexPath) as! ListeGroupesTableViewCell
        
        let row = indexPath.row
        
        if(row < arrayGroupes.count)
        {
            let grp = arrayGroupes[row] ;
            cell.setupGroupeCell(groupe: grp);
        }
        
        return cell;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let grp = self.arrayGroupes[indexPath.row] ;
        
        let kpiVC = self.storyboard?.instantiateViewController(withIdentifier: "KPIIndicatorsViewController") as? KPIIndicatorsViewController
        kpiVC?.groupe = grp
        kpiVC?.categorie = self.categorie
        kpiVC?.familleLibelle = self.familleLibelle 
        self.navigationController?.pushViewController(kpiVC!, animated: true);
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderListeGroupesTableViewCell") as! ListeGroupesTableViewCell
        
        cell.setupHeaderCell(categ: self.categorie)
        return cell
    }
    
}


// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeGroupesViewController: FiltreViewDelegate {
    
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
extension ListeGroupesViewController: FiltreMenuViewControllerDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltreMenuViewController(isLangueChanged : Bool) {
        
        if(!isLangueChanged)
        {
            self.dismiss(animated: true, completion: nil)
            self.getListeGroupeData()
        }else
        {
            self.dismiss(animated: false, completion: nil)
            self.returnToIndicateurs(buttonIndicateur)
        }
        
    }
    
    
}
