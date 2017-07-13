//
//  PersistenseManager.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/13/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import Foundation
import CoreData

class PersistenseManager {

    init() { }
    
    static var context : NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    static var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "tap_az")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}
