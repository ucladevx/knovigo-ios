//
//  FilterViewCell.swift
//  Knovigo
//
//  Created by Jeffrey Ma on 2/16/21.
//

import UIKit
import DropDown

protocol ToggleDelegate:class {
    func toggleWasSwitched(_ item: String, toggleval: Bool)
}

class FilterViewCell: DropDownCell {
    @IBOutlet var toggleswitch: UISwitch!
    weak var delegate: ToggleDelegate?;
    override func awakeFromNib() {
        super.awakeFromNib();
        toggleswitch.addTarget(self, action: #selector(didToggleSwitch), for: .valueChanged)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // Configure the view for the selected state
        
    }
    
    @objc func didToggleSwitch () {
        delegate?.toggleWasSwitched(self.optionLabel.text!, toggleval: toggleswitch.isOn);
    }
    
}
