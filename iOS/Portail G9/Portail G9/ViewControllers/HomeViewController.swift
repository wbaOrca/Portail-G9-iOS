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
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Home", comment: "-")
        
        
        let preferences = UserDefaults.standard
        let userData = preferences.data(forKey: Utils.SHARED_PREFERENCE_USER);
        if let user_ = NSKeyedUnarchiver.unarchiveObject(with: userData!)  {
            
            let user = user_ as! Utilisateur
            
            let userAsString = user.user_prenom + " " + user.user_nom
            
            labelWelcome.text = NSLocalizedString("Hello", comment: "-") + " " + userAsString
        }
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "ic_menu_"), style: .plain, target: self, action: #selector(menuTapped))
        navigationItem.leftBarButtonItems = [menuButton]
        
        let filtreButton = UIBarButtonItem(image: UIImage(named: "ic_filter_"), style: .plain, target: self, action: #selector(filtreTapped))
        navigationItem.rightBarButtonItems = [filtreButton]
        
        //scroll view content
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
        
        //solid gauge
        gaugeView1.areas = "60,40,0,0,0"
        gaugeView1.colorCodes = "00b359,ccffe6,FFFFFF,FFFFFF,FFFFFF"
        gaugeView1.needleValue = 33;
        let lbl1 = UILabel(frame: CGRect(x: 0, y: ( gaugeView1.frame.origin.y + 160 ), width: scrollView.frame.size.width, height: 40))
        lbl1.textAlignment = .center //For center alignment
        lbl1.text = "Titre " + String(33)
        lbl1.textColor = .black
        lbl1.backgroundColor = .white//If required
        lbl1.font = UIFont.systemFont(ofSize: 11)
        lbl1.numberOfLines = 0
        lbl1.lineBreakMode = .byWordWrapping
        scrollView.addSubview(lbl1)
        scrollView.bringSubviewToFront(lbl1)
        
        gaugeView2.areas = "50,50,0,0,0"
        gaugeView2.colorCodes = "e67300,ffd9b3,FFFFFF,FFFFFF,FFFFFF"
        gaugeView2.needleValue = 45;
        let lbl2 = UILabel(frame: CGRect(x: 0, y: ( gaugeView2.frame.origin.y + 160 ), width: scrollView.frame.size.width, height: 40))
        lbl2.textAlignment = .center //For center alignment
        lbl2.text = "Titre " + String(33)
        lbl2.textColor = .black
        lbl2.backgroundColor = .white//If required
        lbl2.font = UIFont.systemFont(ofSize: 11)
        lbl2.numberOfLines = 0
        lbl2.lineBreakMode = .byWordWrapping
        scrollView.addSubview(lbl2)
        scrollView.bringSubviewToFront(lbl2)
        
        gaugeView3.areas = "40,60,0,0,0"
        gaugeView3.colorCodes = "ff6666,e6b3b3,FFFFFF,FFFFFF,FFFFFF"
        gaugeView3.needleValue = 73;
        let lbl3 = UILabel(frame: CGRect(x: 0, y: ( gaugeView3.frame.origin.y + 160 ), width: scrollView.frame.size.width, height: 40))
        lbl3.textAlignment = .center //For center alignment
        lbl3.text = "Titre " + String(33)
        lbl3.textColor = .black
        lbl3.backgroundColor = .white//If required
        lbl3.font = UIFont.systemFont(ofSize: 11)
        lbl3.numberOfLines = 0
        lbl3.lineBreakMode = .byWordWrapping
        scrollView.addSubview(lbl3)
        scrollView.bringSubviewToFront(lbl3)
        
        gaugeView4.areas = "70,30,0,0,0"
        gaugeView4.colorCodes = "003cb3,ccddff,FFFFFF,FFFFFF,FFFFFF"
        gaugeView4.needleValue = 90;
        let lbl4 = UILabel(frame: CGRect(x: 0, y: ( gaugeView4.frame.origin.y + 160 ), width: scrollView.frame.size.width, height: 40))
        lbl4.textAlignment = .center //For center alignment
        lbl4.text = "Titre " + String(33)
        lbl4.textColor = .black
        lbl4.backgroundColor = .white//If required
        lbl4.font = UIFont.systemFont(ofSize: 11)
        lbl4.numberOfLines = 0
        lbl4.lineBreakMode = .byWordWrapping
        scrollView.addSubview(lbl4)
        scrollView.bringSubviewToFront(lbl4)
        
        
        
        //notifications from lef Menu
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
            WSQueries.getDonneesUtiles(delegate: self);
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
                
                let dataLangue = NSKeyedArchiver.archivedData(withRootObject: data.dataUtiles.langues)
                preferences.set(dataLangue, forKey: Utils.SHARED_PREFERENCE_LANGUAGES)
                
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
    }
    
    
}
