//
//  TapTextField.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/11/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class TapTextField: UITextField {

    let imageView : UIImageView = {
        let iv = UIImageView(frame: CGRect.zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv .tintColor = ORANGE_COLOR
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews () {
        
        self.textColor = ORANGE_COLOR
        self.tintColor = ORANGE_COLOR
        
        let paddingView = UIView(frame: CGRect.zero)
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(paddingView)
        // x , y , w, h 
        paddingView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        paddingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        paddingView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        paddingView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    
        paddingView.addSubview(self.imageView)
        
        self.imageView.leftAnchor.constraint(equalTo: paddingView.leftAnchor , constant : 8.0).isActive = true
        self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor ,constant : -3.0).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        
        self.leftViewMode = UITextFieldViewMode.always
        self.leftView = paddingView

    }
    

}
