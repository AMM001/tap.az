//
//  IndicatorView.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/11/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class IndicatorView: UIView {

    let activityIndicator : OZActivityIndicator = {
        let view = OZActivityIndicator(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.lineWidth = 4.0
        view.tintColor = ORANGE_COLOR
        view.strokeColor = ORANGE_COLOR
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews () {
        
        // 1
        self.addSubview(self.activityIndicator)
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.activityIndicator.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
    }


}
