//
//  FiltreView.swift
//  Portail G9
//
//  Created by WBA_ORCA on 04/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit


// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
protocol FiltreViewDelegate {
    
    func showFiltreMenuViewController()
    func dismissFiltreView()
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class FiltreView: UIView {

    var delegate : FiltreViewDelegate! = nil
    
    @IBOutlet weak var filtreCollectionView: UICollectionView!
    var arrayFiltres : [String] = [NSLocalizedString("Langue", comment: "-"), NSLocalizedString("Pays", comment: "-"),NSLocalizedString("Zone", comment: "-"), NSLocalizedString("Groupe", comment: "-"), NSLocalizedString("Affaire", comment: "-")];
    var arrayIcones : [String] = ["ic_langue","ic_pays","ic_zone","ic_groupe","ic_affaire"];
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupFiltreView()
    {
        
        let preferences = UserDefaults.standard
        
        //1  la langue
        let langueData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE);
        if(langueData_ != nil){
            if let langue_ = NSKeyedUnarchiver.unarchiveObject(with: langueData_!)  {
                
                let langue = langue_ as! Langue
                arrayFiltres[0] = langue.libelle
                
            }
        }else
        {
            arrayFiltres[0] = NSLocalizedString("Langue", comment: "-")
        }
        
        //2 le pays
        let paysData = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS);
        if(paysData != nil){
            if let pays_ = NSKeyedUnarchiver.unarchiveObject(with: paysData!)  {
                
                let pays = pays_ as! Pays
                arrayFiltres[1] = pays.countryLib
                
            }
        }
        else
        {
            arrayFiltres[1] = NSLocalizedString("Pays", comment: "-")
        }
        
        //3 zone
        let zoneData = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_ZONE);
        if(zoneData != nil){
            if let zone_ = NSKeyedUnarchiver.unarchiveObject(with: zoneData!)  {
                
                let zone = zone_ as! Zone
                arrayFiltres[2] = zone.libelle
                
            }
        }else
        {
            arrayFiltres[2] = NSLocalizedString("Zone", comment: "-")
        }
        
        //4 Groupe
        let groupeData = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_GROUPE);
        if(groupeData != nil){
            if let groupe_ = NSKeyedUnarchiver.unarchiveObject(with: groupeData!)  {
                
                let grp = groupe_ as! Groupe
                arrayFiltres[3] = grp.libelle
                
            }
        }else
        {
            arrayFiltres[3] = NSLocalizedString("Groupe", comment: "-")
        }
        
        //5 Affaire
        let dealerData = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE);
        if(dealerData != nil){
            if let dealer_ = NSKeyedUnarchiver.unarchiveObject(with: dealerData!)  {
                
                let affaire = dealer_ as! Dealer
                arrayFiltres[4] = affaire.libelle
                
            }
        }else
        {
            arrayFiltres[4] = NSLocalizedString("Affaire", comment: "-")
        }
        
        
        self.filtreCollectionView.reloadData();
    }
    
    
   /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
   */

}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension FiltreView: UICollectionViewDelegate , UICollectionViewDataSource
{
    // ***********************************
    // ***********************************
    // ***********************************
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 ;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 ;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltreCollectionViewCell", for: indexPath) as! FiltreCollectionViewCell
        
        if(indexPath.row < arrayIcones.count)
        {
            cell.iconImage.image = UIImage(named: arrayIcones[indexPath.row])
            cell.titleLabel.text = arrayFiltres[indexPath.row];
        }
        
        return cell
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(delegate != nil)
        {
            delegate.showFiltreMenuViewController()
        }
    }
    
}
