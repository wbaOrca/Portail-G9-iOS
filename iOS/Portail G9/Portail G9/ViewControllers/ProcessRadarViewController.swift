//
//  PerformanceViewController.swift
//  Efficom
//
//  Created by WBA_ORCA on 28/09/2018.
//  Copyright © 2018 Orcaformation. All rights reserved.
//

import UIKit


// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class ProcessRadarViewController: UIViewController,UIWebViewDelegate  {

    @IBOutlet weak var scrollView: UIScrollView!
    
    private var graphePolarModel: AAChartModel?
    private var graphePolarView: AAChartView?
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         self.title = NSLocalizedString("Performance", tableName: nil, bundle: appDelegate.customApplicationLang.createBundlePath(), value: "", comment: "-");
        
        
        
        let chartViewWidth = self.view.frame.size.width
        let chartViewHeight = 400
        // ++++++++++++++++++
        // 1er graphe column
        // ++++++++++++++++++
        graphePolarView = AAChartView()
        
        graphePolarView?.frame = CGRect(x:0,y:0 ,width:Int(chartViewWidth),height:chartViewHeight)
        graphePolarView?.contentWidth = chartViewWidth
        graphePolarView?.contentHeight = CGFloat(chartViewHeight)
        graphePolarView?.scrollEnabled = true//
        graphePolarView?.isClearBackgroundColor = true
        
        graphePolarModel = AAChartModel()
            .chartType(AAChartType.Line)
            .title("Performance")//
            .subtitle("")
            .dataLabelEnabled(false)//
            //.tooltipValueSuffix("℃")//
            .backgroundColor("#ffffff")//
            .legendEnabled(true)
            .zoomType(.XY)
            .colorsTheme(["#ef476f","#ffd066",])
            .animationType(AAChartAnimationType.Elastic)
            .animationDuration(300)
            .polar(true)
            //.xAxisReversed(true)
            //.yAxisReversed(true)
            .categories(["Commandes", "Livraisons", "Immatriculations", "Contrats service", "Financement"])
            .series([
                AASeriesElement()
                    .name("Moyenne des vendeurs")
                    .data([170, 116, 120, 55, 34])
                    .toDic()!,
                AASeriesElement()
                    .name("Pierre Maurel")
                    .data([210, 155, 161, 88, 25])
                    .toDic()!,
               
                
                ])
        
        graphePolarView?.aa_drawChartWithChartModel(graphePolarModel!)
        self.scrollView.addSubview(graphePolarView!)
        
        // +++++
        self.scrollView.contentSize.height =  (graphePolarView?.frame.size.height)!
        
    }
   
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    func kRGBColorFromHex(rgbValue: Int) -> (UIColor) {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
}


