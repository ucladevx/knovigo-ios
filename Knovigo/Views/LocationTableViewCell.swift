//
//  TableViewCell.swift
//  Knovigo
//
//  Created by Abhishek Marda on 12/24/20.
//

import UIKit

class LocationInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var densitySlider: UISlider!
    @IBOutlet weak var distancingSlider: UISlider!
    @IBOutlet weak var maskWearingSlider: UISlider!
    
    @IBOutlet weak var densityValue: UILabel!
    @IBOutlet weak var distancingValue: UILabel!
    @IBOutlet weak var maskWearingValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 20
        setSlider(slider: densitySlider)
        setSlider(slider: distancingSlider)
        setSlider(slider: maskWearingSlider)
        
        densitySlider.isUserInteractionEnabled = false
        distancingSlider.isUserInteractionEnabled = false
        maskWearingSlider.isUserInteractionEnabled = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setSlider(slider:UISlider) {
       let tgl = CAGradientLayer()
        let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width-7, height: 8.0 )
       tgl.frame = frame

        tgl.colors = [UIColor(red: 196/255, green: 13/255, blue: 0/255, alpha: 1.0).cgColor /* #c40d00 */, UIColor(red: 255/255, green: 231/255, blue: 81/255, alpha: 1.0).cgColor /* #ffec21 */, UIColor(red: 80/255, green: 175/255, blue: 114/255, alpha: 1.0).cgColor /* #50af72 */

       ]

       tgl.borderWidth = 1.0
       tgl.borderColor = UIColor.white.cgColor
       tgl.cornerRadius = 6.0

       tgl.endPoint = CGPoint(x: 1.0, y:  1.0)
       tgl.startPoint = CGPoint(x: 0.0, y:  1.0)

       UIGraphicsBeginImageContextWithOptions(tgl.frame.size, false, 0.0)
       tgl.render(in: UIGraphicsGetCurrentContext()!)
       let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       slider.setMaximumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)
       slider.setMinimumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)

       let layerFrame = CGRect(x: 0, y: 0, width: 8.0, height: 8.0)

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
