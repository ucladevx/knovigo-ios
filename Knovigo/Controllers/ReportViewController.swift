//
//  ReportViewController.swift
//  knovigo ios
//
//  Created by Medha Kini on 11/24/20.
//  Copyright © 2020 Katie Chang. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
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

    override func viewDidLoad() {
        super.viewDidLoad()
//        showBackButton();
        // Do any additional setup after loading the view.
        
        LocationReport.font = UIFont.boldSystemFont(ofSize: 28.0)
        LocationReport.adjustsFontSizeToFitWidth = true
        intro.font = UIFont.systemFont(ofSize: 13.0)
        intro.adjustsFontSizeToFitWidth = true
        q1.font = UIFont.systemFont(ofSize: 16.0)
        q1.adjustsFontSizeToFitWidth = true
        q1.minimumScaleFactor = 0.5
        q2.font = UIFont.systemFont(ofSize: 16.0)
        q2.adjustsFontSizeToFitWidth = true
        q2.minimumScaleFactor = 0.5
        q3.font = UIFont.systemFont(ofSize: 16.0)
        q3.adjustsFontSizeToFitWidth = true
        q3.minimumScaleFactor = 0.5
        q4.font = UIFont.systemFont(ofSize: 16.0)
        q4.adjustsFontSizeToFitWidth = true
        q4.minimumScaleFactor = 0.5
        q5.font = UIFont.systemFont(ofSize: 16.0)
        q5.adjustsFontSizeToFitWidth = true
        q5.minimumScaleFactor = 0.5
        q6.font = UIFont.systemFont(ofSize: 16.0)
        q6.adjustsFontSizeToFitWidth = true
        q6.minimumScaleFactor = 0.5
        q7.font = UIFont.systemFont(ofSize: 16.0)
        q7.adjustsFontSizeToFitWidth = true
        q7.minimumScaleFactor = 0.5
        q8.font = UIFont.systemFont(ofSize: 16.0)
        q8.adjustsFontSizeToFitWidth = true
        q8.minimumScaleFactor = 0.5
        q9.font = UIFont.systemFont(ofSize: 16.0)
        q9.adjustsFontSizeToFitWidth = true
        q9.minimumScaleFactor = 0.5

        curPlaceLabel.font = UIFont.systemFont(ofSize: 14.0)
        curPlaceLabel.adjustsFontSizeToFitWidth = true
        curPlaceLabel.minimumScaleFactor = 0.5
        
        sliderlabel1.font = UIFont.systemFont(ofSize: 13.0)
        sliderlabel1.adjustsFontSizeToFitWidth = true
        sliderlabel1.minimumScaleFactor = 0.5
        sliderlabel1.textColor = UIColor.gray
        sliderNums.textColor = UIColor.white
        sliderNums.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.bold)
        sliderNums.adjustsFontSizeToFitWidth = true
        sliderNums.minimumScaleFactor = 0.5
        
        //switched around labels
        sliderNums2.font = UIFont.systemFont(ofSize: 13.0)
        sliderNums2.adjustsFontSizeToFitWidth = true
        sliderNums2.minimumScaleFactor = 0.5
        sliderNums2.textColor = UIColor.gray
        sliderlabel2.textColor = UIColor.white
        sliderlabel2.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.bold)
        sliderlabel2.adjustsFontSizeToFitWidth = true
        sliderlabel2.minimumScaleFactor = 0.5
        
        sliderNums3.font = UIFont.systemFont(ofSize: 13.0)
        sliderNums3.adjustsFontSizeToFitWidth = true
        sliderNums3.minimumScaleFactor = 0.5
        sliderNums3.textColor = UIColor.gray
        sliderlabel3.textColor = UIColor.white
        sliderlabel3.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.bold)
        sliderlabel3.adjustsFontSizeToFitWidth = true
        sliderlabel3.minimumScaleFactor = 0.5
        
        sliderNums4.font = UIFont.systemFont(ofSize: 13.0)
        sliderNums4.adjustsFontSizeToFitWidth = true
        sliderNums4.minimumScaleFactor = 0.5
        sliderNums4.textColor = UIColor.gray
        sliderlabel4.textColor = UIColor.white
        sliderlabel4.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.bold)
        sliderlabel4.adjustsFontSizeToFitWidth = true
        sliderlabel4.minimumScaleFactor = 0.5
        
        setSlider(slider: q4slider);
        setSlider(slider: q5slider);
        setSliderInvert(slider: q6slider);
        setSlider(slider: q7slider);
        
        let borderColor : UIColor = UIColor(red: 12/255, green: 0/255, blue: 9/255, alpha: 1.0)
                q9tv.layer.borderWidth = 0.5
                q9tv.layer.borderColor = borderColor.cgColor
                q9tv.layer.cornerRadius = 5.0
       
        self.locationPicker.delegate = self
        self.locationPicker.dataSource = self
        pickerData = ["Target", "Trader Joe's", "CVS", "Whole Foods", "Ralph's", "Barney's Beanery", "Tongva Steps Area", "Diddy Riese", "BJs Restaurant"]

        self.q4img.image = UIImage(named: "q4_50")
        self.q5img.image = UIImage(named: "q5_50")
        self.q6img.image = UIImage(named: "q6_50")
        
        self.locationImg.image = UIImage(named: "locationPic")
        
        submitBtn.layer.cornerRadius = 3.0
        submitBtn.frame = CGRect(x: 151, y: 1702, width: 150, height: 40)
        submitBtn.backgroundColor = UIColor(red: 68/255, green: 150/255, blue: 176/255, alpha: 1.0) /* #4496b0 */
        submitBtn.setTitle("Submit", for: .normal)
        submitBtn.setTitleColor(UIColor.white, for: .normal)

        masksReq.backgroundColor = UIColor.white
        masksReq.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        masksReq.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        masksReq.layer.borderWidth = 1.0
        masksReq.layer.cornerRadius = 5.0
        
        staffMask.backgroundColor = UIColor.white
        staffMask.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        staffMask.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        staffMask.layer.borderWidth = 1.0
        staffMask.layer.cornerRadius = 5.0

        plexiGlass.backgroundColor = UIColor.white
        plexiGlass.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        plexiGlass.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha:1.0).cgColor
        plexiGlass.layer.borderWidth = 1.0
        plexiGlass.layer.cornerRadius = 5.0

        bathroom.backgroundColor = UIColor.white
        bathroom.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        bathroom.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        bathroom.layer.borderWidth = 1.0
        bathroom.layer.cornerRadius = 5.0

        lineOutside.backgroundColor = UIColor.white
        lineOutside.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        lineOutside.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        lineOutside.layer.borderWidth = 1.0
        lineOutside.layer.cornerRadius = 5.0

        outlets.backgroundColor = UIColor.white
        outlets.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        outlets.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        outlets.layer.borderWidth = 1.0
        outlets.layer.cornerRadius = 5.0

        takeout.backgroundColor = UIColor.white
        takeout.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        takeout.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        takeout.layer.borderWidth = 1.0
        takeout.layer.cornerRadius = 5.0

        dineIn.backgroundColor = UIColor.white
        dineIn.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        dineIn.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        dineIn.layer.borderWidth = 1.0
        dineIn.layer.cornerRadius = 5.0

        wifiProv.backgroundColor = UIColor.white
        wifiProv.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        wifiProv.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        wifiProv.layer.borderWidth = 1.0
        wifiProv.layer.cornerRadius = 5.0

        outdoor.backgroundColor = UIColor.white
        outdoor.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        outdoor.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        outdoor.layer.borderWidth = 1.0
        outdoor.layer.cornerRadius = 5.0

        limitedCap.backgroundColor = UIColor.white
        limitedCap.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0) /* #74b260 */, for: UIControl.State.normal)
        limitedCap.layer.borderColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0).cgColor
        limitedCap.layer.borderWidth = 1.0
        limitedCap.layer.cornerRadius = 5.0


