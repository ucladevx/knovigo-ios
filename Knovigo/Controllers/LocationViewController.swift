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

class LocationViewController: UIViewController, ChartViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

       var title = UILabel()
          if let view = view {
                 title = view as! UILabel
           }
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
         title.textColor = UIColor(red: 80/255, green: 175/255, blue: 114/255, alpha: 1.0)
         title.text =  pickerData[row]
         title.textAlignment = .center

     return title

     }
    var pickerData: [String] = [String]()

    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var dayPicker: UIPickerView!
    //@IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var estiDensity: UISlider!
    @IBOutlet weak var estiDistancing: UISlider!
    @IBOutlet weak var estiMWearing: UISlider!
    @IBOutlet weak var dropDownBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    
    var density: Float = -1
    var distancing: Float = -1
    var mwearing: Float = -1
    @IBOutlet weak var locImage: UIImageView!
    
    
    @IBOutlet weak var masksReqBtn: UILabel!
    
    @IBOutlet weak var staffWearsBtn: UILabel!
    
    @IBOutlet weak var plexiglassBtn: UILabel!
    
    @IBOutlet weak var limitedCapacityBtn: UILabel!
    
    @IBOutlet weak var lineOutsideBtn: UILabel!
    
    @IBOutlet weak var bathroomBtn: UILabel!
    
    @IBOutlet weak var wifiBtn: UILabel!
    
    @IBOutlet weak var outdoorBtn: UILabel!
    
    @IBOutlet weak var outletBtn: UILabel!
    
    @IBOutlet weak var takeoutBtn: UILabel!
    
    @IBOutlet weak var dineInBtn: UILabel!
    
    let dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)

       // barChart.delegate = self;
        charInit()
        //dropDownInit()
        setSliderInvert(slider: estiDensity);
        setSlider(slider: estiDistancing);
        setSlider(slider: estiMWearing);
//        putTags(tagList: &protocolTags)
        // Do any additional setup after loading the view.
        self.dayPicker.delegate = self
        self.dayPicker.dataSource = self
        pickerData = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        
        self.locImage.image = UIImage(named: "targetBig.jpeg");
        
        masksReqBtn.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        plexiglassBtn.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        staffWearsBtn.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        limitedCapacityBtn.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        lineOutsideBtn.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        outdoorBtn.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        wifiBtn.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)

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
        set.drawValuesEnabled = set.isHighlightEnabled
        set.colors = [UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)]
        set.highlightColor = UIColor(red: 68/255, green: 150/255, blue: 176/255, alpha: 1)

        //store data in an array
        let data = BarChartData(dataSet: set)
        data.setDrawValues(true);
        data.accessibilityEntryLabelPrefix = "bar chart"
        data.accessibilityEntryLabelSuffix = "bar chart"

        //for formatting purpose
        data.barWidth = 6

        //assign data to barChart
            barChart.data = data

            barChart.xAxis.drawAxisLineEnabled = false
            barChart.xAxis.drawGridLinesEnabled = false
            barChart.xAxis.drawLabelsEnabled = false
            barChart.leftAxis.drawLabelsEnabled = false
            barChart.leftAxis.drawAxisLineEnabled = false
            barChart.rightAxis.drawAxisLineEnabled = false
            barChart.rightAxis.drawLabelsEnabled = true
            barChart.legend.enabled = false
            barChart.notifyDataSetChanged()
            barChart.drawValueAboveBarEnabled = true;
    }
    
//    func dropDownInit(){
//        dropDownBtn.clipsToBounds = true
//        dropDownBtn.layer.cornerRadius = 0.3
//        dropDown.dataSource = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
//        dropDown.anchorView = dropDownBtn
//        dropDown.backgroundColor = UIColor(red: 215/255, green: 231/255, blue: 236/255, alpha: 1)
//        dropDown.selectionAction = {
//            [weak self] (index, item) in
//            self?.dropDownBtn.setTitle(item, for: .normal)
//        }
//    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    func setSlider(slider:UISlider) {
       let tgl = CAGradientLayer()
       let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: 11.0 )
       tgl.frame = frame

        tgl.colors = [UIColor(red: 196/255, green: 13/255, blue: 0/255, alpha: 1.0).cgColor /* #c40d00 */, UIColor(red: 255/255, green: 231/255, blue: 81/255, alpha: 1.0).cgColor /* #ffec21 */, UIColor(red: 80/255, green: 175/255, blue: 114/255, alpha: 1.0).cgColor /* #50af72 */

       ]

       tgl.borderWidth = 1.0
       tgl.borderColor = UIColor.white.cgColor
       tgl.cornerRadius = 9.0

       tgl.endPoint = CGPoint(x: 1.0, y:  1.0)
       tgl.startPoint = CGPoint(x: 0.0, y:  1.0)

       UIGraphicsBeginImageContextWithOptions(tgl.frame.size, false, 0.0)
       tgl.render(in: UIGraphicsGetCurrentContext()!)
       let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       slider.setMaximumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)
       slider.setMinimumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)

       let layerFrame = CGRect(x: 0, y: 0, width: 12.0, height: 12.0)

       let shapeLayer = CAShapeLayer()
       shapeLayer.path = CGPath(ellipseIn: layerFrame, transform: nil)
       shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        
       let thumb = CALayer.init()
       thumb.frame = layerFrame
       thumb.addSublayer(shapeLayer)

       UIGraphicsBeginImageContextWithOptions(thumb.frame.size, false, 0.0)

       thumb.render(in: UIGraphicsGetCurrentContext()!)
       let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       slider.setThumbImage(thumbImage, for: .normal)
       slider.setThumbImage(thumbImage, for: .highlighted)
   }
    
    func setSliderInvert(slider:UISlider) {
       let tgl = CAGradientLayer()
       let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: 11.0 )
       tgl.frame = frame

        tgl.colors = [UIColor(red: 80/255, green: 175/255, blue: 114/255, alpha: 1.0).cgColor /* #50af72 */, UIColor(red: 255/255, green: 231/255, blue: 81/255, alpha: 1.0).cgColor /* #ffec21 */,  UIColor(red: 196/255, green: 13/255, blue: 0/255, alpha: 1.0).cgColor /* #c40d00 */
       ]

       tgl.borderWidth = 1.0
       tgl.borderColor = UIColor.white.cgColor
       tgl.cornerRadius = 9.0

       tgl.endPoint = CGPoint(x: 1.0, y:  1.0)
       tgl.startPoint = CGPoint(x: 0.0, y:  1.0)

       UIGraphicsBeginImageContextWithOptions(tgl.frame.size, false, 0.0)
       tgl.render(in: UIGraphicsGetCurrentContext()!)
       let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       slider.setMaximumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)
       slider.setMinimumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)

       let layerFrame = CGRect(x: 0, y: 0, width: 12.0, height: 12.0)

       let shapeLayer = CAShapeLayer()
       shapeLayer.path = CGPath(ellipseIn: layerFrame, transform: nil)
       shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        
       let thumb = CALayer.init()
       thumb.frame = layerFrame
       thumb.addSublayer(shapeLayer)

       UIGraphicsBeginImageContextWithOptions(thumb.frame.size, false, 0.0)

       thumb.render(in: UIGraphicsGetCurrentContext()!)
       let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       slider.setThumbImage(thumbImage, for: .normal)
       slider.setThumbImage(thumbImage, for: .highlighted)
   }
}
