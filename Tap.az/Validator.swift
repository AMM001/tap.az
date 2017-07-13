//
//  Validator.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/11/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import Foundation

class Validator {

    static func isInValidUsername(text:String) -> Bool {
        let RegEx = "\\A\\w{7,18}\\z"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: text)
    }
    
    static func isInValidEmail(text:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
    static func isInValidPassword(text : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: text)
    }
    
}