//        q4ValChanged(q4slider)
    }
    
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var sliderlabel1: UILabel!
    @IBOutlet weak var sliderNums: UILabel!
    
    @IBOutlet weak var locationImg: UIImageView!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var q4img: UIImageView!
    @IBOutlet weak var q5img: UIImageView!
    @IBOutlet weak var q6img: UIImageView!
    @IBOutlet weak var q9tv: UITextView!
    
    @IBAction func q4ValChanged(_ sender: UISlider) {
        let sliderValue = sender.value
        if (sliderValue < 0.15) {
            self.q4img.image = UIImage(named: "q4_0")
        } else if (sliderValue < 0.38) {
            self.q4img.image = UIImage(named: "q4_25")
        } else if (sliderValue < 0.62) {
            self.q4img.image = UIImage(named: "q4_50")
        } else if (sliderValue < 0.90) {
            self.q4img.image = UIImage(named: "q4_75")
        } else {
            self.q4img.image = UIImage(named: "q4_100")
        }
    }
    @IBAction func q5ValChanged(_ sender: UISlider) {
        let sliderValue = sender.value
        if (sliderValue < 0.15) {
            self.q5img.image = UIImage(named: "q5_0")
        } else if (sliderValue < 0.38) {
            self.q5img.image = UIImage(named: "q5_25")
        } else if (sliderValue < 0.62) {
            self.q5img.image = UIImage(named: "q5_50")
        } else if (sliderValue < 0.90) {
            self.q5img.image = UIImage(named: "q5_75")
        } else {
            self.q5img.image = UIImage(named: "q5_100")
        }
    }
    
    @IBAction func q6ValChanged(_ sender: UISlider) {
        let sliderValue = sender.value
        if (sliderValue < 0.15) {
            self.q6img.image = UIImage(named: "q6_0")
        } else if (sliderValue < 0.38) {
            self.q6img.image = UIImage(named: "q6_25")
        } else if (sliderValue < 0.62) {
            self.q6img.image = UIImage(named: "q6_50")
        } else if (sliderValue < 0.90) {
            self.q6img.image = UIImage(named: "q6_75")
        } else {
            self.q6img.image = UIImage(named: "q6_100")
        }
    }
    
    @IBOutlet weak var sliderlabel2: UILabel!
    @IBOutlet weak var sliderNums2: UILabel!
    @IBOutlet weak var sliderNums3: UILabel!
    @IBOutlet weak var sliderlabel3: UILabel!
    
    @IBOutlet weak var sliderNums4: UILabel!
    @IBOutlet weak var sliderlabel4: UILabel!
    
    @IBOutlet weak var LocationReport: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
