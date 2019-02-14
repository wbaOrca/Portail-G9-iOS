//
//  FiltreMenuViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 04/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

import RSSelectionMenu

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class FiltreMenuViewController: UIViewController {
    
    var delegate : FiltreMenuViewControllerDelegate! = nil
    
    @IBOutlet weak var filtreCollectionView: UICollectionView!
    var arrayFiltres : [String] = ["Langue", "Pays","Zone", "Groupe" , "Affaire"];
    var arrayIcones : [String] = ["ic_langue","ic_pays","ic_zone","ic_groupe","ic_affaire"];
    
    
    var arrayOfLangues : [Langue] = [Langue]();
    var arrayOfSelectedLangue : [Langue] = [Langue]();
    
    var arrayOfPays : [Pays] = [Pays]();
    var arrayOfSelectedPays : [Pays] = [Pays]();
    
    var arrayOfSelectedZone : [Zone] = [Zone]();
    var arrayOfSelectedGroupe : [Groupe] = [Groupe]();
    var arrayOfSelectedAffaire : [Dealer] = [Dealer]();
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 1 liste des langues
        let preferences = UserDefaults.standard
        let languesData = preferences.data(forKey: Utils.SHARED_PREFERENCE_LANGUAGES);
        if(languesData != nil){
            if let langue_array_ = NSKeyedUnarchiver.unarchiveObject(with: languesData!)  {
                
                let langue_array = langue_array_ as! [Langue]
                self.arrayOfLangues = langue_array
                
            }
        }
        
        // la langue par défaut
        let langueData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE);
        if(langueData_ != nil){
            if let langue_ = NSKeyedUnarchiver.unarchiveObject(with: langueData_!)  {
                
                let langue = langue_ as! Langue
                arrayOfSelectedLangue.append(langue)
                arrayFiltres[0] = langue.libelle
                
            }
        }
        
        // 1 liste des pays
        let dataPerimetre = preferences.data(forKey: Utils.SHARED_PREFERENCE_DATA_PERIMETRE);
        if(dataPerimetre != nil){
            if let dataPerimetre_ = NSKeyedUnarchiver.unarchiveObject(with: dataPerimetre!)  {
                
                let pays_array = dataPerimetre_ as! [Pays]
                self.arrayOfPays = pays_array
                
            }
        }
        
        // Pays par défaut
        let paysData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS);
        if(paysData_ != nil){
            if let pays_ = NSKeyedUnarchiver.unarchiveObject(with: paysData_!)  {
                
                let pays = pays_ as! Pays
                arrayOfSelectedPays.append(pays)
                arrayFiltres[1] = pays.countryLib
                
            }
        }
        
        // Zone par défaut
        let zoneData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_ZONE);
        if(zoneData_ != nil){
            if let zone_ = NSKeyedUnarchiver.unarchiveObject(with: zoneData_!)  {
                
                let zone = zone_ as! Zone
                arrayOfSelectedZone.append(zone)
                arrayFiltres[2] = zone.libelle
                
            }
        }
        
        // Groupe par défaut
        let grpData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_GROUPE);
        if(grpData_ != nil){
            if let grp_ = NSKeyedUnarchiver.unarchiveObject(with: grpData_!)  {
                
                let group = grp_ as! Groupe
                arrayOfSelectedGroupe.append(group)
                arrayFiltres[3] = group.libelle
                
            }
        }
        
        // Affaire par défaut
        let dealerData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE);
        if(dealerData_ != nil){
            if let affaire_ = NSKeyedUnarchiver.unarchiveObject(with: dealerData_!)  {
                
                let dealer = affaire_ as! Dealer
                arrayOfSelectedAffaire.append(dealer)
                arrayFiltres[4] = dealer.libelle
                
            }
        }
       
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func selectOk(_ sender: Any) {
        
        let preferences = UserDefaults.standard
        
        if(arrayOfSelectedLangue.count > 0)
        {
            let langue = arrayOfSelectedLangue[0];
            let dataLangueParDefaut = NSKeyedArchiver.archivedData(withRootObject: langue)
            preferences.set(dataLangueParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE)
        }else
        {
            preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE)
        }
        
        if(arrayOfSelectedPays.count > 0)
        {
            let pays = arrayOfSelectedPays[0];
            let dataPaysParDefaut = NSKeyedArchiver.archivedData(withRootObject: pays)
            preferences.set(dataPaysParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS)
        }else
        {
             preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS)
        }
        
        if(arrayOfSelectedZone.count > 0)
        {
            let zone = arrayOfSelectedZone[0];
            let dataZoneParDefaut = NSKeyedArchiver.archivedData(withRootObject: zone)
            preferences.set(dataZoneParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_ZONE)
        }else
        {
            preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_ZONE)
        }
        
        if(arrayOfSelectedGroupe.count > 0)
        {
            let groupe = arrayOfSelectedGroupe[0];
            let dataGroupeParDefaut = NSKeyedArchiver.archivedData(withRootObject: groupe)
            preferences.set(dataGroupeParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_GROUPE)
        }else
        {
            preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_GROUPE)
        }
        
        if(arrayOfSelectedAffaire.count > 0)
        {
            let affaire = arrayOfSelectedAffaire[0];
            let dataAffaireParDefaut = NSKeyedArchiver.archivedData(withRootObject: affaire)
            preferences.set(dataAffaireParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE)
        }else
        {
            preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE)
        }
        
        //save
        preferences.synchronize()
        //dismiss
        dismissFiltre()
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltre() {
        
        self.delegate.dismissFiltreMenuViewController()
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectAffaire() {
        
        if(self.arrayOfSelectedZone.count == 0 && self.arrayOfSelectedGroupe.count == 0 )
        {
            let alertController = UIAlertController(title: "Erreur", message: "Veuillez sélectionner une zone ou un groupe", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        var arrayAffaire : [Dealer] = [Dealer]()
        if(self.arrayOfSelectedZone.count > 0 && self.arrayOfSelectedGroupe.count == 0 )
        {
            let zone_selected = self.arrayOfSelectedZone[0]
            arrayAffaire = zone_selected.dealers
        }else  if(self.arrayOfSelectedZone.count == 0 && self.arrayOfSelectedGroupe.count > 0 )
        {
            let groupe_selected = self.arrayOfSelectedGroupe[0]
            arrayAffaire = groupe_selected.dealers
        }
        
        
        if(arrayAffaire.count == 0 )
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucune affaire.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        // Show menu with datasource array - Default SelectionType = Single
        // Here you'll get cell configuration where you can set any text based on condition
        // Cell configuration following parameters.
        // 1. UITableViewCell   2. Object of type T   3. IndexPath
        
        let selectionMenu =  RSSelectionMenu(dataSource: arrayAffaire ) { (cell, object, indexPath) in
            cell.textLabel?.text = object.libelle
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedAffaire) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedAffaire =  selectedItems
            
            
            if(self.arrayOfSelectedAffaire.count > 0)
            {
                let dealer_ = self.arrayOfSelectedAffaire[0]
                self.arrayFiltres[4] = dealer_.libelle
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                }
            }
            
        }
        
        selectionMenu.uniquePropertyName = "id"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: "Affaire", action: "Sélectionner", height: 400), from: self)
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectGroupe() {
        
        if(arrayOfSelectedPays.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucun pays.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let selectedPays = arrayOfSelectedPays[0];
        if(selectedPays.groupes.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucun groupe.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // Show menu with datasource array - Default SelectionType = Single
        // Here you'll get cell configuration where you can set any text based on condition
        // Cell configuration following parameters.
        // 1. UITableViewCell   2. Object of type T   3. IndexPath
        
        let selectionMenu =  RSSelectionMenu(dataSource: selectedPays.groupes ) { (cell, object, indexPath) in
            cell.textLabel?.text = object.libelle
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedGroupe) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedGroupe =  selectedItems
            //reset zone + affaire
            self.arrayOfSelectedZone.removeAll()
            self.arrayFiltres[2] = "Zone"
            self.arrayOfSelectedAffaire.removeAll()
            self.arrayFiltres[4] = "Affaire"
            
            if(self.arrayOfSelectedGroupe.count > 0)
            {
                let groupe_ = self.arrayOfSelectedGroupe[0]
                self.arrayFiltres[3] = groupe_.libelle
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                }
            }
            
        }
        
        selectionMenu.uniquePropertyName = "id"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: "Groupe", action: "Sélectionner", height: 400), from: self)
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectZone() {
        
        if(arrayOfSelectedPays.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucun pays.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let selectedPays = arrayOfSelectedPays[0];
        if(selectedPays.zones.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucun zone.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // Show menu with datasource array - Default SelectionType = Single
        // Here you'll get cell configuration where you can set any text based on condition
        // Cell configuration following parameters.
        // 1. UITableViewCell   2. Object of type T   3. IndexPath
        
        let selectionMenu =  RSSelectionMenu(dataSource: selectedPays.zones ) { (cell, object, indexPath) in
            cell.textLabel?.text = object.libelle
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedZone) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedZone =  selectedItems
            
            //reset groupe + affaire
            self.arrayOfSelectedGroupe.removeAll()
            self.arrayFiltres[3] = "Groupe"
            self.arrayOfSelectedAffaire.removeAll()
            self.arrayFiltres[4] = "Affaire"
            
            if(self.arrayOfSelectedZone.count > 0)
            {
                let zone_ = self.arrayOfSelectedZone[0]
                self.arrayFiltres[2] = zone_.libelle
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                }
            }
            
        }
        
        selectionMenu.uniquePropertyName = "id"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: "Zone", action: "Sélectionner", height: 400), from: self)
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectPays() {
        
        if(arrayOfPays.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucun pays.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // Show menu with datasource array - Default SelectionType = Single
        // Here you'll get cell configuration where you can set any text based on condition
        // Cell configuration following parameters.
        // 1. UITableViewCell   2. Object of type T   3. IndexPath
        
        let selectionMenu =  RSSelectionMenu(dataSource: arrayOfPays ) { (cell, object, indexPath) in
            cell.textLabel?.text = object.countryLib
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedPays) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedPays =  selectedItems
            
            if(self.arrayOfSelectedPays.count > 0)
            {
                let pays_ = self.arrayOfSelectedPays[0]
                self.arrayFiltres[1] = pays_.countryLib
                
                //reset zone + groupe + affaire
                self.arrayOfSelectedZone.removeAll()
                self.arrayFiltres[2] = "Zone"
                self.arrayOfSelectedGroupe.removeAll()
                self.arrayFiltres[3] = "Groupe"
                self.arrayOfSelectedAffaire.removeAll()
                self.arrayFiltres[4] = "Affaire"
                
                
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                }
            }
            
        }
        
        selectionMenu.uniquePropertyName = "countryId"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: "Pays", action: "Sélectionner", height: 400), from: self)
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectLangue() {
        
        
        if(arrayOfLangues.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucune langue.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // Show menu with datasource array - Default SelectionType = Single
        // Here you'll get cell configuration where you can set any text based on condition
        // Cell configuration following parameters.
        // 1. UITableViewCell   2. Object of type T   3. IndexPath
        
        let selectionMenu =  RSSelectionMenu(dataSource: arrayOfLangues ) { (cell, object, indexPath) in
            cell.textLabel?.text = object.libelle
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedLangue) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedLangue =  selectedItems
            
            if(self.arrayOfSelectedLangue.count > 0)
            {
                let langue_ = self.arrayOfSelectedLangue[0]
                self.arrayFiltres[0] = langue_.libelle
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                }
            }
           
        }
        
        selectionMenu.uniquePropertyName = "languageId"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: "Langue", action: "Sélectionner", height: 400), from: self)
        
    }

}


// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension FiltreMenuViewController: UICollectionViewDelegate , UICollectionViewDataSource
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
        switch indexPath.row {
        
        case 0:
            selectLangue()
            break;
        case 1:
            selectPays()
            break;
        case 2:
            selectZone()
            break;
        case 3:
            selectGroupe()
            break;
        case 4:
            selectAffaire()
            break;
            
        default:
            
            return;
            
        }
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
protocol FiltreMenuViewControllerDelegate {
    func dismissFiltreMenuViewController()
}
