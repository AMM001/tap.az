//
//  HomeCell.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/15/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    var controller : UIViewController? {
        didSet{

            self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(tap(gesture:))))
        }
    }
    
    let designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.addShadow(shadowColor: UIColor.lightGray.cgColor , shadowOffset: CGSize(width: 1.0, height: 1.0), shadowOpacity: 0.6 , shadowRadius: 1.0)
        view.layer.borderColor = UIColor.init(white: 0.95, alpha: 0.8).cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    private let imageView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.image = #imageLiteral(resourceName: "mb1")
        return view
    }()
    
    private let priceLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR
        view.font = UIFont.systemFont(ofSize: 12.0)
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.addCorner(radius: 1.0, borderWidth: 0.5, color: UIColor.init(white: 0.9, alpha: 0.8))
        view.text = "1.000.000 AZN"
        return view
    }()
    
    let textView : UITextView  = {
        let view = UITextView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.contentInset = UIEdgeInsets(top: -2.0, left: 1.0, bottom: 5.0, right: 1.0)
        view.text = "Mercedes-Benz c300 \n IL - 2014"
        view.isUserInteractionEnabled = false
        view.isEditable = false
        return view
    }()

    private let timeLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 10.0)
        view.textColor = UIColor.gray
        view.textAlignment = .left
        view.text = "Bugün, 11:30"
        return view
    }()
    
    private let locationLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 10.0)
        view.textColor = UIColor.gray
        view.textAlignment = .right
        view.text = "Bakı"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.designView.fadeOut(duration: 0.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews () {
        
        self.backgroundColor = UIColor.white
       
        // USING GOLDEN RATIO IN MY DESIGN
        
        //1
        self.addSubview(self.designView)
        self.designView.leftAnchor.constraint(equalTo: self.leftAnchor, constant : 3.0).isActive = true
        self.designView.topAnchor.constraint(equalTo: self.topAnchor, constant : 3.0 ).isActive = true
        self.designView.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -6.0).isActive = true
        self.designView.heightAnchor.constraint(equalTo: self.heightAnchor , constant : -6.0).isActive = true
        
        // 2
        self.designView.addSubview(self.imageView)
        self.imageView.leftAnchor.constraint(equalTo: self.designView.leftAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.designView.topAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.designView.widthAnchor).isActive = true
        self.imageView.heightAnchor.constraint(equalTo: self.designView.heightAnchor , multiplier : 1/1.6).isActive = true
     
        // 3
        self.imageView.addSubview(priceLabel)
        self.priceLabel.leftAnchor.constraint(equalTo: self.imageView.leftAnchor).isActive = true
        self.priceLabel.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor , constant: 1.0).isActive = true
        self.priceLabel.widthAnchor.constraint(equalTo: self.imageView.widthAnchor , multiplier : 1/1.6).isActive = true
        self.priceLabel.heightAnchor.constraint(equalTo: self.imageView.heightAnchor , multiplier : 1/4.0).isActive = true
        
        // 4
        self.designView.addSubview(self.textView)
        self.textView.leftAnchor.constraint(equalTo: self.designView.leftAnchor).isActive = true
        self.textView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        self.textView.widthAnchor.constraint(equalTo: self.designView.widthAnchor).isActive = true
        self.textView.bottomAnchor.constraint(equalTo: self.designView.bottomAnchor , constant : -20.0).isActive = true
        
        // 5
        self.designView.addSubview(self.timeLabel)
        self.timeLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 5).isActive = true
        self.timeLabel.topAnchor.constraint(equalTo: self.textView.bottomAnchor).isActive = true
        self.timeLabel.rightAnchor.constraint(equalTo: self.designView.centerXAnchor ).isActive = true
        self.timeLabel.bottomAnchor.constraint(equalTo: self.designView.bottomAnchor ).isActive = true
        
        // 5
        self.designView.addSubview(self.locationLabel)
        self.locationLabel.leftAnchor.constraint(equalTo: self.timeLabel.rightAnchor).isActive = true
        self.locationLabel.topAnchor.constraint(equalTo: self.textView.bottomAnchor).isActive = true
        self.locationLabel.rightAnchor.constraint(equalTo: self.designView.rightAnchor , constant : -5 ).isActive = true
        self.locationLabel.bottomAnchor.constraint(equalTo: self.designView.bottomAnchor ).isActive = true
        
        // 6
        let selectedBackGroudView = UIView(frame: self.frame)
        selectedBackGroudView.backgroundColor = ORANGE_COLOR
        self.selectedBackgroundView = selectedBackGroudView
        
    }
    
    @objc fileprivate func tap (gesture : UITapGestureRecognizer ) {
    
        guard  let imageView = gesture.view as? UIImageView else {
            return
        }
   
        if let controller = self.controller as? HomeVC {
            controller.zoomInImageView(startingImageView: imageView , label: self.priceLabel)
        }
    
    }
    
    
    
}









