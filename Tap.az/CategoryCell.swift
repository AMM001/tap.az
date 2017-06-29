//
//  CategoryCell.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/21/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    var index : Index? {
        didSet {
            self.shareIndexData()
        }
    }
    
    let cImageView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let cAccesorryView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.image = #imageLiteral(resourceName: "ic_chevron_right").withRenderingMode(.alwaysTemplate)
        view.tintColor = ORANGE_COLOR
        return view
    }()
    
    let countLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Avenir", size: 14.0)
        view.textColor = UIColor.gray.withAlphaComponent(0.5)
        view.textAlignment = .right
        return view
    }()
    
    let titleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Avenir", size: 14.0)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    fileprivate func setupViews () {
    
        // 1
        self.addSubview(self.cImageView)
        self.cImageView.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 20.0).isActive = true
        self.cImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.cImageView.widthAnchor.constraint(equalTo: self.heightAnchor , multiplier : 1/2.5).isActive = true
        self.cImageView.heightAnchor.constraint(equalTo: self.heightAnchor , multiplier : 1/2.5).isActive = true
        
        // 2
        let line = UIView(frame: CGRect.zero)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        self.addSubview(line)
        line.leftAnchor.constraint(equalTo: self.leftAnchor ,constant : 1.0 ).isActive = true
        line.bottomAnchor.constraint(equalTo: self.bottomAnchor ).isActive = true
        line.widthAnchor.constraint(equalTo: self.widthAnchor ,constant : -2.0 ).isActive = true
        line.heightAnchor.constraint(equalToConstant : 0.6 ).isActive = true
    
        // 3
        let selectedBackGroudView = UIView(frame: CGRect(x: 1.0, y: 1.0, width: self.frame.width - 2.0 , height: self.frame.height / 2.0))
        selectedBackGroudView.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.2)
        self.selectedBackgroundView = selectedBackGroudView
        
        //4
        self.addSubview(self.cAccesorryView)
        self.cAccesorryView.rightAnchor.constraint(equalTo: self.rightAnchor , constant : -10.0).isActive = true
        self.cAccesorryView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.cAccesorryView.widthAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        self.cAccesorryView.heightAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        
        // 5
        self.addSubview(self.countLabel)
        self.countLabel.rightAnchor.constraint(equalTo: self.cAccesorryView.leftAnchor , constant : -5 ).isActive = true
        self.countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.countLabel.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        self.countLabel.heightAnchor.constraint(equalTo: self.cImageView.heightAnchor).isActive = true
        
        //6
        self.addSubview(self.titleLabel)
        self.titleLabel.leftAnchor.constraint(equalTo: self.cImageView.rightAnchor , constant : 20.0 ).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.countLabel.leftAnchor).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalTo: self.cImageView.heightAnchor).isActive = true
        
    }
    
    private func shareIndexData () {

        if let image = self.index?.image {
            self.cImageView.image = image
        }
        
        if let count = self.index?.count {
            self.countLabel.text = String(count)
        }
    
        if let title = self.index?.title {
            self.titleLabel.text = title
        }
        
    }
    

}
