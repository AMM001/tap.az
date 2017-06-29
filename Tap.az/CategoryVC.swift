//
//  CategoryVC.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/21/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    lazy var categoryView : CategoryView = {
    
        var view = CategoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.shadow = true
        return view

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews () {
        self.setupNavBar()
        self.setupCategoryView()
    }
    
    private func setupNavBar () {
        
        let pageTitleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: FRAME.size.width / 3.0 , height: 30.0))
        pageTitleLabel.textColor = UIColor.white
        pageTitleLabel.text = "Kateqoriya"
        pageTitleLabel.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        self.navigationItem.titleView = pageTitleLabel
        
    }

    fileprivate func setupCategoryView () {
    
        // 1
        self.view.addSubview(self.categoryView)
        
        self.categoryView.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant : 10.0).isActive = true
        self.categoryView.topAnchor.constraint(equalTo: self.view.topAnchor ).isActive = true
        self.categoryView.widthAnchor.constraint(equalTo: self.view.widthAnchor , constant : -20.0).isActive = true
        self.categoryView.heightAnchor.constraint(equalTo: self.view.heightAnchor , constant : -10.0).isActive = true
       
    }
    
    
}






















