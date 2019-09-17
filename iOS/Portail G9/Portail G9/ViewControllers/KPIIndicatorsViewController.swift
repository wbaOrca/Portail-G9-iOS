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
    
    @IBOutlet weak var buttonIndicateur: UIButton!
    
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = NSLocalizedString("KPI", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        
        // **
        let filtreButton = UIBarButtonItem(image: UIImage(named: "ic_filter_"), style: .plain, target: self, action: #selector(filtreTapped))
        navigationItem.rightBarButtonItems = [filtreButton]
        //**
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateButton.setTitle(formatter.string(from: mSelectedDate), for: .normal)
        
        setupData()
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(animated)
        {
            self.getIndicateursKpisData()
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func returnToIndicator(_ sender: Any) {
        
        let vcCategorie = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 4];
        self.navigationController?.popToViewController(vcCategorie!, animated: true);
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func returnToGroupe(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func returnToCategorie(_ sender: Any) {
        
        let vcCategorie = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3];
        self.navigationController?.popToViewController(vcCategorie!, animated: true);
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func setupData()
    {
        buttonIndicateur.setTitle(familleLibelle, for: .normal)
        
        labelcategorie.text = categorie.categoryLibelle
        if(categorie.categoryIcone.count > 0)
        {
            let urlImageAsString = Version.URL_PREFIX_IMAGES_PORTAIL_G9 + categorie.categoryIcone
            iconCategorie.sd_setImage(with: URL(string: urlImageAsString), placeholderImage: UIImage(named: "ic_menu"))
        }else
        {
            iconCategorie.image = nil
        }
        
        labelGroupe.text = groupe.groupLibelle
        if(groupe.groupIcon.count > 0)
        {
            let urlImageAsString = Version.URL_PREFIX_IMAGES_PORTAIL_G9 + groupe.groupIcon
            iconGroupe.sd_setImage(with: URL(string: urlImageAsString), placeholderImage: UIImage(named: "ic_groupe"))
        }else
        {
            iconGroupe.image = nil
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
    func getIndicateursKpisData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: NSLocalizedString("no_internet_connexion", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
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
        dateSelectionView.setPickerDate(date: mSelectedDate);
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
                
                if(data.lastDate.count > 0 && data.requstedDate.count > 0)
                {
                     if(data.requstedDate == data.lastDate)
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
                let alert = UIAlertController(title: "Erreur", message: NSLocalizedString("erreur_survenue_request", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
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
    
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(indexPath.section == 0 || indexPath.row == 0)
        {
            let indicateur = self.arrayValuesOfCollection[indexPath.section][indexPath.row]
            DispatchQueue.main.async {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                let alert = UIAlertController(title: NSLocalizedString("KPI", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-"), message: indicateur.indicateurKPI.valeur, preferredStyle: UIAlertController.Style.alert)
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
    func dismissFiltreMenuViewController(isLangueChanged : Bool) {
        
        if(!isLangueChanged)
        {
            self.dismiss(animated: true, completion: nil)
            self.getIndicateursKpisData()
        }else
        {
            self.dismiss(animated: false, completion: nil)
            self.returnToIndicator(buttonIndicateur)
        }
    }
    
    
}
