//
//  DetailHeaderView.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/8/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class DetailHeaderView: UICollectionReusableView {
    
    var imageCarusel : ImageCarouselView = {
        let view = ImageCarouselView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.showPageControl = true
        view.currentPageColor = UIColor.white
        view.pageColor = ORANGE_COLOR
        return view
    }()

    let priceLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        view.text = "21 000 AZN"
        view.font = UIFont(name: "AvenirNext-Bold", size: 15.0)
        view.textAlignment = .center
        view.textColor = UIColor.white.withAlphaComponent(0.6)
        return view
    }()
    
    let titleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        view.text = "MERCEDES-BENZ C320"
        view.font = UIFont(name: "Avenir", size: 15.0)
        view.textAlignment = .center
        view.textColor = UIColor.white.withAlphaComponent(0.6)
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
    
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        // 1
        self.addSubview(self.imageCarusel)
        self.imageCarusel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.imageCarusel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageCarusel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.imageCarusel.heightAnchor.constraint(equalTo: self.heightAnchor, constant : -50.0).isActive = true
        
        // 2
        self.addSubview(self.priceLabel)
        self.priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.priceLabel.topAnchor.constraint(equalTo: self.imageCarusel.bottomAnchor).isActive = true
        self.priceLabel.widthAnchor.constraint(equalTo: self.widthAnchor , multiplier : 1/3).isActive = true
        self.priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // 3
        self.addSubview(self.titleLabel)
        self.titleLabel.leftAnchor.constraint(equalTo: self.priceLabel.rightAnchor , constant : 1.0).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.imageCarusel.bottomAnchor).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor ).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
    
}
