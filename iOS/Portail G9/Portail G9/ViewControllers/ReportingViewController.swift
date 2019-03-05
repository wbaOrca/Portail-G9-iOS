//
//  ReportingViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 27/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class ReportingViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    private var grapheColumnModel: AAChartModel?
    private var grapheColumnView: AAChartView?
    
    
    private var graphePieModel: AAChartModel?
    private var graphePieView: AAChartView?
    
    // *******************************
    // *******************************
    // *******************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let chartViewWidth = self.view.frame.size.width
        let chartViewHeight = 400
        // ++++++++++++++++++
        // 1er graphe column
        // ++++++++++++++++++
        grapheColumnView = AAChartView()
        
        grapheColumnView?.frame = CGRect(x:0,y:0,width:Int(chartViewWidth),height:chartViewHeight)
        grapheColumnView?.contentWidth = chartViewWidth
        grapheColumnView?.contentHeight = CGFloat(chartViewHeight)
        grapheColumnView?.scrollEnabled = true//
        grapheColumnView?.isClearBackgroundColor = true
        grapheColumnModel = AAChartModel()
            .chartType(AAChartType.Column)
            .title("Performance")//
            .subtitle("")
            .dataLabelEnabled(false)//
            .backgroundColor("#ffffff")//
            .legendEnabled(true)
            .zoomType(.XY)
            .colorsTheme(["#ffd11a","#0033cc"])
            .animationType(AAChartAnimationType.Bounce)
            .animationDuration(500)
            //.xAxisReversed(true)
            //.yAxisReversed(true)
            .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            .series([
                AASeriesElement()
                    .name("Renault")
                    .data([170, 116, 89, 14, 18, 21, 25, 26, 23, 18, 98, 199])
                    .toDic()!,
                AASeriesElement()
                    .name("Dacia")
                    .data([180, 50, 155, 11, 17, 22, 24, 24, 20, 70, 8, 222])
                    .toDic()!,
                
                
                ])
        
        grapheColumnView?.aa_drawChartWithChartModel(grapheColumnModel!)
        self.scrollView.addSubview(grapheColumnView!)
        
        
        
        
        // ++++++++++++++++++
        // 2ème graphe column
        // ++++++++++++++++++
        graphePieView = AAChartView()
        
        graphePieView?.frame = CGRect(x:0,y:(Int(0 + (grapheColumnView?.frame.height)!)) ,width:Int(chartViewWidth),height:chartViewHeight)
        graphePieView?.contentWidth = chartViewWidth
        graphePieView?.contentHeight = CGFloat(chartViewHeight)
        graphePieView?.scrollEnabled = true//
        graphePieView?.isClearBackgroundColor = true
        
        graphePieModel = AAChartModel()
            .chartType(AAChartType.Pie)
            .backgroundColor("#ffffff")
            .title("Pénétration DIAC")
            .subtitle("")
            .dataLabelEnabled(true)//是否直接显示扇形图数据
            .yAxisTitle("℃")
            .series(
                [
                    AASeriesElement()
                        .name("Pénétration DIAC")
                        .innerSize("10%")
                        .allowPointSelect(false)
                        .data([
                            ["Sans Diac"  ,67],
                            ["Avec Diac",482],
                            ])
                        .toDic()!,
                    ]
        )
        
        graphePieView?.aa_drawChartWithChartModel(graphePieModel!)
        self.scrollView.addSubview(graphePieView!)
        
        // +++++
        self.scrollView.contentSize.height = (grapheColumnView?.frame.size.height)! + (graphePieView?.frame.size.height)!
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
