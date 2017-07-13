//
//  AddAdCell.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/9/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class AddAdCell: UICollectionViewCell {
    
    var delegate : NewAdVC? {
        
        didSet {
            
            
        }
        
    }

    let designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR
        return view
    }()
    
    
    let sendButton  : OZRippleButton = {
        let view = OZRippleButton(frame: CGRect.zero)
        view.rippleBackgroundColor = ORANGE_COLOR.withAlphaComponent(0.3)
        view.rippleColor = ORANGE_COLOR.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.shadow = true
        view.addShadow(shadowColor: UIColor.gray.cgColor , shadowOffset: CGSize(width: 1.0 , height: 1.0 ), shadowOpacity: 1.0, shadowRadius: 1.0)
        view.layer.masksToBounds = false
        view.backgroundColor = GREEN_COLOR
        view.setTitle("ƏLAVƏ ET", for: .normal)
        view.setTitleColor(UIColor.white , for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews () {
        
        // 1
        self.addSubview(self.designView)
        self.designView.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 5.0 ).isActive = true
        self.designView.topAnchor.constraint(equalTo: self.topAnchor , constant : 2.0 ).isActive = true
        self.designView.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -10.0).isActive = true
        self.designView.heightAnchor.constraint(equalTo: self.heightAnchor , constant : -4.0).isActive = true
        
        // 2
        self.designView.addSubview(self.sendButton)
        self.sendButton.addCorner(radius: 4.0 , borderWidth: 0.0 , color: .white)
        self.sendButton.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 5.0 ).isActive = true
        self.sendButton.topAnchor.constraint(equalTo: self.designView.topAnchor , constant : 20.0 ).isActive = true
        self.sendButton.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -10.0 ).isActive = true
        self.sendButton.heightAnchor.constraint(equalTo: self.designView.heightAnchor , constant : -40.0 ).isActive = true
        
    }
    
    
    
}
