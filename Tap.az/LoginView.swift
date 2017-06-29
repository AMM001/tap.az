//
//  LoginView.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/10/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var delegate : LoginVC?
    
    let titleButton : OZRippleButton = {
        let button = OZRippleButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(ORANGE_COLOR, for: .normal)
        button.setTitle("Login", for: .normal)
        button.rippleColor = ORANGE_COLOR
        button.rippleBackgroundColor = UIColor.clear
        button.tintColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)!
        return button
    }()
    
    let usernameTextField : TapTextField = {
        let textField = TapTextField(frame: CGRect.zero)
        textField.imageView.image = #imageLiteral(resourceName: "ic_perm_identity").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.imageView.contentMode = .scaleAspectFill
        let attributedString = NSMutableAttributedString(string: "Username", attributes: [ NSFontAttributeName : UIFont(name: "Helvetica", size: 15.0)! ,
                                                                                        NSForegroundColorAttributeName : ORANGE_COLOR ])
        textField.returnKeyType = .next
        textField.attributedPlaceholder = attributedString
        return textField
    }()
    
    let usernameLineView : UIView = {
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
        textField.imageView.image = #imageLiteral(resourceName: "ic_visibility").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        return textField
    }()
    
    let passwordLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.4)
        return view
    }()
    
    let checkBox : OZCheckBox = {
        let box = OZCheckBox(frame: CGRect.zero)
        box.translatesAutoresizingMaskIntoConstraints = false
        box.isChecked = false
        box.tintColor = ORANGE_COLOR
        box.rippleColor = ORANGE_COLOR
        box.rippleBackgroundColor = UIColor.clear
        box.isUserInteractionEnabled = true
        return box
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews () {
    
        // add username textfield contraints
        self.addSubview(self.usernameTextField)
        self.addSubview(self.usernameLineView)
    
        self.usernameTextField.resignFirstResponder()
        self.usernameTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.usernameTextField.topAnchor.constraint(equalTo: self.topAnchor , constant : 10.0 ).isActive = true
        self.usernameTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.usernameTextField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    
        
        self.usernameLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4.0).isActive = true
        self.usernameLineView.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 4.0).isActive = true
        self.usernameLineView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -8.0).isActive = true
        self.usernameLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        // add password textfield contraints
        self.addSubview(self.passwordTextField)
        self.addSubview(self.passwordLineView)
        
        self.passwordTextField.resignFirstResponder()
        self.passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.passwordTextField.topAnchor.constraint(equalTo: self.usernameLineView.bottomAnchor , constant : 10.0 ).isActive = true
        self.passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        self.passwordLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4.0).isActive = true
        self.passwordLineView.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 4.0).isActive = true
        self.passwordLineView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -8.0).isActive = true
        self.passwordLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        // title label constraints
        self.addSubview(self.titleButton)
        
        self.titleButton.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 30.0).isActive = true
        self.titleButton.topAnchor.constraint(equalTo: self.passwordLineView.bottomAnchor ).isActive = true
        self.titleButton.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -60.0).isActive = true
        self.titleButton.bottomAnchor.constraint(equalTo : self.bottomAnchor ).isActive = true
        
        self.titleButton.addTarget(self.delegate , action: #selector(self.delegate?.loginButtonClick(button:)), for: .touchUpInside)
        

        // title label constraints
        self.addSubview(self.checkBox)
        self.checkBox.leftAnchor.constraint(equalTo: self.leftAnchor, constant : 10.0).isActive = true
        self.checkBox.centerYAnchor.constraint(equalTo: self.titleButton.centerYAnchor).isActive = true
        self.checkBox.widthAnchor.constraint(equalToConstant : 25.0).isActive = true
        self.checkBox.heightAnchor.constraint(equalToConstant : 25.0).isActive = true
    }
    
    
}



