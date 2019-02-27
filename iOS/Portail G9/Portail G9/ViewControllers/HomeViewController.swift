//
//  HomeViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 29/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView
import SDWebImage
import SideMenu
import ABGaugeViewKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class HomeViewController: UIViewController , NVActivityIndicatorViewable{

    
    var isSynchronisedData = false;
    
    @IBOutlet weak var filtreView : FiltreView!
    @IBOutlet weak var labelWelcome: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gaugeView1: ABGaugeView!
    @IBOutlet weak var gaugeView2: ABGaugeView!
    @IBOutlet weak var gaugeView3: ABGaugeView!
    @IBOutlet weak var gaugeView4: ABGaugeView!
    
    var labelRadar1: UILabel!
    var labelRadar2: UILabel!
    var labelRadar3: UILabel!
    var labelRadar4: UILabel!
    
    var imageViewRadar1: UIImageView!
    var imageViewRadar2: UIImageView!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Home", comment: "-")
        
        filtreView.delegate = self
        
        let preferences = UserDefaults.standard
        let userData = preferences.data(forKey: Utils.SHARED_PREFERENCE_USER);
        if let user_ = NSKeyedUnarchiver.unarchiveObject(with: userData!)  {
            
            let user = user_ as! Utilisateur
            
            let userAsString = user.user_prenom + " " + user.user_nom
            
            labelWelcome.text = NSLocalizedString("Hello", comment: "-") + " " + userAsString
        }
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "ic_menu_"), style: .plain, target: self, action: #selector(menuTapped))
        navigationItem.leftBarButtonItems = [menuButton]
        
        /*
        let filtreButton = UIBarButtonItem(image: UIImage(named: "ic_filter_"), style: .plain, target: self, action: #selector(filtreTapped))
        navigationItem.rightBarButtonItems = [filtreButton]
        */
        
        //scroll view content
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
        
        //solid gauge
        gaugeView1.areas = "100,0,0,0,0"
        gaugeView1.colorCodes = "f2f2f2,00b359,FFFFFF,FFFFFF,FFFFFF"
        gaugeView1.needleValue = 0;
        labelRadar1 = UILabel(frame: CGRect(x: 0, y: ( gaugeView1.frame.origin.y + 163 ), width: view.frame.size.width, height: 40))
        labelRadar1.textAlignment = .center //For center alignment
        labelRadar1.text = ""
        labelRadar1.textColor = .black
        labelRadar1.backgroundColor = .white//If required
        labelRadar1.font = UIFont.systemFont(ofSize: 11)
        labelRadar1.numberOfLines = 0
        labelRadar1.lineBreakMode = .byWordWrapping
        scrollView.addSubview(labelRadar1)
        imageViewRadar1 = UIImageView(frame: CGRect(x: labelRadar1.frame.width - 70 , y: 0, width: 35, height: 35))
        labelRadar1.addSubview(imageViewRadar1)
        scrollView.bringSubviewToFront(labelRadar1)
        
        gaugeView2.areas = "100,0,0,0,0"
        gaugeView2.colorCodes = "f2f2f2,00b359,FFFFFF,FFFFFF,FFFFFF"
        gaugeView2.needleValue = 0;
        labelRadar2 = UILabel(frame: CGRect(x: 0, y: ( gaugeView2.frame.origin.y + 163 ), width: view.frame.size.width, height: 40))
        labelRadar2.textAlignment = .center //For center alignment
        labelRadar2.text = ""
        labelRadar2.textColor = .black
        labelRadar2.backgroundColor = .white//If required
        labelRadar2.font = UIFont.systemFont(ofSize: 11)
        labelRadar2.numberOfLines = 0
        labelRadar2.lineBreakMode = .byWordWrapping
        scrollView.addSubview(labelRadar2)
        imageViewRadar2 = UIImageView(frame: CGRect(x: labelRadar2.frame.width - 70 , y: 0, width: 35, height: 35))
        labelRadar2.addSubview(imageViewRadar2)
        scrollView.bringSubviewToFront(labelRadar2)
        
        gaugeView3.areas = "100,0,0,0,0"
        gaugeView3.colorCodes = "f2f2f2,00b359,FFFFFF,FFFFFF,FFFFFF"
        gaugeView3.needleValue = 0;
        labelRadar3 = UILabel(frame: CGRect(x: 0, y: ( gaugeView3.frame.origin.y + 163 ), width: view.frame.size.width, height: 40))
        labelRadar3.textAlignment = .center //For center alignment
        labelRadar3.text = ""
        labelRadar3.textColor = .black
        labelRadar3.backgroundColor = .white//If required
        labelRadar3.font = UIFont.systemFont(ofSize: 11)
        labelRadar3.numberOfLines = 0
        labelRadar3.lineBreakMode = .byWordWrapping
        scrollView.addSubview(labelRadar3)
        scrollView.bringSubviewToFront(labelRadar3)
        
        gaugeView4.areas = "100,0,0,0,0"
        gaugeView4.colorCodes = "f2f2f2,00b359,FFFFFF,FFFFFF,FFFFFF"
        gaugeView4.needleValue = 0;
        labelRadar4 = UILabel(frame: CGRect(x: 0, y: ( gaugeView4.frame.origin.y + 163 ), width: view.frame.size.width, height: 40))
        labelRadar4.textAlignment = .center //For center alignment
        labelRadar4.text = ""
        labelRadar4.textColor = .black
        labelRadar4.backgroundColor = .white//If required
        labelRadar4.font = UIFont.systemFont(ofSize: 11)
        labelRadar4.numberOfLines = 0
        labelRadar4.lineBreakMode = .byWordWrapping
        scrollView.addSubview(labelRadar4)
        scrollView.bringSubviewToFront(labelRadar4)
        
        
        
        //notifications from lef Menu
        //notifications from lef Menu
        NotificationCenter.default.addObserver(self, selector: #selector(self.voirCategorieFamille_), name: NSNotification.Name(rawValue: "#voirCategorieFamille"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.voirProcess), name: NSNotification.Name(rawValue: "#voirProcess"), object: nil)
        
        //notifications from lef Menu
        NotificationCenter.default.addObserver(self, selector: #selector(self.voirPlanAction), name: NSNotification.Name(rawValue: "#voirPlanAction"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.disconnectUser_), name: NSNotification.Name(rawValue: "#DisconnectUser"), object: nil)
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
        
        // filtreView
        filtreView.setupFiltreView()
        
        if(!isSynchronisedData)
        {
            self.syncroniseData()
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @objc func voirCategorieFamille_(notif: NSNotification) {
        
        self.dismiss(animated: false, completion: nil)
        
        if let familleId = notif.object as? Int {
          
            let listeCategoriesVC = self.storyboard?.instantiateViewController(withIdentifier: "ListeCategoriesViewController") as? ListeCategoriesViewController
            listeCategoriesVC?.familleId = familleId
            self.navigationController?.pushViewController(listeCategoriesVC!, animated: true);
            
        }
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @objc func voirProcess(notif: NSNotification) {
        
        self.dismiss(animated: false, completion: nil)
        
        if let processId = notif.object as? Int {
            if(processId == 1)//radar
            {
                
            }else //Piliers
            {
                
            }
            
        }
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @objc func voirPlanAction(notif: NSNotification) {
        
        self.dismiss(animated: false, completion: nil)
        
        if let planAActionId = notif.object as? Int {
            
            if(planAActionId == 1)//Plan d'action Zone
            {
                
            }
            else if(planAActionId == 2) //Synthese Plan d'actions
            {
                let boardCollectionVC = self.storyboard?.instantiateViewController(withIdentifier: "BoardCollectionViewController") as? BoardCollectionViewController
                self.navigationController?.pushViewController(boardCollectionVC!, animated: true);
            }
        }
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @objc func disconnectUser_(notif: NSNotification) {
        self.dismiss(animated: false, completion: nil)
        Utils.disconnectUser(goBackAnimated: true);
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
    @objc func menuTapped()
    {
        let leftMenuVC = self.storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! UISideMenuNavigationController
        self.present(leftMenuVC, animated: true, completion: nil)
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
    func getStatistiqueData()
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
            
            WSQueries.getRadarsData(delegate: self);
        }
    }
    
    
    
    
    
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupRadar(radars : DataRadar!)
    {
        if(radars != nil)
        {
           //radar 1
            if(radars.orderRenaultData < 0){
                gaugeView1.needleValue = 0
            }else if(radars.orderRenaultData > 100){
                gaugeView1.needleValue = 100
            } else{
                 gaugeView1.needleValue = CGFloat(radars.orderRenaultData);
            }
            let delimeterAbs1 = Int(abs(radars.orderRenaultDelimiter))
            let CenntAbs1 = 100 - delimeterAbs1
            gaugeView1.areas = String(delimeterAbs1) + "," + String(CenntAbs1) + ",0,0,0"
            let title_ = radars.orderRenaultLibelle + "\n" + String(radars.orderRenaultData) + "%"
            labelRadar1.text = title_;
            let url = URL(string: radars.orderRenaultIcone)
            imageViewRadar1.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            
            
            
            //radar 2
            if(radars.orderDaciaData < 0){
                gaugeView2.needleValue = 0;
            }else if(radars.orderDaciaData > 100){
                gaugeView2.needleValue = 100;
            }else{
                gaugeView2.needleValue = CGFloat(radars.orderDaciaData);
            }
            let delimeterAbs2 = Int(abs(radars.orderDaciaDelimiter))
            let CenntAbs2 = 100 - delimeterAbs2
            gaugeView2.areas = String(delimeterAbs2) + "," + String(CenntAbs2) + ",0,0,0"
            labelRadar2.text = radars.orderDaciaLibelle + "\n" + String(radars.orderDaciaData) + "%"
            let url_2 = URL(string: radars.orderDaciaIcone)
            imageViewRadar2.sd_setImage(with: url_2, placeholderImage: UIImage(named: "placeholder.png"))
            
            //radar 3
            if(radars.workshopPEData < 0){
                gaugeView3.needleValue = 0;
            }else if(radars.workshopPEData > 100){
                gaugeView3.needleValue = 100;
            }else{
                gaugeView3.needleValue = CGFloat(radars.workshopPEData);
            }
            let delimeterAbs3 = Int(abs(radars.workshopPEDelimiter))
            let CenntAbs3 = 100 - delimeterAbs3
            gaugeView3.areas = String(delimeterAbs3) + "," + String(CenntAbs3) + ",0,0,0"
            labelRadar3.text = radars.workshoptLibelle + "\n" + String(radars.workshopPEData) + "%"
            
            //radar 4
            if(radars.spSellInData < 0){
                gaugeView4.needleValue = 0;
            }else if(radars.spSellInData > 100){
                gaugeView4.needleValue = 100;
            }else{
               gaugeView4.needleValue = CGFloat(radars.spSellInData);
            }
            
            let delimeterAbs4 = Int(abs(radars.spSellInEDelimiter))
            let CenntAbs4 = 100 - delimeterAbs4
            gaugeView4.areas = String(delimeterAbs4) + "," + String(CenntAbs4) + ",0,0,0"
            labelRadar4.text = radars.spSellInLibelle + "\n" + String(radars.spSellInData) + "%"
        }
    }

    
    
    

}
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension HomeViewController: WSGetDataUtilesDelegate {
    
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
                    self.filtreView.setupFiltreView()
                    self.getStatistiqueData()
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
extension HomeViewController: WSGetDonneesRadarsDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func didFinishWSGetDonneesRadars(error: Bool, data: DataRadarWSResponse!) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
           
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                DispatchQueue.main.async {
                    self.setupRadar(radars: data.dataRadar)
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
extension HomeViewController: FiltreMenuViewControllerDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func dismissFiltreMenuViewController() {
        
        self.dismiss(animated: true, completion: nil)
        self.getStatistiqueData()
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension HomeViewController: FiltreViewDelegate {
    
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
