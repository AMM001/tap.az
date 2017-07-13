//
//  Parser.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/2/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import Foundation

class Parser {

    class func parseLocalFile (resourse : String? , type : String? , completion : @escaping  ( _ json : Any)->() ) {
    
        if let file = Bundle.main.path(forResource: resourse , ofType: type) {

            if let data = try? NSData(contentsOfFile: file , options: .dataReadingMapped)  {
            
                if let json = try? JSONSerialization.jsonObject(with: data as Data , options: .mutableContainers) {
                
                    completion(json)
                    
                }
            
            }
        
        }

    }

}
