//
//  LocationViewController.swift
//  knovigo ios
//
//  Created by Katie Chang on 2020/11/29.
//  Copyright © 2020 Katie Chang. All rights reserved.
//

import UIKit
import Charts
import GoogleMaps
import DropDown
//http://52.33.183.202:8000//places/all
class LocationViewController: UIViewController, ChartViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        masksReq.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        staffWears.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        plexiglass.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        limitedCapacity.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        lineOutside.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        outdoor.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        wifi.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
        
        locTitle.text = locMarker.title
        locAddress.text = locMarker.snippet
        let data = locMarker.userData as? data
        if (!(data?.isOpen ?? false)) {
            locIsClosed.text = "Closed"
            locIsClosed.textColor = UIColor.red
        }  else {
            locIsClosed.text = "Open"
            locIsClosed.textColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0)
        }
        locImage.image = data?.imageWide
        locLabel.text = data?.label
        estiDensity.value = Float(data?.sDensity ?? 0)
        estiDistancing.value = Float(data?.sDistance ?? 0)
        estiMWearing.value = Float(data?.sMask ?? 0)
        
        backBtn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
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
    @IBOutlet weak var estiDensity: UISlider!
    @IBOutlet weak var estiDistancing: UISlider!
    @IBOutlet weak var estiMWearing: UISlider!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var locImage: UIImageView!
    
    @IBOutlet weak var masksReq: UIView!
    @IBOutlet weak var staffWears: UIView!
    @IBOutlet weak var lineOutside: UIView!
    @IBOutlet weak var limitedCapacity: UIView!
    @IBOutlet weak var plexiglass: UIView!
    @IBOutlet weak var bathroom: UIView!
    @IBOutlet weak var dineIn: UIView!
    @IBOutlet weak var outdoor: UIView!
    @IBOutlet weak var outlet: UIView!
    @IBOutlet weak var wifi: UIView!
    @IBOutlet weak var takeout: UIView!
  
    
    //TEXT FIELDS
    @IBOutlet weak var locTitle: UILabel!
    @IBOutlet weak var locAddress: UILabel!
    @IBOutlet weak var locIsClosed: UILabel!
    @IBOutlet weak var locLabel: UILabel!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    let dropDown = DropDown()
    var locMarker = GMSMarker();
    
    
    func charInit(){
        //popular times --> monday --> array of 24 indexed 0-23
        /*
        let url = URL(string: "http://52.33.183.202:8000/places/place/<id>")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                print("Serialization went wrong")
                return
            }
            guard let object = json as? [[String: Any]] else {
                print("Could not read the JSON.")
                return
            }
            
            for item in object {
                let lat = item["lat"] as! CLLocationDegrees
                let lng = item["lng"] as! CLLocationDegrees
                let int = item["intensity"] as! Float
                let coords = GMUWeightedLatLng(
                    coordinate: CLLocationCoordinate2DMake(lat, lng),
                    intensity: int
                )
                list.append(coords)
            }
            // Add the latlngs to the heatmap layer.
            self.heatMapLayer.weightedData = list;
        }
         */
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
        set.highlightLineDashLengths = [CGFloat(3)]
        
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
    
    
    //record % obtained from sliders
//    @IBAction func putDensity(slider: UISlider){ density = slider.value }
//    @IBAction func putDistancing(slider: UISlider) { distancing = slider.value }
//    @IBAction func putMWearing(slider: UISlider) { mwearing = slider.value }
    //    @IBAction func showDropDown(_ sender: Any) { dropDown.show() }
    
    func putTags(tagList: inout [tag]){
        tagList.sort{ $0.isImplemented && !$1.isImplemented }
        for i in tagList{
            print(i)
        }
    }
    
    
    @IBOutlet weak var ReportButton: UIButton!
    func setReportButton() {
        ReportButton.addTarget(self, action: #selector(userReportButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func userReportButtonPressed() {
        self.performSegue(withIdentifier: "LocToReport", sender: self)
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
        
        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, tgl.isOpaque, 0.0);
        tgl.render(in: UIGraphicsGetCurrentContext()!)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            
            image.resizableImage(withCapInsets: UIEdgeInsets.zero)
            slider.setMinimumTrackImage(image, for: .normal)
            slider.setMaximumTrackImage(image, for: .normal)
        }
        
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
        
        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, tgl.isOpaque, 0.0);
        tgl.render(in: UIGraphicsGetCurrentContext()!)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            
            image.resizableImage(withCapInsets: UIEdgeInsets.zero)
            slider.setMinimumTrackImage(image, for: .normal)
            slider.setMaximumTrackImage(image, for: .normal)
        }
        
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
