//
//  RegisterView.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/10/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    
    var delegate : RegistrVC? {
        
        didSet {
            self.userPhotoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self.delegate, action: #selector(self.delegate?.chooseImage)))
            self.titleButton.addTarget(self.delegate, action: #selector(self.delegate?.registerButtonClick(button:)), for: .touchUpInside)
        }
    }
    
    lazy var userPhotoImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image =  #imageLiteral(resourceName: "ic_add_a_photo").withRenderingMode(UIImageRenderingMode.alwaysTemplate )
        imageView.tintColor = ORANGE_COLOR
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let titleButton : OZRippleButton = {
        let button = OZRippleButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(ORANGE_COLOR, for: .normal)
        button.setTitle("Registration", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)!
        button.rippleColor = ORANGE_COLOR
        button.rippleBackgroundColor = UIColor.clear
        button.tintColor = UIColor.clear
        return button
    }()
    
    let checkBox : OZCheckBox = {
        let box = OZCheckBox(frame: CGRect.zero)
        box.translatesAutoresizingMaskIntoConstraints = false
        box.isChecked = false
        box.tintColor = ORANGE_COLOR
        box.isUserInteractionEnabled = true
        box.rippleColor = ORANGE_COLOR
        box.rippleBackgroundColor = UIColor.clear
        return box
    }()
    
    let usernameTextField : TapTextField = {
        let textField = TapTextField(frame: CGRect.zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: "Username", attributes: [ NSFontAttributeName : UIFont(name: "Helvetica", size: 15.0)! ,
                                                                                           NSForegroundColorAttributeName : ORANGE_COLOR ])
        textField.attributedPlaceholder = attributedString
        textField.imageView.image = #imageLiteral(resourceName: "ic_perm_identity").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        textField.returnKeyType = .next
        return textField
    }()
    
    let usernameLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.4)
        return view
    }()
    
    let emailTextField : TapTextField = {
        let textField = TapTextField(frame: CGRect.zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: "Email", attributes: [ NSFontAttributeName : UIFont(name: "Helvetica", size: 15.0)! ,
                                                                                           NSForegroundColorAttributeName : ORANGE_COLOR ])
        textField.attributedPlaceholder = attributedString
        textField.imageView.image = #imageLiteral(resourceName: "ic_email").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        textField.returnKeyType = .next
        return textField
    }()
    
    let emailLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.4)
        return view
    }()
    
    
    let passwordTextField : TapTextField = {
        let textField = TapTextField(frame: CGRect.zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: "Passsword", attributes: [ NSFontAttributeName : UIFont(name: "Helvetica", size: 15.0)! ,
                                                                                            NSForegroundColorAttributeName : ORANGE_COLOR ])
        textField.attributedPlaceholder = attributedString
        textField.isSecureTextEntry = true
        textField.imageView.image = #imageLiteral(resourceName: "ic_visibility").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        textField.returnKeyType = .go
        return textField
    }()
    
    let passwordLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.4)
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
        
        // add userPhoto contraints
        self.addSubview(self.userPhotoImageView)
        
        self.userPhotoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.userPhotoImageView.topAnchor.constraint(equalTo: self.topAnchor , constant : 10.0).isActive = true
        self.userPhotoImageView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        self.userPhotoImageView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        // add username textfield contraints
        self.addSubview(self.usernameTextField)
        self.addSubview(self.usernameLineView)
        
        self.usernameTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.usernameTextField.topAnchor.constraint(equalTo: self.userPhotoImageView.bottomAnchor, constant : 10.0 ).isActive = true
        self.usernameTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.usernameTextField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        self.usernameLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0).isActive = true
        self.usernameLineView.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 5.0).isActive = true
        self.usernameLineView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20.0).isActive = true
        self.usernameLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        // add email textfield contraints
        self.addSubview(self.emailTextField)
        self.addSubview(self.emailLineView)
        
        self.emailTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.emailTextField.topAnchor.constraint(equalTo: self.usernameLineView.bottomAnchor , constant : 10.0 ).isActive = true
        self.emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        self.emailLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0).isActive = true
        self.emailLineView.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 5.0).isActive = true
        self.emailLineView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20.0).isActive = true
        self.emailLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        // add password textfield contraints
        self.addSubview(self.passwordTextField)
        self.addSubview(self.passwordLineView)
        
        self.passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.passwordTextField.topAnchor.constraint(equalTo: self.emailLineView.bottomAnchor , constant : 10.0 ).isActive = true
        self.passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        self.passwordLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0).isActive = true
        self.passwordLineView.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 5.0).isActive = true
        self.passwordLineView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20.0).isActive = true
        self.passwordLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        // title label constraints
        self.addSubview(self.titleButton)
        self.titleButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant : 30.0).isActive = true
        self.titleButton.topAnchor.constraint(equalTo: self.passwordLineView.bottomAnchor).isActive = true
        self.titleButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -60.0).isActive = true
        self.titleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // title label constraints
        self.addSubview(self.checkBox)
        self.checkBox.leftAnchor.constraint(equalTo: self.leftAnchor, constant : 10.0).isActive = true
        self.checkBox.centerYAnchor.constraint(equalTo: self.titleButton.centerYAnchor).isActive = true
        self.checkBox.widthAnchor.constraint(equalToConstant : 25.0).isActive = true
        self.checkBox.heightAnchor.constraint(equalToConstant : 25.0).isActive = true
        
    }
    
    
}








