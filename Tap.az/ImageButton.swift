//
//  ImageButton.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/20/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class ImageButton : OZRippleButton {

    let customImageView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.tintColor = ORANGE_COLOR
        return view
    }()
    
    let customTitleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.textColor = ORANGE_COLOR
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews () {
        // 1
        self.addSubview(self.customImageView)
        self.customImageView.frame = CGRect(x: 8.0, y: 0.0 , width: self.frame.height / 2.0 , height: self.frame.height / 2.0)
        self.customImageView.center.y = self.frame.height / 2.0
        
        // 2
        self.addSubview(self.customTitleLabel)
        self.customTitleLabel.frame = CGRect(x: self.customImageView.frame.maxX + 8.0 , y: 0.0 , width: self.frame.width - (self.customImageView.frame.maxX + 8.0), height: self.customImageView.frame.height)
        self.customTitleLabel.center.y = self.frame.height / 2.0
        
    }
    
}