//    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var curPlaceLabel: UILabel!
    
    @IBOutlet weak var q4slider: UISlider!
    @IBOutlet weak var q5slider: UISlider!
    @IBOutlet weak var q6slider: UISlider!
    @IBOutlet weak var q7slider: UISlider!
    
    @IBOutlet weak var SurveyView: UIView!
    
    // QUESTION LABELS
    @IBOutlet weak var intro: UILabel!
    
    @IBOutlet weak var q1: UILabel!
    
    @IBOutlet weak var q2: UILabel!
    
    @IBOutlet weak var q3: UILabel!
    
    @IBOutlet weak var q4: UILabel!
    
    @IBOutlet weak var q5: UILabel!
    
    @IBOutlet weak var q6: UILabel!
    
    @IBOutlet weak var q7: UILabel!
    
    @IBOutlet weak var q8: UILabel!
    
    @IBOutlet weak var q9: UILabel!
    
    
    @IBOutlet weak var masksReq: UIButton!
    @IBOutlet weak var staffMask: UIButton!
    @IBOutlet weak var plexiGlass: UIButton!
    @IBOutlet weak var limitedCap: UIButton!
    @IBOutlet weak var bathroom: UIButton!
    @IBOutlet weak var lineOutside: UIButton!
    @IBOutlet weak var outlets: UIButton!
    @IBOutlet weak var takeout: UIButton!
    @IBOutlet weak var dineIn: UIButton!
    @IBOutlet weak var wifiProv: UIButton!
    @IBOutlet weak var outdoor: UIButton!
    
    @IBAction func changeBtnColor(_ sender: UIButton) {
        if (sender.backgroundColor == UIColor.white) {
            sender.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0)
            sender.setTitleColor(UIColor.white, for: UIControl.State.normal);
        } else {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0), for: UIControl.State.normal);
        }
    }
    
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // send a POST request to database to add the user report
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        struct ReportDataModel: Codable {
            var userid: Int
            var id: Int?
        }

        let url = URL(string: "http://localhost:8000/places/save_app_report")
        guard let requestUrl = url else { fatalError() }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let newTodoItem = ReportDataModel(userid: 300, id:30)
        let jsonData = try! JSONEncoder().encode(newTodoItem)
        print(jsonData)
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            struct Response : Decodable {
                let succ : String
            }
            let d = try! JSONDecoder().decode(Response.self, from: data!)
            print("got data: \(d.succ)")
           
        }
        task.resume()
    }
    
    
    
    //    func showBackButton() {
////        let reportBtn = UIButton(type: .custom)
//            backButton.frame = CGRect(x: 5, y: 50, width: 40, height: 40)
//        backButton.clipsToBounds = true
//        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
//            view.addSubview(backButton)
//
//    }
//
//    @objc func backButtonPressed() {
//        self.performSegue(withIdentifier: "GoBack", sender: self)
//    }
    
    func setSlider(slider:UISlider) {
       let tgl = CAGradientLayer()
       let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: 14.0 )
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

       let layerFrame = CGRect(x: 0, y: 0, width: 15.0, height: 15.0)

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
       let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: 14.0 )
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

       let layerFrame = CGRect(x: 0, y: 0, width: 15.0, height: 15.0)

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
