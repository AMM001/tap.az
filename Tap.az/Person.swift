//
//  User.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/16/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

// PERSON INHERITANCE HIERARCHY
class Person : Object {

    dynamic var name : String? = nil
    
}

class User : Person {

    dynamic var id : String? = nil
    dynamic var email : String? = nil
    dynamic var password : String? = nil
    dynamic var imageData : Data? = nil
    
}






