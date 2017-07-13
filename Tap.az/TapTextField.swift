//
//  TapTextField.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/11/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class TapTextField: UITextField {

    let imageView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = ORANGE_COLOR
        return view
    }()
    
    let lineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
   
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews () {
        
        self.tintColor = ORANGE_COLOR
        self.textColor = ORANGE_COLOR

        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.leftAnchor.constraint(equalTo: self.leftAnchor ).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.widthAnchor.constraint(equalToConstant : 50.0).isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        self.leftViewMode = .always
        self.leftView = view
    
        // 1
        view.addSubview(self.imageView)
        self.imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor , constant : -1.0).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 25.0).isActive = true

        // 2
        self.addSubview(self.lineView)
        self.lineView.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 5.0).isActive = true
        self.lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.lineView.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -10.0).isActive = true
        self.lineView.heightAnchor.constraint(equalToConstant : 1.0).isActive = true
        
        
    
    }
    
}
