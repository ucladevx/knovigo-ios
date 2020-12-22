//
//  LocationViewController.swift
//  knovigo ios
//
//  Created by Katie Chang on 2020/11/29.
//  Copyright © 2020 Katie Chang. All rights reserved.
//

import UIKit
import Charts
import DropDown

class LocationViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var estiDensity: UISlider!
    @IBOutlet weak var estiDistancing: UISlider!
    @IBOutlet weak var estiMWearing: UISlider!
    @IBOutlet weak var dropDownBtn: UIButton!
    
    var density: Float = -1
    var distancing: Float = -1
    var mwearing: Float = -1
    
    let dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charInit()
        dropDownInit()
        
//        putTags(tagList: &protocolTags)
        // Do any additional setup after loading the view.
    }
    
    func charInit(){
        //TODO: hard coding data for chart
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
        set.highlightColor = UIColor(red: 68/255, green: 150/255, blue: 176/255, alpha: 1)
        
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
    
    func dropDownInit(){
        dropDownBtn.clipsToBounds = true
        dropDownBtn.layer.cornerRadius = 0.3 * dropDownBtn.bounds.size.height
        dropDown.dataSource = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        dropDown.anchorView = dropDownBtn
        dropDown.backgroundColor = UIColor(red: 215/255, green: 231/255, blue: 236/255, alpha: 1)
        dropDown.selectionAction = {
            [weak self] (index, item) in
            self?.dropDownBtn.setTitle(item, for: .normal)
        }
    }
    
    //record % obtained from sliders
    @IBAction func putDensity(slider: UISlider){ density = slider.value }
    @IBAction func putDistancing(slider: UISlider) { distancing = slider.value }
    @IBAction func putMWearing(slider: UISlider) { mwearing = slider.value }
    @IBAction func showDropDown(_ sender: Any) { dropDown.show() }
    
    func putTags(tagList: inout [tag]){
        tagList.sort{ $0.isImplemented && !$1.isImplemented }
        for i in tagList{
            print(i)
        }
    }
}