
//
//  HomeHeaderView.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/6/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class HomeHeaderView: UICollectionReusableView {
    
    var delegate : UIViewController? {

        didSet {
            
            if let controller = self.delegate as? HomeVC  {
            
                self.allCategoryButton.addTarget(controller , action: #selector(controller.pushToCategoryController(sender:)), for: .touchUpInside)
            
            }
            
        }

    }
    
    let designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.addCorner(radius: 4.0, borderWidth: 0.0 , color: ORANGE_COLOR)
        return view
    }()
    
    let allCategoryButton : ImageButton = {
        let view = ImageButton(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.customImageView.image = #imageLiteral(resourceName: "ic_filter_list").withRenderingMode(.alwaysTemplate)
        view.customImageView.tintColor = ORANGE_COLOR
        view.customTitleLabel.text = "Bütün Kateqoriyalar"
        return view
    }()
    
    private let categoryLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.6)
        return view
    }()
    
    let allCityButton : ImageButton = {
        let view = ImageButton(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.customImageView.image = #imageLiteral(resourceName: "ic_room").withRenderingMode(.alwaysTemplate)
        view.customImageView.tintColor = ORANGE_COLOR
        view.customTitleLabel.text = "Bütün Şəhərlər"
        return view
    }()
    
    private let cityLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.6)
        return view
    }()
    
    let filterButton : ImageButton = {
        let view = ImageButton(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.customImageView.image = #imageLiteral(resourceName: "ic_tune").withRenderingMode(.alwaysTemplate)
        view.customImageView.tintColor = ORANGE_COLOR
        view.customTitleLabel.text = "Filtrlər"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews () {
       

        // 1 
        self.addSubview(self.designView)
        self.designView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        self.designView.topAnchor.constraint(equalTo: self.topAnchor , constant: 50.0).isActive = true
        self.designView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0.0).isActive = true
        self.designView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -5.0).isActive = true
        
        // 2
        self.designView.addSubview(self.allCategoryButton)
        self.allCategoryButton.leftAnchor.constraint(equalTo: self.designView.leftAnchor ).isActive = true
        self.allCategoryButton.topAnchor.constraint(equalTo: self.designView.topAnchor ).isActive = true
        self.allCategoryButton.widthAnchor.constraint(equalTo: self.designView.widthAnchor ).isActive = true
        self.allCategoryButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        // 3
        self.designView.addSubview(self.categoryLineView)
        self.categoryLineView.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant: 2.0).isActive = true
        self.categoryLineView.topAnchor.constraint(equalTo: self.allCategoryButton.bottomAnchor , constant : 1.0).isActive = true
        self.categoryLineView.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant: -4.0).isActive = true
        self.categoryLineView.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
        
        // 4
        self.designView.addSubview(self.allCityButton)
        self.allCityButton.leftAnchor.constraint(equalTo: self.designView.leftAnchor ).isActive = true
        self.allCityButton.topAnchor.constraint(equalTo: self.categoryLineView.bottomAnchor , constant : 1.0 ).isActive = true
        self.allCityButton.widthAnchor.constraint(equalTo: self.designView.widthAnchor , multiplier : 1/1.6 ).isActive = true
        self.allCityButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
   
        // 5 
        self.designView.addSubview(self.cityLineView)
        self.cityLineView.leftAnchor.constraint(equalTo: self.allCityButton.rightAnchor, constant: 0.0).isActive = true
        self.cityLineView.topAnchor.constraint(equalTo: self.categoryLineView.bottomAnchor , constant: 1.0 ).isActive = true
        self.cityLineView.widthAnchor.constraint(equalToConstant: 0.6).isActive = true
        self.cityLineView.bottomAnchor.constraint(equalTo: self.designView.bottomAnchor , constant: -1.0).isActive = true
        
        // 6
        self.designView.addSubview(self.filterButton)
        self.filterButton.leftAnchor.constraint(equalTo: self.cityLineView.rightAnchor ).isActive = true
        self.filterButton.topAnchor.constraint(equalTo: self.categoryLineView.bottomAnchor , constant : 1.0 ).isActive = true
        self.filterButton.rightAnchor.constraint(equalTo: self.designView.rightAnchor).isActive = true
        self.filterButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
    }
    
    
}




