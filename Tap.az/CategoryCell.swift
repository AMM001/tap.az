//
//  CategoryCell.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/10/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let titleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.gray
        view.font = UIFont(name: HELVETICA_NEUE , size: 16.0)
        return view
    }()
    
    let accesorryImageView : UIImageView = {
        
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "ic_navigate_next").withRenderingMode(.alwaysTemplate)
        view.tintColor = ORANGE_COLOR
        return view
        
    }()
    
    
    let countLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.gray
        view.font = UIFont(name: HELVETICA_NEUE , size: 16.0)
        view.textAlignment = .right
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
        self.addSubview(self.imageView)
        self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant : 20.0).isActive  = true
        self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.heightAnchor , multiplier : 1/2).isActive = true
        self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor , multiplier : 1/2).isActive = true
        
        //2
        self.addSubview(self.titleLabel)
        self.titleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor , constant : 20.0).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant : 200.0).isActive = true
        self.titleLabel.heightAnchor.constraint(equalTo: self.imageView.heightAnchor).isActive = true
        
        // 3 
        self.addSubview(self.accesorryImageView)
        self.accesorryImageView.rightAnchor.constraint(equalTo: self.rightAnchor , constant : -8.0).isActive = true
        self.accesorryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.accesorryImageView.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier : 1/2).isActive = true
        self.accesorryImageView.heightAnchor.constraint(equalTo: self.imageView.heightAnchor , multiplier : 1/2 ).isActive = true
        
        // 4 
        self.addSubview(self.countLabel)
        self.countLabel.rightAnchor.constraint(equalTo: self.accesorryImageView.leftAnchor , constant : -8.0).isActive = true
        self.countLabel.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
        self.countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.countLabel.heightAnchor.constraint(equalTo: self.titleLabel.heightAnchor).isActive = true
        
    
    }
    
    
    
}








