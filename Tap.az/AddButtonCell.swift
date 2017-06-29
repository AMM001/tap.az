//
//  AddButtonCell.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/28/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class AddButtonCell: UITableViewCell {
    
    var delegate : UIViewController? {
    
        didSet {
        
            if let controller = delegate as? NewAdVC {
            
                self.sendButton.addTarget(controller , action: #selector(controller.sendButton(sender:)), for: .touchUpInside)
            }
        
        }
    
    }


    let sendButton  : OZRippleButton = {
        let view = OZRippleButton(frame: CGRect.zero)
        view.rippleBackgroundColor = ORANGE_COLOR.withAlphaComponent(0.3)
        view.rippleColor = ORANGE_COLOR.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.shadow = true
        view.backgroundColor = String.hexStringToUIColor(hex: "#00796b")
        view.addShadow(shadowColor: UIColor.gray.cgColor , shadowOffset: CGSize(width: 1.0 , height: 1.0 ), shadowOpacity: 1.0, shadowRadius: 1.0)
        view.layer.masksToBounds = false
        view.setTitle("ƏLAVƏ ET", for: .normal)
        view.setTitleColor(UIColor.white , for: .normal)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func setupViews () {
    
        self.backgroundColor = ORANGE_COLOR
        self.selectionStyle = .none
        
        // 1
        self.addSubview(self.sendButton)
        
        self.sendButton.addCorner(radius: 4.0 , borderWidth: 0.0 , color: .white)
        self.sendButton.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 5.0 ).isActive = true
        self.sendButton.topAnchor.constraint(equalTo: self.topAnchor , constant : 20.0 ).isActive = true
        self.sendButton.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -10.0 ).isActive = true
        self.sendButton.heightAnchor.constraint(equalTo: self.heightAnchor , constant : -40.0 ).isActive = true
      
    }
    
    
}
