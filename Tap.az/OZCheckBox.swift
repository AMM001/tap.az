//
//  OZCheckBox.swift
//  Car
//
//  Created by Ozal Suleyman on 4/11/17.
//  Copyright © 2017 Ozal Suleyman. All rights reserved.
//

import UIKit

class OZCheckBox: OZRippleButton {
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(#imageLiteral(resourceName: "ic_check_box").withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
            } else {
                self.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank").withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
        
    }
    
}
