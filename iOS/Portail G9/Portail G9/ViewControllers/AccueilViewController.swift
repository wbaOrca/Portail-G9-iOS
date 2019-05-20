//
//  AccueilViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 20/05/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class AccueilViewController: UIViewController  , NVActivityIndicatorViewable{

    var isSynchronisedData = false;
    
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var labelVersion: UILabel!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Home", comment: "-")
        
        // **
        let appInfo = Bundle.main.infoDictionary! as Dictionary<String,AnyObject>
        let shortVersionString = appInfo["CFBundleShortVersionString"] as! String
        let bundleVersion      = appInfo["CFBundleVersion"] as! String
        let applicationVersion = shortVersionString + "." + bundleVersion
        labelVersion.text =  Version.VERSION + " " + applicationVersion
        
        //**
        let preferences = UserDefaults.standard
        let userData = preferences.data(forKey: Utils.SHARED_PREFERENCE_USER);
        if let user_ = NSKeyedUnarchiver.unarchiveObject(with: userData!)  {
            
            let user = user_ as! Utilisateur
            let userAsString = user.user_prenom + " " + user.user_nom
            
            let attributedText = NSMutableAttributedString(string: NSLocalizedString("Hello", comment: "-"), attributes: [NSAttributedString.Key.font: UIFont.init(name: "ArialMT", size: 17)!])
            attributedText.append(NSAttributedString(string: ("\n" + userAsString), attributes: [NSAttributedString.Key.font: UIFont.init(name: "Arial-BoldMT", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor.black]))
            
            labelWelcome.attributedText = attributedText
            //labelWelcome.text = NSLocalizedString("Hello", comment: "-") + " " + userAsString
        }
        
        //**
         let filtreButton = UIBarButtonItem(image: UIImage(named: "ic_filter_"), style: .plain, target: self, action: #selector(filtreTapped))
         navigationItem.rightBarButtonItems = [filtreButton]
        //**
        if let layout = menuCollectionView?.collectionViewLayout as? MenuLayout {
            layout.delegate = self
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
    
    // *******************************************************************************
    // ******
    // ****** viewWillAppear
    // ******
    // *******************************************************************************
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        
    }
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(!isSynchronisedData)
        {
            self.syncroniseData()
        }
    }

    
    // ***********************************
    // ***********************************
    // ***********************************
    func syncroniseData()
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
            WSQueries.getDonneesUtiles(delegate: self,langue: nil);
        }
    }
   
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func voirCategorieFamille(familleId: Int ) {
       
        
        
        let listeCategoriesVC = self.storyboard?.instantiateViewController(withIdentifier: "ListeCategoriesViewController") as? ListeCategoriesViewController
        listeCategoriesVC?.familleId = familleId
        self.navigationController?.pushViewController(listeCategoriesVC!, animated: true);
            
        
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func voirProcess(processId: Int) {
        
    
    
    
            if(processId == 1)//radar
            {
                let processRadarVC = self.storyboard?.instantiateViewController(withIdentifier: "ProcessRadarViewController") as? ProcessRadarViewController
                self.navigationController?.pushViewController(processRadarVC!, animated: true);
            }else //Piliers
            {
                let piliersProcessVC = self.storyboard?.instantiateViewController(withIdentifier: "PiliersProcessViewController") as? PiliersProcessViewController
                self.navigationController?.pushViewController(piliersProcessVC!, animated: true);
            }
            
    
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func voirPlanAction(planAActionId: Int) {
        
      
            
            if(planAActionId == 1)//Plan d'action Zone
            {
                
            }
            else if(planAActionId == 2) //Synthese Plan d'actions
            {
                /*
                 let boardCollectionVC = self.storyboard?.instantiateViewController(withIdentifier: "BoardCollectionViewController") as? BoardCollectionViewController
                 self.navigationController?.pushViewController(boardCollectionVC!, animated: true);
                 */
            }
        
        
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func voirForceTerrainAction(planAActionId: Int) {
        
       
            if(planAActionId == 1)//Agenda
            {
                
            }
            else if(planAActionId == 2) //ToDO List
            {
                let boardCollectionVC = self.storyboard?.instantiateViewController(withIdentifier: "BoardCollectionViewController") as? BoardCollectionViewController
                self.navigationController?.pushViewController(boardCollectionVC!, animated: true);
            }
            else if(planAActionId == 3) //Relevé de décisions
            {
                
            }
        
        
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func voirProfil() {
        
        let accountVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
        self.navigationController?.pushViewController(accountVC!, animated: true);
        
    }

}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension AccueilViewController: WSGetDataUtilesDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSGetDataUtiles(error: Bool, data: DataUtilesWSResponse!) {
        
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
            isSynchronisedData = true;
            
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                let preferences = UserDefaults.standard
                
                // liste des langues
                let dataLangue = NSKeyedArchiver.archivedData(withRootObject: data.dataUtiles.langues)
                preferences.set(dataLangue, forKey: Utils.SHARED_PREFERENCE_LANGUAGES)
                
                
                //mettre la langue par défaut dans le perimetre/filtre
                if(preferences.object(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE) == nil)
                {
                    //mettre la langue par défaut dans le perimetre/filtre
                    let userData = preferences.data(forKey: Utils.SHARED_PREFERENCE_USER);
                    if let user_ = NSKeyedUnarchiver.unarchiveObject(with: userData!)  {
                        
                        let user = user_ as! Utilisateur
                        let langue_preferee = user.preferred_lang
                        
                        for i in (0 ..< data.dataUtiles.langues.count)
                        {
                            let langue = data.dataUtiles.langues[i];
                            if(langue_preferee.contains(langue.languageCode))
                            {
                                let dataLangueParDefaut = NSKeyedArchiver.archivedData(withRootObject: langue)
                                preferences.set(dataLangueParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE)
                                
                                break;
                            }
                        }
                        
                    }
                }
                
                //liste des pays perimetre
                let dataPerimetre = NSKeyedArchiver.archivedData(withRootObject: data.dataUtiles.perimetre)
                preferences.set(dataPerimetre, forKey: Utils.SHARED_PREFERENCE_DATA_PERIMETRE)
                
                //mettre le 1er pays par défaut dans le perimetre/filtre
                if(preferences.object(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS) == nil)
                {
                    if(data.dataUtiles.perimetre.count > 0)
                    {
                        let pays_ = data.dataUtiles.perimetre[0];
                        let dataPaysParDefaut = NSKeyedArchiver.archivedData(withRootObject: pays_)
                        preferences.set(dataPaysParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS)
                    }
                }
                //  Save to disk
                preferences.synchronize()
                
                DispatchQueue.main.async {
                    //self.filtreView.setupFiltreView()
                    
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
extension AccueilViewController: FiltreMenuViewControllerDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltreMenuViewController() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension AccueilViewController : FiltreViewDelegate {
    
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
extension AccueilViewController : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 4 ;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
    
    var titre = ""
    var imageName = ""
    var startColor = #colorLiteral(red: 0.8759868741, green: 0.6076459885, blue: 0.2134960294, alpha: 1)
    var endColor = #colorLiteral(red: 0.8759868741, green: 0.6076459885, blue: 0.2134960294, alpha: 1)
    var isWithHeader = false
    cell.setupBadge(badge: 0)
    
    switch indexPath.row {
    case 0:
    titre = "Mes indicateurs"
    imageName = "ic_indicators"
    startColor = #colorLiteral(red: 0.006074097939, green: 0.8343702555, blue: 0.9111683369, alpha: 1)
    endColor = #colorLiteral(red: 0.009602962062, green: 0.4145860076, blue: 0.7674347758, alpha: 1)
    isWithHeader = true
    break;
    case 1:
    titre = "Mes Piliers"
    imageName = "ic_piliers"
    startColor = #colorLiteral(red: 0.2033514082, green: 0.880492866, blue: 0.5453835726, alpha: 1)
    endColor = #colorLiteral(red: 0.006226446945, green: 0.5498411059, blue: 0.2813285887, alpha: 1)
    break;
    case 2:
    titre = "To Do List"
    imageName = "ic_to_do_list"
    startColor = #colorLiteral(red: 0.978838861, green: 0.7723264694, blue: 0.1155577376, alpha: 1)
    endColor = #colorLiteral(red: 0.9790682197, green: 0.4539143443, blue: 0, alpha: 1)
    break;
    case 3:
    titre = "A venir"
    imageName = "ic_params"
    startColor = #colorLiteral(red: 0.8839395642, green: 0.3652255535, blue: 0.9999932647, alpha: 1)
    endColor = #colorLiteral(red: 0.6110240817, green: 0.2012693286, blue: 0.9319364429, alpha: 1)
    cell.setupBadge(badge: 6)
    break;
    default:
    break;
    }
    
    cell.setupCell(startColor: startColor ,endtColor: endColor , isHeaderVisible : isWithHeader);
    
    cell.labelTitre.text = titre
    
    cell.imageBackground.image = UIImage(named: imageName)
    cell.imageBackground.backgroundColor = .clear
    cell.backgroundColor = .clear
    
    return cell
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
        self.voirCategorieFamille(familleId: 1)
        break;
    
    case 1:
        self.voirProcess(processId: 2)
        break;
    
    case 2:
        self.voirForceTerrainAction(planAActionId: 2)
        break;
    
    case 3:
    
    break;
    
    default:
    break;
    }
    }
}

// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
extension AccueilViewController: MenuLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForItemAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        if(indexPath.row == 0)
        {
            
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    return 220.0
                case 1334:
                    //"iPhone 6/6S/7/8"
                    return 240;
                case 2208:
                    //print("iPhone 6+/6S+/7+/8+")
                    return 250;
                case 2436:
                    //print("iPhone X")
                    return 250;
                    
                default:
                    //print("unknown")
                    return 240;
                    
                }
                
                
                
            }else
            {
                return 300 ;
            }
            
            
        }else
        {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    return 190.0
                case 1334:
                    //"iPhone 6/6S/7/8"
                    return 210;
                case 2208:
                    //print("iPhone 6+/6S+/7+/8+")
                    return 220;
                case 2436:
                    //print("iPhone X")
                    return 220;
                    
                default:
                    //print("unknown")
                    return 210;
                    
                }
                
                
                
            }else
            {
                return 270 ;
            }
        }
        
        
        
    }
}
