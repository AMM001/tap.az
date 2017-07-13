//
//  SideBarCell.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/7/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class SideBarCell: UITableViewCell {
    
    var customImageView : UIImageView?
    var customTitleLabel : UILabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews () {
    
        self.customImageView = UIImageView(frame: CGRect(x: 8.0 , y: 0.0 , width: frame.size.height / 2.0 , height:  frame.size.height / 2.0))
        self.customImageView?.center.y = self.center.y
        self.addSubview(self.customImageView!)
        
        self.customTitleLabel = UILabel(frame: CGRect(x: self.customImageView!.frame.maxX + 8.0 , y: self.customImageView!.frame.minY , width: 100.0 , height: self.customImageView!.frame.height))
        self.customTitleLabel?.center.y = self.center.y
        self.customTitleLabel?.font = UIFont(name: "Avenir", size: 12.0)
        self.customTitleLabel?.textColor = UIColor.black
        self.addSubview(self.customTitleLabel!)
        
        
    }
    
    
}
