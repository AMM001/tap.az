
//
//  AdCategoryCell.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/9/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class AdCategoryCell: UICollectionViewCell {
    
    var delegate : NewAdVC? {
    
        didSet {
        
        }
        
    }
    
    let designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.addCorner(radius: 4.0 , borderWidth: 0.0 , color: .white)
        view.shadow = true
        view.addShadow(shadowColor: UIColor.gray.cgColor , shadowOffset: CGSize(width: 1.0 , height: 1.0 ), shadowOpacity: 1.0, shadowRadius: 1.0)
        view.layer.masksToBounds = false
        return view
    }()
    
    let titleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.textColor = TEXT_COLOR_BLUE
        return view
    }()
    
    let cAccesoryView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.image = #imageLiteral(resourceName: "ic_chevron_right").withRenderingMode(.alwaysTemplate)
        view.tintColor = ORANGE_COLOR
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
        self.designView.addSubview(self.titleLabel)
        self.titleLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 10.0 ).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.designView.topAnchor , constant : 4.0).isActive = true
        self.titleLabel.widthAnchor.constraint(equalTo: self.designView.widthAnchor , multiplier : 1/3 ).isActive = true
        self.titleLabel.heightAnchor.constraint(equalTo: self.designView.heightAnchor , constant : -8.0 ).isActive = true
        
        //3
        self.designView.addSubview(self.cAccesoryView)
        self.cAccesoryView.rightAnchor.constraint(equalTo: self.designView.rightAnchor , constant : -10.0).isActive = true
        self.cAccesoryView.centerYAnchor.constraint(equalTo: self.designView.centerYAnchor).isActive = true
        self.cAccesoryView.widthAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        self.cAccesoryView.heightAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        
        
    }
    
    
}









