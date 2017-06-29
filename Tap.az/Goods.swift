//
//  Goods.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/20/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Goods : Object {

    dynamic var name : String? = nil
    dynamic var price : String? = nil
    dynamic var owner : Person? = nil

}
