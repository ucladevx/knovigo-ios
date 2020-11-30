//
//  LocationViewController.swift
//  knovigo ios
//
//  Created by Katie Chang on 2020/11/29.
//  Copyright © 2020 Katie Chang. All rights reserved.
//

import UIKit
import Charts

class LocationViewController: UIViewController, ChartViewDelegate {
    
    var barChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x:20, y: 445, width: 250, height: 150)
        barChart.center = view.center
        
        let set = BarChartDataSet(entries: [
            BarChartDataEntry(x: 0, y: 3),
            BarChartDataEntry(x: 10, y: 5),
            BarChartDataEntry(x: 20, y: 10),
            BarChartDataEntry(x: 30, y: 20),
            BarChartDataEntry(x: 40, y: 40),
            BarChartDataEntry(x: 50, y: 100),
            BarChartDataEntry(x: 60, y: 40),
            BarChartDataEntry(x: 70, y: 20),
            BarChartDataEntry(x: 80, y: 10),
            BarChartDataEntry(x: 90, y: 5),
            BarChartDataEntry(x: 100, y: 3),
        ])
        let data = BarChartData(dataSet: set)
        barChart.data = data
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
