//
//  KPIIndicatorsViewControllerS2.swift
//  Portail G9
//
//  Created by WBA_ORCA on 03/12/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class KPIIndicatorsViewControllerS2: KPIIndicatorsViewController {

    var selectedId : Int64 = -1
    var selectedTitle : String = ""
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = selectedTitle
        
        // **
        navigationItem.rightBarButtonItems = []
        //**
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction override func returnToIndicator(_ sender: Any) {
        
        let vcCategorie = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 5];
        self.navigationController?.popToViewController(vcCategorie!, animated: true);
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction override func returnToGroupe(_ sender: Any) {
        
        let vcCategorie = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3];
        self.navigationController?.popToViewController(vcCategorie!, animated: true);
    }
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction override func returnToCategorie(_ sender: Any) {
        
        let vcCategorie = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 4];
        self.navigationController?.popToViewController(vcCategorie!, animated: true);
    }
    
    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 110, height: 80)
    }

    // ***********************************
    // ***********************************
    // ***********************************
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KPICollectionViewCell", for: indexPath) as! KPICollectionViewCell
        cell.delegate = self;
       
        cell.setupKPICollectionViewCellGrid(indicateur: self.arrayValuesOfCollection[indexPath.section][indexPath.row],isButtonPlusHidden: true)
        
        
        return cell
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func getIndicateursKpisData()
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
            WSQueries.getIndicateurKPIsDetailsByZone(delegate: self, groupe_id:self.groupe.groupId, selected_zone: self.selectedId , date: self.mSelectedDate);
        }
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension KPIIndicatorsViewControllerS2 : WSGetIndicateursKPIDetailsDelegate
{
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSGetIndicateursDetailsKPIs(error: Bool, data: DataKPIsWSResponse!) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
            
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                let array_ = KPI.translateKPIToIndicateurKPISection(arrayKPI: data.kpiArray);
                
                arrayKPIs = array_;
                self.arrayValuesOfCollection = KPI.translateIndicateurKPISectionToArrayGrid2(arrayKPI: array_)
                
                if(data.lastDate.count > 0 && data.requstedDate.count > 0)
                {
                    if(data.requstedDate != data.lastDate)
                    {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        
                        mSelectedDate = dateFormatter.date(from: data.lastDate)!
                        dateButton.setTitle(data.lastDate, for: .normal)
                    }
                }
                
                DispatchQueue.main.async {
                    self.collectioViewKPI.reloadData()
                }
            }
        }else
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            DispatchQueue.main.async {
                let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), message: NSLocalizedString("erreur_survenue_request", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
}
