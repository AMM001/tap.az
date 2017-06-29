//
//  Incrementer.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/26/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import Foundation
import RealmSwift

class Incrementer  {
    
    func incrementID(object : Object ) -> Int {
        let realm = try! Realm()
        return (realm.objects(Object.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }

}
