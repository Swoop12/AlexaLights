//
//  LightTableViewCell.swift
//  AlexaLights
//
//  Created by DevMountain on 9/6/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

//1) Define the Protocol
protocol LightTableViewCellDelegate: class{
    
    func lightSwitchWasFlipped(cell: LightTableViewCell)
    
}

class LightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var lightSwitch: UISwitch!
    
    //Landing Pad
    var light: Light?{
        didSet{
            updateView()
        }
    }
    
    //2) Create Weak Var Delegate
    weak var delegate: LightTableViewCellDelegate?
    
    func updateView(){
        roomImageView.image = light?.icon
        roomNameLabel.text = light?.name
        
        guard let isOn = light?.isOn else {return}
        self.backgroundColor = isOn ? .white : .black
        roomImageView.isHidden = isOn ? false : true
        lightSwitch.isOn = isOn ? true : false
    }
    
    //3) Call the delegate wherever necessary
    @IBAction func lightSwitchFlipped(_ sender: UISwitch) {
        delegate?.lightSwitchWasFlipped(cell: self)
    }
    
}
