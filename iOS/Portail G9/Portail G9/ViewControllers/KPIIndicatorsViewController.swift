//
//  KPIIndicatorsViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 15/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class KPIIndicatorsViewController: UIViewController  , NVActivityIndicatorViewable , DateSelectionViewDelegate{
    
    var familleLibelle = "";
    var categorie : Categorie = Categorie();
    var groupe : GroupeKPI = GroupeKPI();
    
    @IBOutlet weak var collectioViewKPI: UICollectionView!
    @IBOutlet weak var gridLayout: StickyGridCollectionViewLayout! {
        didSet {
            gridLayout.stickyRowsCount = 1
            gridLayout.stickyColumnsCount = 1
        }
    }
    
    @IBOutlet weak var labelIndicateur: UILabel!
    
    @IBOutlet weak var labelcategorie: UILabel!
    @IBOutlet weak var iconCategorie: UIImageView!
    
    @IBOutlet weak var labelGroupe: UILabel!
    @IBOutlet weak var iconGroupe: UIImageView!
   
    
    var arrayKPIs : [IndicateurKPISection] = [IndicateurKPISection]();
    var arrayValuesOfCollection : [[IndicateurKPIGrid]] = [[IndicateurKPIGrid]]();
    
    var mSelectedDate : Date = Date();
    @IBOutlet weak var dateButton: UIButton!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("KPI", comment: "-")
        
        // **
        let filtreButton = UIBarButtonItem(image: UIImage(named: "ic_filter_"), style: .plain, target: self, action: #selector(filtreTapped))
        navigationItem.rightBarButtonItems = [filtreButton]
        //**
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateButton.setTitle(formatter.string(from: mSelectedDate), for: .normal)
        
        dateButton.layer.borderColor = #colorLiteral(red: 0.9653237462, green: 0.700186789, blue: 0.1992127001, alpha: 1) ;
        dateButton.layer.borderWidth = 1.5;
        dateButton.layer.cornerRadius = 5.0;
        dateButton.clipsToBounds = true;
        
        setupData()
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func setupData()
    {
        labelIndicateur.text = familleLibelle
        labelcategorie.text = categorie.categoryLibelle
        labelGroupe.text = groupe.groupLibelle
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
        
       
       self.getIndicateursKpisData()
       
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func getIndicateursKpisData()
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
            self.startAnimating(size, message: "Récupération des indicateurs KPI en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.getIndicateurKPIsData(delegate: self, groupe_id:self.groupe.groupId, date: self.mSelectedDate);
        }
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func selectDate(_ sender: Any) {
        
        
        DispatchQueue.main.async {
           self.showDatePicker()
        }
    }
    // *******************************
    // ****
    // *******************************
    func showDatePicker(){
        //Formate Date
        
        let dateSelectionView = DateSelectionView.instanceFromNib();
        dateSelectionView.setupDateSelectionView(delegateS: self, type: DateSelectionView.PICKER_DATE_DAY);
        dateSelectionView.setPickerDate(date: Date());
        self.view.addSubview(dateSelectionView);
        dateSelectionView.center = CGPoint(x:self.view.bounds.size.width/2, y:self.view.bounds.size.height/2);
        dateSelectionView.showView();
        
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func didSelectDate(date: Date, dateAsString: String) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateButton.setTitle(formatter.string(from: date), for: .normal)
        mSelectedDate = date
        
        self.getIndicateursKpisData()
    }
    
}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension KPIIndicatorsViewController : WSGetIndicateursKPIsDelegate {
    
    func didFinishWSGetIndicateursKPIs(error: Bool, data: DataKPIsWSResponse!) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
           
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                 let array_ = KPI.translateKPIColonneToLigne(arrayKPI: data.kpiArray);
                
                arrayKPIs = array_;
                self.arrayValuesOfCollection = KPI.translateIndicateurKPISectionToArrayGrid(arrayKPI: array_)
                
                DispatchQueue.main.async {
                    self.collectioViewKPI.reloadData()
                }
            }
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: "Une erreur est survenue lors de la récupération des indicateurs KPI.", preferredStyle: UIAlertController.Style.alert)
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
extension KPIIndicatorsViewController : UICollectionViewDelegate , UICollectionViewDataSource {
   
    // ***********************************
    // ***********************************
    // ***********************************
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberSection = self.arrayValuesOfCollection.count //arrayKPIs.count;
        return numberSection
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let kpiColonne = self.arrayValuesOfCollection[section] //arrayKPIs[section]
        let numberLigne = kpiColonne.count
        return numberLigne
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let kpi = arrayKPIs[indexPath.section];
        //let kpiColonne = kpi.elementsSection[indexPath.row];
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KPICollectionViewCell", for: indexPath) as! KPICollectionViewCell
        //cell.setupKPICollectionViewCell(kpi: kpiColonne);
        
        cell.setupKPICollectionViewCellGrid(indicateur: self.arrayValuesOfCollection[indexPath.section][indexPath.row])
        
        
        return cell
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            
            let kpi = arrayKPIs[indexPath.section];
            
            sectionHeader.sectionHeaderlabel.text = kpi.titreSection
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    
}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension KPIIndicatorsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 80)
    }
}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class SectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderlabel: UILabel!
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension KPIIndicatorsViewController: FiltreViewDelegate {
    
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
extension KPIIndicatorsViewController: FiltreMenuViewControllerDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltreMenuViewController() {
        
        self.dismiss(animated: true, completion: nil)
        self.getIndicateursKpisData()
    }
    
    
}
