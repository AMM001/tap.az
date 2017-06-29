//
//  UserCell.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/28/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    var delegete : UIViewController?
    
    
    let designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let nameTitleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = TEXT_COLOR_BLUE
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.text = "Adiniz"
        return view
    }()
    
    let nameTextField : UITextField = {
        let view = UITextField(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder =  NSMutableAttributedString(string: "...", attributes: [ NSFontAttributeName : UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)! ,
                                                                                             NSForegroundColorAttributeName : TEXT_COLOR_BLUE ])
        view.textColor = TEXT_COLOR_BLUE
        return view
    }()
    
    let nameLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.5)
        return view
    }()
    
    let emailTitleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = TEXT_COLOR_BLUE
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.text = "E-mail"
        return view
    }()
    
    let emailTextField : UITextField = {
        let view = UITextField(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder =  NSMutableAttributedString(string: "...", attributes: [ NSFontAttributeName : UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)! ,
                                                                                             NSForegroundColorAttributeName : TEXT_COLOR_BLUE ])
        view.textColor = TEXT_COLOR_BLUE
        return view
    }()
    
    let emailLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.5)
        return view
    }()
    
    let phoneTitleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = TEXT_COLOR_BLUE
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.text = "Telefon"
        return view
    }()
    
    let phoneTextField : UITextField = {
        let view = UITextField(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder =  NSMutableAttributedString(string: "...", attributes: [ NSFontAttributeName : UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)! ,
                                                                                             NSForegroundColorAttributeName : TEXT_COLOR_BLUE ])
        view.textColor = TEXT_COLOR_BLUE
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        self.addSubview(self.nameTitleLabel)
        self.nameTitleLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.nameTitleLabel.topAnchor.constraint(equalTo: self.designView.topAnchor , constant : 5.0 ).isActive = true
        self.nameTitleLabel.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.nameTitleLabel.heightAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        
        // 3
        self.addSubview(self.nameTextField)
        self.nameTextField.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.nameTextField.topAnchor.constraint(equalTo: self.nameTitleLabel.bottomAnchor , constant : 1.0 ).isActive = true
        self.nameTextField.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.nameTextField.heightAnchor.constraint(equalTo: self.designView.heightAnchor , multiplier:  1/5 ).isActive = true
        
        // 4
        self.addSubview(self.nameLineView)
        self.nameLineView.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 5.0 ).isActive = true
        self.nameLineView.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor ).isActive = true
        self.nameLineView.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -10.0 ).isActive = true
        self.nameLineView.heightAnchor.constraint(equalToConstant : 1.0 ).isActive = true
   
        // 5
        self.addSubview(self.emailTitleLabel)
        self.emailTitleLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.emailTitleLabel.topAnchor.constraint(equalTo: self.nameLineView.bottomAnchor , constant : 5.0 ).isActive = true
        self.emailTitleLabel.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.emailTitleLabel.heightAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        
        // 6
        self.addSubview(self.emailTextField)
        self.emailTextField.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.emailTextField.topAnchor.constraint(equalTo: self.emailTitleLabel.bottomAnchor , constant : 1.0 ).isActive = true
        self.emailTextField.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.emailTextField.heightAnchor.constraint(equalTo: self.designView.heightAnchor , multiplier:  1/5 ).isActive = true
        
        // 7
        self.addSubview(self.emailLineView)
        self.emailLineView.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 5.0 ).isActive = true
        self.emailLineView.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor ).isActive = true
        self.emailLineView.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -10.0 ).isActive = true
        self.emailLineView.heightAnchor.constraint(equalToConstant : 1.0 ).isActive = true
    
        
        // 5
        self.addSubview(self.phoneTitleLabel)
        self.phoneTitleLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.phoneTitleLabel.topAnchor.constraint(equalTo: self.emailLineView.bottomAnchor , constant : 5.0 ).isActive = true
        self.phoneTitleLabel.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.phoneTitleLabel.heightAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        
        // 6
        self.addSubview(self.phoneTextField)
        self.phoneTextField.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.phoneTextField.topAnchor.constraint(equalTo: self.phoneTitleLabel.bottomAnchor , constant : 1.0 ).isActive = true
        self.phoneTextField.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.phoneTextField.heightAnchor.constraint(equalTo: self.designView.heightAnchor , multiplier:  1/5 ).isActive = true
        
        let keyboard = MMNumberKeyboard(frame: CGRect.zero)
        print(keyboard.frame)
        keyboard.allowsDecimalPoint = true
        keyboard.delegate = self
        
        self.phoneTextField.inputView = keyboard
    
    }
    
}

extension UserCell : MMNumberKeyboardDelegate {
    
    
    
}










