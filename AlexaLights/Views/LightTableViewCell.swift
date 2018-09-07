//
//  LightTableViewCell.swift
//  AlexaLights
//
//  Created by DevMountain on 9/6/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class LightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func lightSwitchFlipped(_ sender: UISwitch) {
    }
    
}
