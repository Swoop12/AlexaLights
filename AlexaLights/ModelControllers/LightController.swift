//
//  LightController.swift
//  AlexaLights
//
//  Created by DevMountain on 9/6/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit
import CoreData

class LightController{
    
    // Shared Instance (Singleton)
    static let shared = LightController()
    private init(){}
    
    //Source of Truth
    var mockLights: [Light]{
        let kitchen = Light(name: "Kitchen", icon: UIImage(named: "kitchen")!)
        let office = Light(name: "Office", icon: UIImage(named: "office")!)
        let livingRoom = Light(name: "Living Room", icon: UIImage(named: "livingRoom")!)
        let laundryRoom = Light(name: "Laundry Room", icon: UIImage(named: "LaundryRoom")!)
        let boomBoomRoom = Light(name: "Bedroom", icon: UIImage(named: "bedroom")!)
        saveToPersistentStore()
        return [kitchen, office, livingRoom, laundryRoom, boomBoomRoom]
    }
    
    //CRUD
    func createLightWith(name: String, icon: UIImage){
        Light(name: name, icon: icon)
        saveToPersistentStore()
    }
    
    func delete(light: Light){
        light.managedObjectContext?.delete(light)
        saveToPersistentStore()
    }
    
    
    //Save
    func saveToPersistentStore(){
        do{
            try CoreDataStack.context.save()
        }catch {
            print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
        }
    }
    
}
