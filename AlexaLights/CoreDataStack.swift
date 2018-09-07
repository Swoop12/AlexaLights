//
//  CoreDataStack.swift
//  AlexaLights
//
//  Created by DevMountain on 9/6/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack{
    
    //The Entire CoreData Stack (The Whole Enchilada)
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AlexaLights")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error{
                fatalError("Failed to load data from persistent stores")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext{
        return container.viewContext
    }
}
