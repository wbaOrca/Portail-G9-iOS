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
import SDWebImage
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class AccueilViewController: UIViewController  , NVActivityIndicatorViewable{

    
    var isSynchronisedData = false;
    
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var labelVersion: UILabel!
    @IBOutlet weak var btnUpgradeVersion: UIButton?
    var url_upgrade = Version.URL_INSTALL_PORTAIL_G9
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var buttonAccount: UIButton!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreenData()
        
        buttonAccount.layer.cornerRadius = buttonAccount.frame.width / 2
        buttonAccount.clipsToBounds = true
        
        // **
        let appInfo = Bundle.main.infoDictionary! as Dictionary<String,AnyObject>
        let shortVersionString = appInfo["CFBundleShortVersionString"] as! String
        let bundleVersion      = appInfo["CFBundleVersion"] as! String
        let applicationVersion = shortVersionString + "." + bundleVersion
        labelVersion.text =  "        " + Version.VERSION + " " + applicationVersion 
        
        
        
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
        
        if(self.btnUpgradeVersion?.isHidden == false)//need update application
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let okText = NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
            
            let erreurText = NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
            
            let alertText = NSLocalizedString("need_update", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
            
            let alert = UIAlertController(title: erreurText, message: alertText, preferredStyle: UIAlertController.Style.alert);
            //show it
            alert.addAction(UIAlertAction(title: okText, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                
            }));
            
            self.present(alert, animated: false, completion: nil);
            return
        }

        let filtreVC = self.storyboard?.instantiateViewController(withIdentifier: "FiltreMenuViewController") as? FiltreMenuViewController
        filtreVC?.delegate = self
        self.present(filtreVC!, animated: true, completion: nil)
        
        
    }
    // *******************************************************************************
    // ******
    // ****** setupScreenData
    // ******
    // *******************************************************************************
    func setupScreenData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Home", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
        
        //**
        let preferences = UserDefaults.standard
        let userData = preferences.data(forKey: Utils.SHARED_PREFERENCE_USER);
        if let user_ = NSKeyedUnarchiver.unarchiveObject(with: userData!)  {
            
            let user = user_ as! Utilisateur
            let userAsString = user.user_prenom + " " + user.user_nom
            
            let attributedText = NSMutableAttributedString(string: NSLocalizedString("Hello", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-"), attributes: [NSAttributedString.Key.font: UIFont.init(name: "Arial-BoldMT", size: 19)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9991517663, green: 0.8007791638, blue: 0.198880434, alpha: 1)])
            attributedText.append(NSAttributedString(string: ("\n" + userAsString), attributes: [NSAttributedString.Key.font: UIFont.init(name: "Arial-BoldMT", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]))
            
            labelWelcome.attributedText = attributedText
            //labelWelcome.text = NSLocalizedString("Hello", comment: "-") + " " + userAsString
        }
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
        
        setupScreenData()
        
        // Version
        let reachability = Reachability()!
        if (reachability.connection != .none )
        {
            WSQueries.getVersionApplication(delegate: self);
        }
        
        // Data
        if(!isSynchronisedData)
        {
            self.syncroniseData()
        }else
        {
            menuCollectionView.reloadData()
        }
        
        
    }

    
    // ***********************************
    // ***********************************
    // ***********************************
    func syncroniseData()
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
            WSQueries.getDonneesUtiles(delegate: self,langue: nil);
        }
    }
   
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func voirCategorieFamille(familleId: Int ) {
        
        let listIndicateurVC = self.storyboard?.instantiateViewController(withIdentifier: "ListeIndicateursViewController") as? ListeIndicateursViewController
        self.navigationController?.pushViewController(listIndicateurVC!, animated: true);
        
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
        
        //feature in the soon future
        self.fonctionnaliteNonDisponible()
        return
        
        if(planAActionId == 1)//Agenda
        {
            let agendaVC = self.storyboard?.instantiateViewController(withIdentifier: "AgendaViewController") as? AgendaViewController
            self.navigationController?.pushViewController(agendaVC!, animated: true);
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
extension AccueilViewController: WSGetVersionDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSGetVersion(error: Bool, version: String!, url_download: String!) {
        
        if(!error)
        {
            
            if(url_download != nil)
            {
                self.url_upgrade = url_download
            }
            
            DispatchQueue.main.async {
                let gAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "0"
                let gAppBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? "0"
                let currentVersion = (gAppVersion as! String) + "." + (gAppBuild as! String) ;
                
                if(currentVersion == version)
                {
                    self.btnUpgradeVersion?.isHidden = true;
                }else
                {
                    self.btnUpgradeVersion?.isHidden = false;
                }
            }
        }else
        {
            self.btnUpgradeVersion?.isHidden = true;
        }
        
    }
    
    
    // *******************************
    // *******************************
    // **** upgradeVersion
    // *******************************
    // *******************************
    @IBAction func upgradeVersion (_ sender: UIButton!) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let maj_text = NSLocalizedString("MAJ_Application", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        let maj_question = NSLocalizedString("MAJ_Question", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        let ouiText = NSLocalizedString("OUI", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        let nonText = NSLocalizedString("NON", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-")
        
        let alert = UIAlertController(title: maj_text, message: maj_question, preferredStyle: UIAlertController.Style.alert);
        //show it
        alert.addAction(UIAlertAction(title: ouiText, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            if let url = URL(string: self.url_upgrade) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                    let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        //exit(0)
                        UIControl().sendAction(#selector(NSXPCConnection.suspend),
                                               to: UIApplication.shared, for: nil)
                    }
                    
                } else {
                    // Fallback on earlier versions
                }
            }
        }));
        alert.addAction(UIAlertAction(title: nonText , style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            
        }));
        
        self.present(alert, animated: false, completion: nil);
        
        
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
                    DispatchQueue.main.async {
                        self.menuCollectionView.reloadData()
                    }
                }
                
                //liste des pays perimetre
                let dataPerimetre = NSKeyedArchiver.archivedData(withRootObject: data.dataUtiles.perimetre)
                preferences.set(dataPerimetre, forKey: Utils.SHARED_PREFERENCE_DATA_PERIMETRE)
                
                //mettre le 1er pays par défaut dans le perimetre/filtre
                if(preferences.object(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS) == nil)
                {
                    if(data.dataUtiles.perimetre.pays.count > 0)
                    {
                        let pays_ = data.dataUtiles.perimetre.pays[0];
                        let dataPaysParDefaut = NSKeyedArchiver.archivedData(withRootObject: pays_)
                        preferences.set(dataPaysParDefaut, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS)
                    }else
                    {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        DispatchQueue.main.async {
                            
                            let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "") , message: NSLocalizedString("error_user_country", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                            return;
                        }
                    }
                }
                //  Save to disk
                preferences.synchronize()
                
                DispatchQueue.main.async {
                    //self.filtreView.setupFiltreView()
                    
                }
                
            }else
            {
                 let appDelegate = UIApplication.shared.delegate as! AppDelegate
                DispatchQueue.main.async {
                    let msgErreur = data.description_ + "\n code = " + String(data.code_erreur)
                    let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "") , message: msgErreur , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    return;
                }
            }
            
        }else
        {
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "") , message: NSLocalizedString("erreur_survenue_request", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: ""), style: UIAlertAction.Style.default, handler: nil))
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
    func dismissFiltreMenuViewController(isLangueChanged : Bool) {
        
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
    
    return 2 ; //4
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        var titre = ""
        var imageName = ""
        var imageHighlight = ""
        
        cell.setupBadge(badge: 0)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        switch indexPath.row {
        case 0:
            titre = NSLocalizedString("Indicateurs", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "") //"Mes indicateurs"
            imageName = "ic_indicators"
            imageHighlight = "ic_indicators_highlighted"
            break;
            
        case 1:
            titre = NSLocalizedString("Mes_Piliers", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")//"Mes Piliers"
            imageName = "ic_piliers"
            imageHighlight = "ic_piliers_hilighted"
            
            break;
            
        case 2:
            titre = NSLocalizedString("Todo_list", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")//"To Do List"
            imageName = "ic_to_do_list"
            imageHighlight = "ic_to_do_list_highlighted"
            break;
            
        case 3:
            titre = NSLocalizedString("Agenda", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "") //"Agenda"
            imageName = "ic_agenda"
            imageHighlight = "ic_agenda_highlighted"
            
            
            
            break;
        default:
            break;
        }
        
        
        cell.setupCell_2(icon_image: imageName,icon_highlight: imageHighlight,titre: titre)
        cell.backgroundColor = .clear
        
        return cell
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if(self.btnUpgradeVersion?.isHidden == false)//need update application
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let okText = NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
            let erreurText = NSLocalizedString("Erreur", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
            let alertText = NSLocalizedString("need_update", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
            
            let alert = UIAlertController(title: erreurText, message: alertText, preferredStyle: UIAlertController.Style.alert);
            //show it
            alert.addAction(UIAlertAction(title: okText, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                
            }));
            
            self.present(alert, animated: false, completion: nil);
            return
        }
        
        
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
            self.voirForceTerrainAction(planAActionId: 1)
            break;
            break;
            
        default:
            break;
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func fonctionnaliteNonDisponible()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let okText = NSLocalizedString("Ok", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
        let erreurText = NSLocalizedString("G9", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "G9", comment: "G9")
        let alertText = NSLocalizedString("fonctionnalite_non_disponible", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "")
        
        let alert = UIAlertController(title: erreurText, message: alertText, preferredStyle: UIAlertController.Style.alert);
        //show it
        alert.addAction(UIAlertAction(title: okText, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            
        }));
        
        self.present(alert, animated: false, completion: nil);
        return
    }
    
}

// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
extension AccueilViewController: MenuLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForItemAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        
            
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    return 120;
                case 1334:
                    //"iPhone 6/6S/7/8"
                    return 120;
                case 2208:
                    //print("iPhone 6+/6S+/7+/8+")
                    return 120;
                case 2436:
                    //print("iPhone X")
                    return 120;
                    
                default:
                    //print("unknown")
                    return 120;
                    
                }
                
                
            }else
            {
                return 250 ;
            }
            
        
    }
}
