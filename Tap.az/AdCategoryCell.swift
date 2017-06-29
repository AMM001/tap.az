//
//  AdCategoryCell.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/25/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class AdCategoryCell: UITableViewCell {

    var delegate : UIViewController? {
   
        didSet {
        
            if let controller = delegate as? NewAdVC {
            
                self.designView.addGestureRecognizer(UITapGestureRecognizer(target: controller , action: #selector(controller.pushToCategoryVC(gesture:))))
                
            }
        
        }
    
    }
    
    let designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.textColor = TEXT_COLOR_BLUE
        return view
    }()

    let cAccesoryView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.image = #imageLiteral(resourceName: "ic_chevron_right").withRenderingMode(.alwaysTemplate)
        view.tintColor = ORANGE_COLOR
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews () {
        
        self.backgroundColor = ORANGE_COLOR
        self.selectionStyle = .none
        
        // 1
        self.addSubview(self.designView)
        self.designView.backgroundColor = UIColor.white
        self.designView.addCorner(radius: 4.0 , borderWidth: 0.0 , color: .white)
        self.designView.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 5.0 ).isActive = true
        self.designView.topAnchor.constraint(equalTo: self.topAnchor , constant : 2.0 ).isActive = true
        self.designView.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -10.0 ).isActive = true
        self.designView.heightAnchor.constraint(equalTo: self.heightAnchor , constant : -4.0 ).isActive = true
        self.designView.shadow = true
        self.designView.addShadow(shadowColor: UIColor.gray.cgColor , shadowOffset: CGSize(width: 1.0 , height: 1.0 ), shadowOpacity: 1.0, shadowRadius: 1.0)
        self.designView.layer.masksToBounds = false
        
        
        // 2
        self.designView.addSubview(self.titleLabel)
        self.titleLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 10.0 ).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.designView.topAnchor , constant : 4.0).isActive = true
        self.titleLabel.widthAnchor.constraint(equalTo: self.designView.widthAnchor , multiplier : 1/3 ).isActive = true
        self.titleLabel.heightAnchor.constraint(equalTo: self.designView.heightAnchor , constant : -8.0 ).isActive = true
    
        //3
        self.designView.addSubview(self.cAccesoryView)
        self.cAccesoryView.rightAnchor.constraint(equalTo: self.designView.rightAnchor , constant : -10.0).isActive = true
        self.cAccesoryView.centerYAnchor.constraint(equalTo: self.designView.centerYAnchor).isActive = true
        self.cAccesoryView.widthAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        self.cAccesoryView.heightAnchor.constraint(equalToConstant : 20.0 ).isActive = true
    
        let view = UIView(frame: CGRect(x: 30 , y: 30 , width: 30 , height: 30))
        view.backgroundColor = UIColor.white
        self.selectedBackgroundView = view
    
    }

}


