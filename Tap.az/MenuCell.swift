
//
//  MenuCell.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/18/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    private lazy var designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        return view
    }()
    
    let designImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.tintColor = UIColor.orange
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let designTitleLabel : UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont(name: "Avenir", size: 12.0)
        label.textColor = UIColor.black
        return label
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
        self.addSubview(self.designView)
        self.designView.frame = CGRect(x: 2.0, y: 1.0, width: self.frame.width - 14.0, height: self.frame.height - 2.0)
        
        // 2
        self.designView.addSubview(self.designImageView)
        self.designImageView.frame = CGRect(x: 8.0, y: 2.0 , width : self.frame.height / 2.0  , height: self.frame.height / 2.0)
        self.designImageView.center.y = self.center.y
        // 3 
        self.designView.addSubview(self.designTitleLabel)
        self.designTitleLabel.frame = CGRect(x: self.designImageView.frame.maxX + 10.0 , y: 0.0 , width: 140.0, height: self.designImageView.frame.height)
        self.designTitleLabel.center.y = self.center.y
        
        let selectedBackGroudView = UIView(frame: self.frame)
        selectedBackGroudView.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.2)
        self.selectedBackgroundView = selectedBackGroudView
        
        
    }
    

}
