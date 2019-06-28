//
//  FiltreMenuViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 04/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView
import RSSelectionMenu

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class FiltreMenuViewController: UIViewController {
    
    var delegate : FiltreMenuViewControllerDelegate! = nil
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var filtreCollectionView: UICollectionView!
    
    var arrayFiltres : [String] =  [NSLocalizedString("Langue", comment: "-"), NSLocalizedString("Pays", comment: "-"),NSLocalizedString("Zone", comment: "-"), NSLocalizedString("Groupe", comment: "-"), NSLocalizedString("Affaire", comment: "-")];
    var arrayIcones : [String] = ["ic_langue","ic_pays","ic_zone","ic_groupe","ic_affaire"];
    
    
    var arrayOfLangues : [Langue] = [Langue]();
    var arrayOfSelectedLangue : [Langue] = [Langue]();
    
    var arrayOfPays : [Pays] = [Pays]();
    var arrayOfSelectedPays : [Pays] = [Pays]();
    
    var arrayOfSelectedDR : [Direction] = [Direction]();
    var arrayOfSelectedZone : [Zone] = [Zone]();
    var arrayOfSelectedGroupe : [Groupe] = [Groupe]();
    var arrayOfSelectedAffaire : [Dealer] = [Dealer]();
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupDataFiltre();
        okButton.layer.cornerRadius = 5.0;
        okButton.clipsToBounds = true;
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupDataFiltre()
    {
        
        self.arrayFiltres  =  [NSLocalizedString("Langue", comment: "-"), NSLocalizedString("Pays", comment: "-"),NSLocalizedString("Zone", comment: "-"), NSLocalizedString("Groupe", comment: "-"), NSLocalizedString("Affaire", comment: "-")];
        self.arrayIcones = ["ic_langue","ic_pays","ic_zone","ic_groupe","ic_affaire"];
        
        self.arrayOfLangues.removeAll()
        self.arrayOfSelectedLangue.removeAll()
        self.arrayOfPays.removeAll()
        self.arrayOfSelectedPays.removeAll()
        arrayOfSelectedDR.removeAll()
        arrayOfSelectedZone.removeAll()
        arrayOfSelectedGroupe.removeAll()
        arrayOfSelectedAffaire.removeAll()
        
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
        var isPaysHasDR = false
        // Pays par défaut
        let paysData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS);
        if(paysData_ != nil){
            if let pays_ = NSKeyedUnarchiver.unarchiveObject(with: paysData_!)  {
                
                let pays = pays_ as! Pays
                isPaysHasDR = pays.hasDr
                arrayOfSelectedPays.append(pays)
                arrayFiltres[1] = pays.countryLib
                
            }
        }
        
        // DR direction regionale par défaut
        if(isPaysHasDR){
            
           arrayFiltres.insert(NSLocalizedString("DR", comment: "-"), at: 2);
            arrayIcones.insert("ic_dr", at: 2);
            
            let drData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_DR);
            if(drData_ != nil){
                if let dr_ = NSKeyedUnarchiver.unarchiveObject(with: drData_!)  {
                    
                    let dr = dr_ as! Direction
                    arrayOfSelectedDR.append(dr)
                    arrayFiltres[2] = dr.libelle
                    
                }
            }
            // Zone par défaut
            let zoneData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_ZONE);
            if(zoneData_ != nil){
                if let zone_ = NSKeyedUnarchiver.unarchiveObject(with: zoneData_!)  {
                    
                    let zone = zone_ as! Zone
                    arrayOfSelectedZone.append(zone)
                    arrayFiltres[3] = zone.libelle
                    
                }
            }
            
            // Groupe par défaut
            let grpData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_GROUPE);
            if(grpData_ != nil){
                if let grp_ = NSKeyedUnarchiver.unarchiveObject(with: grpData_!)  {
                    
                    let group = grp_ as! Groupe
                    arrayOfSelectedGroupe.append(group)
                    arrayFiltres[4] = group.libelle
                    
                }
            }
            
            // Affaire par défaut
            let dealerData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE);
            if(dealerData_ != nil){
                if let affaire_ = NSKeyedUnarchiver.unarchiveObject(with: dealerData_!)  {
                    
                    let dealer = affaire_ as! Dealer
                    arrayOfSelectedAffaire.append(dealer)
                    arrayFiltres[5] = dealer.libelle
                    
                }
            }
        }else // pas de DR
        {
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
        self.filtreCollectionView.reloadData();
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
        
        if(arrayOfSelectedDR.count > 0)
        {
            let dr = arrayOfSelectedDR[0];
            let dataDRParDefaut = NSKeyedArchiver.archivedData(withRootObject: dr)
            preferences.set(dataDRParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_DR)
        }else
        {
            preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_DR)
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dealer = Dealer()
        dealer.libelle = NSLocalizedString("TOUT", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
        dealer.id = -1 ;
        arrayAffaire.insert(dealer, at: 0);
        
        // Show menu with datasource array - Default SelectionType = Single
        // Here you'll get cell configuration where you can set any text based on condition
        // Cell configuration following parameters.
        // 1. UITableViewCell   2. Object of type T   3. IndexPath
        
        let selectionMenu =  RSSelectionMenu(dataSource: arrayAffaire ) { (cell, object, indexPath) in
            cell.textLabel?.text = object.libelle
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // show searchbar with placeholder and tint color
        selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("Affaire", comment: "-"), tintColor: UIColor.lightGray.withAlphaComponent(0.6)) { (searchtext) -> ([Dealer]) in
            return arrayAffaire.filter({ $0.libelle.lowercased().contains(searchtext.lowercased()) })
        }
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        selectionMenu.setSelectedItems(items: arrayOfSelectedAffaire) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedAffaire =  selectedItems
            
            
            if(self.arrayOfSelectedAffaire.count > 0)
            {
                let dealer_ = self.arrayOfSelectedAffaire[0]
                let selectedPays = self.arrayOfSelectedPays[0];
                
                if(dealer_.id != -1) {
                    
                    if(selectedPays.hasDr == false)
                    {
                        self.arrayFiltres[4] = dealer_.libelle
                    }else
                    {
                        self.arrayFiltres[5] = dealer_.libelle
                    }
                }else
                {
                    self.arrayOfSelectedAffaire.removeAll()
                    if(selectedPays.hasDr == false)
                    {
                        self.arrayFiltres[4] = NSLocalizedString("Affaire", comment: "-")
                    }else
                    {
                        self.arrayFiltres[5] = NSLocalizedString("Affaire", comment: "-")
                    }
                }
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                }
            }
            
        }
        
        selectionMenu.uniquePropertyName = "id"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: NSLocalizedString("Affaire", comment: "-"), action: NSLocalizedString("Select", comment: ""), height: 400), from: self)
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
        if(selectedPays.hasDr == false && selectedPays.groupes.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucun groupe.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if(selectedPays.hasDr && arrayOfSelectedDR.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucune DR.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        var selectedDR = Direction()
        if(selectedPays.hasDr  && arrayOfSelectedDR.count == 0){
            
            let alertController = UIAlertController(title: "Erreur", message: "Aucune DR.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
            
            
        }else
        {
            if(arrayOfSelectedDR.count > 0)
            {
                selectedDR = arrayOfSelectedDR[0]
                if(selectedDR.groupes.count == 0)
                {
                    let alertController = UIAlertController(title: "Erreur", message: "Aucun groupe.", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action1)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
        }
        // Show menu with datasource array - Default SelectionType = Single
        // Here you'll get cell configuration where you can set any text based on condition
        // Cell configuration following parameters.
        // 1. UITableViewCell   2. Object of type T   3. IndexPath
        var array = (selectedPays.hasDr == false) ? selectedPays.groupes :  selectedDR.groupes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let grp = Groupe()
        grp.libelle = NSLocalizedString("TOUT", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
        grp.id = -1 ;
        array.insert(grp, at: 0);
        
        let selectionMenu =  RSSelectionMenu(dataSource: array ) { (cell, object, indexPath) in
            cell.textLabel?.text = object.libelle
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // show searchbar with placeholder and tint color
        selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("Groupe", comment: "-"), tintColor: UIColor.lightGray.withAlphaComponent(0.6)) { (searchtext) -> ([Groupe]) in
            return selectedPays.groupes.filter({ $0.libelle.lowercased().contains(searchtext.lowercased()) })
        }
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedGroupe) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedGroupe =  selectedItems
            //reset zone + affaire
            if(selectedPays.hasDr == false)
            {
                self.arrayOfSelectedZone.removeAll()
                self.arrayFiltres[2] = NSLocalizedString("Zone", comment: "-")
                self.arrayOfSelectedAffaire.removeAll()
                self.arrayFiltres[4] = NSLocalizedString("Affaire", comment: "-")
            }else
            {
                self.arrayOfSelectedZone.removeAll()
                self.arrayFiltres[3] = NSLocalizedString("Zone", comment: "-")
                self.arrayOfSelectedAffaire.removeAll()
                self.arrayFiltres[5] = NSLocalizedString("Affaire", comment: "-")
            }
            
            if(self.arrayOfSelectedGroupe.count > 0)
            {
                let groupe_ = self.arrayOfSelectedGroupe[0]
                if(groupe_.id != -1)
                {
                    if(selectedPays.hasDr == false)
                    {
                        self.arrayFiltres[3] = groupe_.libelle
                    }else
                    {
                        self.arrayFiltres[4] = groupe_.libelle
                    }
                }else // tous les groupes
                {
                    self.arrayOfSelectedGroupe.removeAll()
                    if(selectedPays.hasDr == false)
                    {
                        self.arrayFiltres[3] =  NSLocalizedString("Groupe", comment: "-")
                    }else
                    {
                        self.arrayFiltres[4] =  NSLocalizedString("Groupe", comment: "-")
                    }
                }
                
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                }
            }
            
        }
        
        selectionMenu.uniquePropertyName = "id"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: NSLocalizedString("Groupe", comment: "-"), action: NSLocalizedString("Select", comment: ""), height: 400), from: self)
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
        if(selectedPays.hasDr == false && selectedPays.zones.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucune zone.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if(selectedPays.hasDr && selectedPays.directions.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucune DR.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        }
       var selectedDR = Direction()
        if(selectedPays.hasDr  && arrayOfSelectedDR.count == 0){
           
                let alertController = UIAlertController(title: "Erreur", message: "Aucune DR.", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                }
                alertController.addAction(action1)
                self.present(alertController, animated: true, completion: nil)
                return
            
            
        }else
        {
            if(arrayOfSelectedDR.count > 0)
            {
                selectedDR = arrayOfSelectedDR[0]
                if(selectedDR.zones.count == 0)
                {
                    let alertController = UIAlertController(title: "Erreur", message: "Aucune zone.", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(action1)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
        }
        
        // Show menu with datasource array - Default SelectionType = Single
        // Here you'll get cell configuration where you can set any text based on condition
        // Cell configuration following parameters.
        // 1. UITableViewCell   2. Object of type T   3. IndexPath
        
        var array = (selectedPays.hasDr == false) ? selectedPays.zones :  selectedDR.zones
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let zone = Zone()
        zone.libelle = NSLocalizedString("TOUT", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
        zone.id = -1 ;
        array.insert(zone, at: 0);
        
        let selectionMenu =  RSSelectionMenu(dataSource: array) { (cell, object, indexPath) in
            cell.textLabel?.text = object.libelle
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // show searchbar with placeholder and tint color
        selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("Zone", comment: "-"), tintColor: UIColor.lightGray.withAlphaComponent(0.6)) { (searchtext) -> ([Zone]) in
            return selectedPays.zones.filter({ $0.libelle.lowercased().contains(searchtext.lowercased()) })
        }
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedZone) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedZone =  selectedItems
            
            //reset groupe + affaire
            if(selectedPays.hasDr == false)
            {
                self.arrayOfSelectedGroupe.removeAll()
                self.arrayFiltres[3] = NSLocalizedString("Groupe", comment: "-")
                self.arrayOfSelectedAffaire.removeAll()
                self.arrayFiltres[4] = NSLocalizedString("Affaire", comment: "-")
            }else
            {
                self.arrayOfSelectedGroupe.removeAll()
                self.arrayFiltres[4] = NSLocalizedString("Groupe", comment: "-")
                self.arrayOfSelectedAffaire.removeAll()
                self.arrayFiltres[5] = NSLocalizedString("Affaire", comment: "-")
            }
            if(self.arrayOfSelectedZone.count > 0)
            {
                let zone_ = self.arrayOfSelectedZone[0]
                if(zone_.id != -1)
                {
                    if(selectedPays.hasDr == false)
                    {
                        self.arrayFiltres[2] = zone_.libelle
                    }else
                    {
                        self.arrayFiltres[3] = zone_.libelle
                    }
                }else // toutes les zones
                {
                    self.arrayOfSelectedZone.removeAll()
                    if(selectedPays.hasDr == false)
                    {
                        self.arrayFiltres[2] =  NSLocalizedString("Zone", comment: "-")
                    }else
                    {
                        self.arrayFiltres[3] =  NSLocalizedString("Zone", comment: "-")
                    }
                }
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                }
            }
            
        }
        
        selectionMenu.uniquePropertyName = "id"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: NSLocalizedString("Zone", comment: "-"), action: NSLocalizedString("Select", comment: ""), height: 400), from: self)
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectDR() {
        
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
        if(selectedPays.directions.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucune direction.", preferredStyle: .alert)
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
        var array = selectedPays.directions
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dr = Direction()
        dr.libelle = NSLocalizedString("TOUT", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
        dr.id = -1 ;
        array.insert(dr, at: 0);
        
        let selectionMenu =  RSSelectionMenu(dataSource: array ) { (cell, object, indexPath) in
            cell.textLabel?.text = object.libelle
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // show searchbar with placeholder and tint color
        selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("DR", comment: "-"), tintColor: UIColor.lightGray.withAlphaComponent(0.6)) { (searchtext) -> ([Direction]) in
            return selectedPays.directions.filter({ $0.libelle.lowercased().contains(searchtext.lowercased()) })
        }
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedDR) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedDR =  selectedItems
            
            //reset groupe + affaire
            self.arrayOfSelectedZone.removeAll()
            self.arrayFiltres[3] = NSLocalizedString("Zone", comment: "-")
            self.arrayOfSelectedGroupe.removeAll()
            self.arrayFiltres[4] = NSLocalizedString("Groupe", comment: "-")
            self.arrayOfSelectedAffaire.removeAll()
            if(self.arrayFiltres.count > 5)
            {
                self.arrayFiltres[5] = NSLocalizedString("Affaire", comment: "-")
            }
            
            if(self.arrayOfSelectedDR.count > 0)
            {
                let dr_ = self.arrayOfSelectedDR[0]
                self.arrayFiltres[2] = dr_.libelle
                
                if(dr_.id == -1)//tout
                {
                    self.arrayOfSelectedDR.removeAll()
                    self.arrayFiltres[2] = NSLocalizedString("DR", comment: "-")
                }
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                }
            }
            
        }
        
        selectionMenu.uniquePropertyName = "id"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: NSLocalizedString("DR", comment: "-"), action: NSLocalizedString("Select", comment: ""), height: 400), from: self)
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
        
        
        // show searchbar with placeholder and tint color
        selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("Pays", comment: "-"), tintColor: UIColor.lightGray.withAlphaComponent(0.6)) { (searchtext) -> ([Pays]) in
            return self.arrayOfPays.filter({ $0.countryLib.lowercased().contains(searchtext.lowercased()) })
        }
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedPays) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedPays =  selectedItems
            
            if(self.arrayOfSelectedPays.count > 0)
            {
                let pays_ = self.arrayOfSelectedPays[0]
                
                let preferences = UserDefaults.standard
                let dataPaysParDefaut = NSKeyedArchiver.archivedData(withRootObject: pays_)
                preferences.set(dataPaysParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS)
                
                
                
                
                self.arrayFiltres[1] = pays_.countryLib
               
                //reset zone + groupe + affaire
                self.arrayOfSelectedDR.removeAll()
                self.arrayOfSelectedZone.removeAll()
                self.arrayOfSelectedGroupe.removeAll()
                self.arrayOfSelectedAffaire.removeAll()
                
                preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_DR)
                preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_ZONE)
                preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_GROUPE)
                preferences.set(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE)
                preferences.synchronize()
                
                DispatchQueue.main.async {
                    self.setupDataFiltre()
                    self.filtreCollectionView.reloadData()
                }
            }
            
        }
        
        selectionMenu.uniquePropertyName = "countryId"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: NSLocalizedString("Pays", comment: "-"), action: NSLocalizedString("Select", comment: ""), height: 400), from: self)
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
        
        
        // show searchbar with placeholder and tint color
        selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("Langue", comment: "-"), tintColor: UIColor.lightGray.withAlphaComponent(0.6)) { (searchtext) -> ([Langue]) in
            return self.arrayOfLangues.filter({ $0.libelle.lowercased().contains(searchtext.lowercased()) })
        }
        
        selectionMenu.setSelectedItems(items: arrayOfSelectedLangue) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedLangue =  selectedItems
            
            if(self.arrayOfSelectedLangue.count > 0)
            {
                let langue_ = self.arrayOfSelectedLangue[0]
                let preferences = UserDefaults.standard
                let dataLangueParDefaut = NSKeyedArchiver.archivedData(withRootObject: langue_)
                preferences.set(dataLangueParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE)
                preferences.synchronize()
                
                self.arrayFiltres[0] = langue_.libelle
                DispatchQueue.main.async {
                    self.filtreCollectionView.reloadData()
                    self.syncroniseData(langue: langue_.languageCode)
                }
            }
           
        }
        
        selectionMenu.uniquePropertyName = "languageId"
        
        // auto dismiss
        selectionMenu.dismissAutomatically = true      // default is true
        // show as PresentationStyle = Push
        selectionMenu.show(style: .Actionsheet(title: NSLocalizedString("Langue", comment: "-"), action: NSLocalizedString("Select", comment: ""), height: 400), from: self)
        
    }

}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension FiltreMenuViewController : WSGetDataUtilesDelegate , NVActivityIndicatorViewable{
   
    // ***********************************
    // ***********************************
    // ***********************************
    func syncroniseData(langue : String)
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
            self.startAnimating(size, message: "Récupération des données en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.getDonneesUtiles(delegate: self,langue: langue);
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSGetDataUtiles(error: Bool, data: DataUtilesWSResponse!) {
        
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
            
            
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                let preferences = UserDefaults.standard
                
                // liste des langues
                let dataLangue = NSKeyedArchiver.archivedData(withRootObject: data.dataUtiles.langues)
                preferences.set(dataLangue, forKey: Utils.SHARED_PREFERENCE_LANGUAGES)
                
                var langue_par_defaut : Langue! = nil
                // la langue par défaut
                let langueData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE);
                if(langueData_ != nil){
                    if let langue_ = NSKeyedUnarchiver.unarchiveObject(with: langueData_!)  {
                        
                        let langue = langue_ as! Langue
                        langue_par_defaut = langue
                    }
                }
                
              
                var pays_par_defaut : Pays! = nil
                // Pays par défaut
                let paysData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS);
                if(paysData_ != nil){
                    if let pays_ = NSKeyedUnarchiver.unarchiveObject(with: paysData_!)  {
                        
                        let pays = pays_ as! Pays
                        pays_par_defaut = pays
                    }
                }
                
                 //mettre la langue par défaut dans le perimetre/filtre
                if(langue_par_defaut != nil){
                    for i in (0 ..< data.dataUtiles.langues.count)
                    {
                        let langue = data.dataUtiles.langues[i];
                        if(langue_par_defaut.languageId == langue.languageId)
                        {
                            let dataLangueParDefaut = NSKeyedArchiver.archivedData(withRootObject: langue)
                            preferences.set(dataLangueParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE)
                            
                            break;
                        }
                    }
                }
                
                
                
                //liste des pays perimetre
                let dataPerimetre = NSKeyedArchiver.archivedData(withRootObject: data.dataUtiles.perimetre)
                preferences.set(dataPerimetre, forKey: Utils.SHARED_PREFERENCE_DATA_PERIMETRE)
                
                
                //mettre à jour pays par défaut dans le perimetre/filtre
                if(pays_par_defaut != nil){
                        for i in (0 ..< data.dataUtiles.perimetre.count)
                        {
                            let pays_ = data.dataUtiles.perimetre[i];
                            if(pays_.countryId == pays_par_defaut.countryId)
                            {
                                let dataPaysParDefaut = NSKeyedArchiver.archivedData(withRootObject: pays_)
                                preferences.set(dataPaysParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS)
                                break;
                            }
                        }
                    
                }
                //  Save to disk
                preferences.synchronize()
                
                DispatchQueue.main.async {
                    self.setupDataFiltre()
                }
                
            }else
            {
                DispatchQueue.main.async {
                    let msgErreur = data.description_ + "\n code = " + String(data.code_erreur)
                    let alert = UIAlertController(title: "Erreur", message: msgErreur , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    return;
                }
            }
            
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: "Une erreur est survenue lors de la récupération des données.", preferredStyle: UIAlertController.Style.alert)
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
        return arrayIcones.count ;
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
        
        let pays = arrayOfSelectedPays[0];
        if(!pays.hasDr)//has no dr
        {
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
        }else //has DR
        {
            switch indexPath.row {
                
            case 0:
                selectLangue()
                break;
            case 1:
                selectPays()
                break;
                
            case 2:
                selectDR()
                break;
            case 3:
                selectZone()
                break;
            case 4:
                selectGroupe()
                break;
            case 5:
                selectAffaire()
                break;
                
            default:
                
                return;
                
            }
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
