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
        q5slider.frame = CGRect(x: q5slider.bounds.midX, y: q5slider.bounds.midY, width: ScrollView.bounds.width * 0.85, height: 15)
        setSlider(slider: q4slider);
        setSlider(slider: q5slider);
        setSliderInvert(slider: q6slider);
        setSlider(slider: q7slider);
        let borderColor : UIColor = UIColor(red: 12/255, green: 0/255, blue: 9/255, alpha: 1.0)
            q9tv.layer.borderWidth = 0.4
            q9tv.layer.borderColor = borderColor.cgColor
            q9tv.layer.cornerRadius = 5.0
        self.locationPicker.delegate = self
        self.locationPicker.dataSource = self
        pickerData = ["Target", "Trader Joe’s", "CVS", "Whole Foods", "Ralph’s", "Barney’s Beanery", "Tongva Steps area", "Diddy Riese", "BJ’s Restaurant & Brewhouse"]
            self.q4img.image = UIImage(named: "q4_50")
        self.q5img.image = UIImage(named: "q5_50")
        self.q6img.image = UIImage(named: "q6_50")
        submitBtn.layer.cornerRadius = 8.0
        submitBtn.backgroundColor = UIColor(red: 88/255, green: 130/255, blue: 143/255, alpha: 1.0) /* #58828F */
        submitBtn.layer.shadowColor = UIColor(red: 148/255, green: 183/255, blue: 192/255, alpha: 1.0).cgColor /* #94B7C0 */
        submitBtn.layer.shadowOffset = CGSize(width: 0, height: 5)
        submitBtn.layer.shadowRadius = 5
        submitBtn.layer.shadowOpacity = 1.0
        let protocols = [masksReq, staffMask, plexiGlass, bathroom, lineOutside, outlets, takeout, dineIn, wifiProv, outdoor, limitedCap]
        for button in protocols{
          button?.backgroundColor = UIColor.white
          button?.setTitleColor(UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0) /* #A0A0A0 */, for: UIControl.State.normal)
          button?.layer.borderColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0).cgColor
          button?.layer.borderWidth = 1.0
          button?.layer.cornerRadius = 5.0
        }
        startPicker.timeZone = TimeZone(abbreviation: "PST")
        endPicker.timeZone = TimeZone(abbreviation: "PST")
  //      IQKeyboardManager.shared.enable = true
      }
    
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var sliderlabel1: UILabel!
    @IBOutlet weak var sliderNums: UILabel!

    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!
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
}

//MARK: - POST endpoint functions
extension ReportViewController {
    /// send a POST request to database to add the user report on "submit" button press
    @IBAction func submitButtonPressed(_ sender: UIButton) {

        //TODO: change to AWS later on
        let url = URL(string: "http://localhost:8000/places/save_app_report")
        guard let requestUrl = url else { fatalError() }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let outgoingData = prepareData()
        guard outgoingData != nil else {
            return
        }
        let jsonData = try! JSONEncoder().encode(outgoingData)
        print(jsonData)
        request.httpBody = jsonData
        var d : Response?
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            d = try? JSONDecoder().decode(Response.self, from: data!)
            if d == nil {
                print("Error in getting JSON response")
            }
            else if let d = d{
                DispatchQueue.main.async {
                    if !d.success {
                        if let err = d.err_msg {
                            print(err)
                            let alert = UIAlertController(title: "Unable to save report", message: "Please contact developer support for further information. \n Error is \(err)", preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(cancelAction)
                            self.present(alert, animated: true, completion: nil)
                            //potentially can add an option to report right away which can automatically
                            //add to say, a google form
                            
                        }
                    }
                    else {
                        let alert = UIAlertController(title: "Successfully saved report!", message: nil, preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
                            self.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        task.resume()

    }
    
    /**
     Check if all fields and inputs are entered correctly
     
     - Returns: model bundling all the data required to send to the post request.
     */
    func prepareData()->ReportDataModel? {
        /*
         struct ReportDataModel: Codable {
             let name : String
             let start, end : Date
             let density, social_distancing, mask, covid : Int
             let masks_req, staff_masks_req, plexiglass_req, line_req, capacity_limit_req, takeout_avlbl, dinein_avlbl, outdoor_seats_avlbl, social_dist_req, bathroom_avlbl, wifi_avlbl, outlets_avlbl : Bool
             let covid_notes : String
             let other_comments : String
         }
         */
        let name = pickerData[locationPicker.selectedRow(inComponent: 0)]
        let start = startPicker.date
        let end = endPicker.date
        if end < start {
            let alert = UIAlertController(title: "End time must be after start time", message: nil, preferredStyle: .alert)
            let OKaction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(OKaction)
            present(alert, animated: true, completion: nil)
            return nil
        }
        
        let socialDist = Int(round(q4slider.value/25)+1)
        let masks = Int(round(q5slider.value/25)+1)
        let crowded = Int(round(q6slider.value/25)+1)
        let covid = Int(round(q7slider.value/25)+1)
        let maskreq = buttonSelected(button: masksReq)
        let staffmaskreq = buttonSelected(button: staffMask)
        
        let plexiglass = buttonSelected(button: plexiGlass)
        let line = buttonSelected(button: lineOutside)
        let capacity = buttonSelected(button: limitedCap)
        let bathroomAvl = buttonSelected(button: bathroom)
        let wifi = buttonSelected(button: wifiProv)
        let outlet = buttonSelected(button: outlets)
        let take_out = buttonSelected(button: takeout)
        let dine_in = buttonSelected(button: dineIn)
        let outseating = buttonSelected(button: outdoor)
        
        let comments = q9tv.text
        
        //FIXME: no field for social distancing requirement from front end, but backend requires it. need to discuss whether required or not since slider is already provided
        let reportData = ReportDataModel(name: name, start: start, end: end, density: crowded, social_distancing: socialDist, mask: masks, covid: covid, masks_req: maskreq, staff_masks_req: staffmaskreq, plexiglass_req: plexiglass, line_req: line, capacity_limit_req: capacity, takeout_avlbl: take_out, dinein_avlbl: dine_in, outdoor_seats_avlbl: outseating, social_dist_req: false, bathroom_avlbl: bathroomAvl, wifi_avlbl: wifi, outlets_avlbl: outlet, covid_notes: "", other_comments: comments ?? "")
        return reportData
    }
    
    /// Roundabout function that uses the fact that deselcted button has a white background.
    private func buttonSelected(button : UIButton)->Bool{
        return button.backgroundColor != UIColor.white
    }
    
}

//MARK: - Slider functions
extension ReportViewController {
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
        UIGraphicsEndImageContext()


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
