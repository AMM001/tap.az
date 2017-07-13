//
//  HomeCell.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/2/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    var controller : UIViewController? {
    
        didSet {
            
        }
    
    }
    
    var ad : Ad? {
    
        didSet {
            self.shareData()
        }
        
    }
        
    let desigView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(shadowColor: UIColor.gray.withAlphaComponent(0.5 ).cgColor , shadowOffset: CGSize(width: 2.0, height: 2.0 ), shadowOpacity: 2.0 , shadowRadius: 1.0)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let imageView : ImageView = {
        let view = ImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let titleTextView : UITextView = {
    
        let view = UITextView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR
        view.contentMode = .scaleAspectFill
        view.contentInset = UIEdgeInsets(top: -5.0 , left: 0.0, bottom: 0.0 , right: 0.0)
        view.textColor = UIColor.black.withAlphaComponent(0.8)
        view.font = UIFont(name: HELVETICA_NEUE_BOLD , size: 14.0)
        view.backgroundColor = UIColor.white
        view.isEditable = false
        view.isUserInteractionEnabled = false
        view.text = "Mercedes-Benz c300 \n IL - 2014"
        return view
        
    }()
    
    let timeLabel : UILabel = {
    
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.textColor = UIColor.lightGray
        view.font = UIFont(name: HELVETICA_NEUE , size: 10.0)
        view.text = "Bugun, 11:30"
        return view
        
    }()
    
    let loactionLabel : UILabel = {
        
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.textColor = UIColor.lightGray
        view.font = UIFont(name: HELVETICA_NEUE , size: 10.0)
        view.text = "Baki"
        view.textAlignment = .right
        return view
        
    }()
    
    let priceLabel : UILabel = {
        
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.textColor = UIColor.white
        view.font = UIFont(name: HELVETICA_NEUE, size: 13.0)
        view.text = "1.000 AZN"
        view.backgroundColor = ORANGE_COLOR
        view.textAlignment = .center
        return view
        
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.desigView.fadeOut(duration: 0.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews () {
    
        self.addCorner(radius: 4.0, borderWidth: 1.0, color: GREEN_COLOR.withAlphaComponent(0.4))
        self.backgroundColor = UIColor.white
        
        // 1 
        self.addSubview(self.desigView)
        self.desigView.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 4.0).isActive = true
        self.desigView.topAnchor.constraint(equalTo: self.topAnchor , constant : 4.0 ).isActive = true
        self.desigView.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -8.0 ).isActive = true
        self.desigView.heightAnchor.constraint(equalTo: self.heightAnchor , constant : -8.0).isActive = true
        
        // 2 
        self.desigView.addSubview(self.imageView)
        self.imageView.leftAnchor.constraint(equalTo: self.desigView.leftAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.desigView.topAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.desigView.widthAnchor).isActive = true
        self.imageView.heightAnchor.constraint(equalTo: self.desigView.heightAnchor , multiplier : 1/1.6).isActive = true
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(handleZoom)))
        
        // 3
        self.desigView.addSubview(self.titleTextView)
        self.titleTextView.leftAnchor.constraint(equalTo: self.desigView.leftAnchor).isActive = true
        self.titleTextView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor , constant : 1.0).isActive = true
        self.titleTextView.widthAnchor.constraint(equalTo: self.desigView.widthAnchor).isActive = true
        self.titleTextView.heightAnchor.constraint(equalToConstant : 40.0 ).isActive = true
        
        // 4
        self.desigView.addSubview(self.timeLabel)
        self.timeLabel.leftAnchor.constraint(equalTo: self.desigView.leftAnchor , constant : 4.0).isActive = true
        self.timeLabel.topAnchor.constraint(equalTo: self.titleTextView.bottomAnchor , constant : 1.0).isActive = true
        self.timeLabel.widthAnchor.constraint(equalTo: self.desigView.widthAnchor , multiplier : 1/2 ).isActive = true
        self.timeLabel.bottomAnchor.constraint(equalTo : self.desigView.bottomAnchor , constant : -1.0 ).isActive = true
        
        // 5
        self.desigView.addSubview(self.loactionLabel)
        self.loactionLabel.leftAnchor.constraint(equalTo: self.timeLabel.rightAnchor).isActive = true
        self.loactionLabel.topAnchor.constraint(equalTo: self.titleTextView.bottomAnchor , constant : 1.0).isActive = true
        self.loactionLabel.rightAnchor.constraint(equalTo: self.desigView.rightAnchor , constant  : -4.0 ).isActive = true
        self.loactionLabel.bottomAnchor.constraint(equalTo : self.desigView.bottomAnchor , constant : -1.0 ).isActive = true
        
        // 6
        self.imageView.addSubview(self.priceLabel)
        self.priceLabel.leftAnchor.constraint(equalTo: self.imageView.leftAnchor).isActive = true
        self.priceLabel.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        self.priceLabel.widthAnchor.constraint(equalTo: self.imageView.widthAnchor , multiplier  : 1/2 ).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant : 30.0).isActive = true
        
    }
    
    fileprivate func shareData() {
    
        if let imageURLString = self.ad?.image {
            self.imageView.loadImageWithUrl(imageURLString)
        }
        
        if let price = self.ad?.price  {
            self.priceLabel.text = "\(price) AZN"
        }
        
        if let location = self.ad?.location {
            self.loactionLabel.text = location
        }

        if let dateString = self.ad?.date  {
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = Locale(identifier: "en")
            let date = dateFormatter.date(from: dateString)!
            self.timeLabel.text = dateFormatter.string(from: date)
            
        }
        
        if let name = self.ad?.name , let model = self.ad?.model {
            self.titleTextView.text = " \(name) \n \(model)"
        }
    
    }
    
    
    @objc fileprivate func handleZoom (gesture : UITapGestureRecognizer) {
    
        if let imageView = gesture.view as? ImageView {
        
            if let homeController = self.controller as? HomeVC {
    
                homeController.zoomInImageView(startingImageView: imageView)
            
            }
         
        }
    
    }
    
}










