//
//  ImageButton.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/7/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class ImageButton: OZRippleButton {
    
    let customImageView : UIImageView =  {
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let customTitleLabel  : UILabel =  {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = ORANGE_COLOR.withAlphaComponent(0.8)
        view.font = UIFont(name: HELVETICA_NEUE , size: 14.0)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews () {
                
        self.rippleBackgroundView.backgroundColor = UIColor.clear
        self.rippleColor = ORANGE_COLOR.withAlphaComponent(0.2)
        
        // 1
        self.addSubview(self.customImageView)
        self.customImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0).isActive = true
        self.customImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor ).isActive = true
        self.customImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier : 1/2).isActive = true
        self.customImageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier : 1/2 ).isActive = true
        
        // 2
        self.addSubview(self.customTitleLabel)
        self.customTitleLabel.leftAnchor.constraint(equalTo: self.customImageView.rightAnchor, constant: 8.0).isActive = true
        self.customTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor ).isActive = true
        self.customTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor ).isActive = true
        self.customTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier : 1/2 ).isActive = true
    
    }
    
    
}







