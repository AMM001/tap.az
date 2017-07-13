//
//  User+CoreDataProperties.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 7/14/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageData: NSData?
    @NSManaged public var password: String?
    @NSManaged public var email: String?

}
