//
//  TableViewCell.swift
//  Knovigo
//
//  Created by Abhishek Marda on 12/24/20.
//

import UIKit

class LocationInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var densitySlider: UISlider!
    @IBOutlet weak var distancingSlider: UISlider!
    @IBOutlet weak var maskWearingSlider: UISlider!
    
    @IBOutlet weak var densityValue: UILabel!
    @IBOutlet weak var distancingValue: UILabel!
    @IBOutlet weak var maskWearingValue: UILabel!
    
    
    // variables to be loaded by caller
    var density : Int?
    var distancing : Int?
    var maskWearing : Int?
    
    var locationName : String?
    var tags : String?
    var expense : Int?
    var distance : Float?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        densityValue.text = String(density!)
        distancingValue.text = String(distancing!)
        locationNameLabel.text = locationName
        distanceLabel.text = String(distance!) + "mi"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
