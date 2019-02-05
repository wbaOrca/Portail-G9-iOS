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
    var arrayFiltres : [String] = ["Français", "Suisse","Zone 1", "-" , "Affaire 1"];
    var arrayIcones : [String] = ["ic_langue","ic_pays","ic_zone","ic_groupe","ic_affaire"];
    
    
    var arrayOfLangues : [String] = ["Français","Anglais","Polonais","Allemand", "Italien"];
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func selectOk(_ sender: Any) {
        
        dismissFiltre()
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltre() {
        super.viewDidLoad()
       
        self.delegate.dismissFiltreMenuViewController()
    }
    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectGroupe() {
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectAffaire() {
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectZone() {
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectPays() {
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func selectLangue() {
        
        
        if(arrayOfLangues.count == 0)
        {
            let alertController = UIAlertController(title: "Erreur", message: "Aucune Langue.", preferredStyle: .alert)
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
            cell.textLabel?.text = object
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
        
        
        // set default selected items when menu present on screen.
        // Here you'll get onDidSelectRow
        /*
        selectionMenu.setSelectedItems(items: arrayOfSelectedTypeDocument as! [DocumentType]) { (text, isSelected, selectedItems) in
            
            // update your existing array with updated selected items, so when menu presents second time updated items will be default selected.
            self.arrayOfSelectedTypeDocument = NSMutableArray(array: selectedItems)
            
            if(self.arrayOfSelectedTypeDocument.count > 0)
            {
                let typeDoc = self.arrayOfSelectedTypeDocument[0] as! DocumentType
                self.currentTypeDocument = typeDoc;
                self.buttonTypeDocument.setTitle(typeDoc.libelle_court, for: .normal)
                
            }
        }
        */
        selectionMenu.uniquePropertyName = "id"
        
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
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
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
