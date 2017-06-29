
//
//  ActivityIndicatorView.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/22/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class ActivityIndicatorView : UIView {

    let activityIndicator : OZActivityIndicator = {
        let view = OZActivityIndicator()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.strokeColor = ORANGE_COLOR
        view.lineWidth = 3.0
        view.rotationDuration = 3.0
        view.tintColor = UIColor.white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupViews () {
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        // 1
        self.addSubview(self.activityIndicator)
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.activityIndicator.widthAnchor.constraint(equalToConstant : 40.0).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant : 40.0).isActive = true
        self.activityIndicator.isHidden = true
        
    }
    

}








