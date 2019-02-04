//
//  HomeViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 29/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

import SideMenu
import ABGaugeViewKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class HomeViewController: UIViewController {

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
        labelWelcome.text = NSLocalizedString("Hello", comment: "-")
        
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
        
        gaugeView2.areas = "50,50,0,0,0"
        gaugeView2.colorCodes = "e67300,ffd9b3,FFFFFF,FFFFFF,FFFFFF"
        gaugeView2.needleValue = 45;
        
        gaugeView3.areas = "40,60,0,0,0"
        gaugeView3.colorCodes = "ff6666,e6b3b3,FFFFFF,FFFFFF,FFFFFF"
        gaugeView3.needleValue = 73;
        
        gaugeView4.areas = "70,30,0,0,0"
        gaugeView4.colorCodes = "003cb3,ccddff,FFFFFF,FFFFFF,FFFFFF"
        gaugeView4.needleValue = 90;
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
    // *******************************************************************************
    // ******
    // ****** viewWillAppear
    // ******
    // *******************************************************************************
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
