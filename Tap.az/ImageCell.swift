//
//  ImageCell.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/9/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    var delegate : UIViewController?
    
    lazy var  imageView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.contentMode = .scaleAspectFill
        view.tintColor = ORANGE_COLOR
        view.addCorner(radius: 4.0 , borderWidth: 0.0 , color: UIColor.clear)
        view.isUserInteractionEnabled = true
        return view
    }()

    
    let deleteButton : UIButton = {
        let view =  UIButton(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(#imageLiteral(resourceName: "ic_delete").withRenderingMode(.alwaysTemplate), for: .normal)
        view.tintColor = ORANGE_COLOR
        view.isUserInteractionEnabled = true
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
    
        self.addSubview(self.imageView)
        self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive  = true
        self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive  = true
        
        self.addSubview(self.deleteButton)
        self.deleteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant : -5.0).isActive = true
        self.deleteButton.topAnchor.constraint(equalTo: self.topAnchor , constant : 5.0 ).isActive = true
        self.deleteButton.widthAnchor.constraint(equalToConstant : 20.0).isActive = true
        self.deleteButton.heightAnchor.constraint(equalToConstant : 20.0).isActive = true
        
    }
    
}
