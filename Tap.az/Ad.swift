//
//  Ad.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/2/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import Foundation

class Ad {
    
    var country : String?
    var date : String?
    var image : String?
    var location : String?
    var model : String?
    var name : String?
    var price : String?
    var year : String?
    
    init(name : String?  , model : String? , image : String?, location : String? , price: String? , year : String? ,country : String? , date : String?) {
        
        self.name = name
        self.model = model
        self.image = image
        self.location = location
        self.price = price
        self.year = year
        self.country = country
        self.date = date
        
    }
    
}
