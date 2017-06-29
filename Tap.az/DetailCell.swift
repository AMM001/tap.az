//
//  DetailCell.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/23/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    var detail : Detail?  {
    
        didSet {
    
            self.keyLabel.text = detail?.key
            self.valueLabel.text = detail?.value
            
        }
    
    }
    
    let designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let keyLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Helvetica", size: 14.0)
        return view
    }()
    
    private let valueLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Helvetica", size: 14.0)
        view.textColor = UIColor.lightGray
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.designView.fadeOut(duration: 0.2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews () {
        
        self.backgroundColor = UIColor.white
        
        // 1
        self.addSubview(self.designView)
        self.designView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.designView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.designView.widthAnchor.constraint(equalTo: self.widthAnchor ).isActive = true
        self.designView.heightAnchor.constraint(equalTo: self.heightAnchor ).isActive = true
        
        // 2
        self.addSubview(self.keyLabel)
        self.keyLabel.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 10.0 ).isActive = true
        self.keyLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.keyLabel.widthAnchor.constraint(equalTo: self.widthAnchor , multiplier : 1/3 ).isActive = true
        self.keyLabel.heightAnchor.constraint(equalTo: self.heightAnchor ).isActive = true
        
        // 3
        self.addSubview(self.valueLabel)
        self.valueLabel.leftAnchor.constraint(equalTo: self.keyLabel.rightAnchor , constant : 10.0 ).isActive = true
        self.valueLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.valueLabel.rightAnchor.constraint(equalTo: self.rightAnchor ,constant : -10.0 ).isActive = true
        self.valueLabel.heightAnchor.constraint(equalTo: self.heightAnchor ).isActive = true

        
    }

}







