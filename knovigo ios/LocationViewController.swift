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
    
    @IBOutlet weak var barChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charInit()
        // Do any additional setup after loading the view.
    }
    
    func charInit(){
        //hard coding data for chart
        let set = BarChartDataSet(entries: [
            BarChartDataEntry(x: 0, y: 3),
            BarChartDataEntry(x: 10, y: 5),
            BarChartDataEntry(x: 20, y: 10),
            BarChartDataEntry(x: 30, y: 20),
            BarChartDataEntry(x: 40, y: 40),
            BarChartDataEntry(x: 50, y: 60),
            BarChartDataEntry(x: 60, y: 40),
            BarChartDataEntry(x: 70, y: 20),
            BarChartDataEntry(x: 80, y: 10),
            BarChartDataEntry(x: 90, y: 5),
            BarChartDataEntry(x: 100, y: 3),
        ])
        
        //for formatting purpose
        set.drawValuesEnabled = false
        set.colors = [UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)]
        set.highlightColor = UIColor(red: 25/255, green: 121/255, blue: 169/255, alpha: 1)
        
        //store data in an array
        let data = BarChartData(dataSet: set)
        
        //for formatting purpose
        data.barWidth = 8
        
        //assign data to barChart
        barChart.data = data
        
        //bar chart formatting
        barChart.xAxis.drawAxisLineEnabled = false
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.drawLabelsEnabled = false
        barChart.leftAxis.drawLabelsEnabled = false
        barChart.leftAxis.drawAxisLineEnabled = false
        barChart.rightAxis.drawAxisLineEnabled = false
        barChart.rightAxis.drawLabelsEnabled = false
        barChart.legend.enabled = false
                        
        barChart.notifyDataSetChanged()
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
