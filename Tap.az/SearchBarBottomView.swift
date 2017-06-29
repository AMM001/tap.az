//
//  SearchBarBottomView.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/20/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class SearchBarBottomView: UIView {
    
    var delegate : HomeVC? {
        didSet {
            self.allCategoryButton.addTarget(self.delegate, action: #selector(self.delegate?.handleCategorys) , for: .touchUpInside)
        }
    }

    let allCategoryButton : ImageButton = {
        let button = ImageButton()
        button.customImageView.image = #imageLiteral(resourceName: "ic_filter_list").withRenderingMode(.alwaysTemplate)
        button.customTitleLabel.text = "Bütün kateqoriyalar"
        return button
    }()
    
    let allCountryButton : ImageButton = {
        let button = ImageButton()
        button.customImageView.image = #imageLiteral(resourceName: "ic_room").withRenderingMode(.alwaysTemplate)
        button.customTitleLabel.text = "Bütün şəhərlər"
        button.customTitleLabel.font = UIFont.systemFont(ofSize: 12.0)
        return button
    }()
    
    let filterButton : ImageButton = {
        let button = ImageButton()
        button.customImageView.image = #imageLiteral(resourceName: "ic_tune").withRenderingMode(.alwaysTemplate)
        button.customTitleLabel.text = "Filtrlər"
        button.customTitleLabel.font = UIFont.systemFont(ofSize: 12.0)
        return button
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
        self.addSubview(self.allCategoryButton)
        self.allCategoryButton.frame  = CGRect(x: 0.0 , y: 0.0 , width: self.frame.width , height: self.frame.height / 2.0)
        self.allCategoryButton.setupViews()
    
        // 2
        let line1 = UIView(frame: CGRect(x: 2.0 , y: self.allCategoryButton.frame.maxY , width: self.frame.width - 4.0 , height: 0.6))
        line1.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.6)
        self.addSubview(line1)
        
        // 3
        self.addSubview(self.allCountryButton)
        self.allCountryButton.frame = CGRect(x: 0.0 , y: line1.frame.maxY , width: self.frame.width - 120.0, height: (self.frame.height - 1) / 2.0)
        self.allCountryButton.setupViews()
        
        // 4
        let line2 = UIView(frame: CGRect(x: self.allCountryButton.frame.maxX , y: line1.frame.maxY , width: 0.6 , height: self.allCountryButton.frame.height ))
        line2.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.6)
        self.addSubview(line2)
        
        // 5
        self.addSubview(self.filterButton)
        self.filterButton.frame = CGRect(x: line2.frame.maxX , y: self.allCountryButton.frame.minY , width: 118.0, height: self.allCountryButton.frame.height)
        self.filterButton.setupViews()
        
    }
    

}






