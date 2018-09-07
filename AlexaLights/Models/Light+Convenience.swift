//
//  Light+Convenience.swift
//  AlexaLights
//
//  Created by DevMountain on 9/6/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit
import CoreData

extension Light{
    
    @discardableResult
    convenience init(name: String, icon: UIImage, isOn: Bool = true){
        
        self.init(context: CoreDataStack.context)
        
        self.name = name
        
        let iconData = icon.jpegData(compressionQuality: 0.75)
        self.iconData = iconData
        self.isOn = isOn
    }
    
    var icon: UIImage?{
        guard let iconData = iconData else {return nil}
        return UIImage(data: iconData)
    }
    
}
