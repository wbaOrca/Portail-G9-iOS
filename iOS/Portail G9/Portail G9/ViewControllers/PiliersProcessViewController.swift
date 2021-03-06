//
//  PiliersProcessViewController.swift
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
class PiliersProcessViewController: UIViewController , NVActivityIndicatorViewable{

    
    @IBOutlet weak var tableViewPilier: UITableView!
    
    var isSynchronisedData = false;
    var arrayPiliers : [Pilier] = [Pilier]();
    
    // *****************************************
    // *****************************************
    // ****** viewDidLoad
    // *****************************************
    // *****************************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = NSLocalizedString("Piliers", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        
        
        //**
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
            self.getListePiliersData()
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
    func getListePiliersData()
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
            WSQueries.getListePiliers(delegate: self)
        }
    }
    

    

}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension PiliersProcessViewController : UITableViewDelegate , UITableViewDataSource {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayPiliers.count
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListePilierTableViewCell", for: indexPath) as! ListePilierTableViewCell
        
        let row = indexPath.row
        
        
        if(row < arrayPiliers.count)
        {
            let pilier = arrayPiliers[row] ;
            cell.setupPilierCell(pilier: pilier);
        }
        
        return cell;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pilier = self.arrayPiliers[indexPath.row] ;
        
        let listeQuestionPilierVC = self.storyboard?.instantiateViewController(withIdentifier: "ListeQuestionPilierViewController") as? ListeQuestionPilierViewController
        listeQuestionPilierVC?.mPilier = pilier
        self.navigationController?.pushViewController(listeQuestionPilierVC!, animated: true);
        
    }
    
    
}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension PiliersProcessViewController: FiltreViewDelegate {
    
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
extension PiliersProcessViewController: FiltreMenuViewControllerDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltreMenuViewController(isLangueChanged : Bool) {
        
        if(!isLangueChanged)
        {
            self.dismiss(animated: true, completion: nil)
            self.getListePiliersData()
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
extension PiliersProcessViewController: WSGetListePiliersDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSGetListePiliers(error: Bool, data: ListePiliersWSResponse!) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
            
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                arrayPiliers = data.arrayPiliers;
                
                DispatchQueue.main.async {
                    self.tableViewPilier.reloadData()
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
                let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("erreur_survenue_request", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "") , preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
    
    
    
    
    
    
}
