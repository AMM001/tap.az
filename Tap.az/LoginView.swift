//
//  LoginView.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/11/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var delegate : UIViewController? {
    
        didSet {
 
            if let controller = self.delegate as? LoginVC {
                
                self.loginButton.addTarget(controller , action: #selector(controller.handleLogin(sender:)), for: .touchUpInside)
                
            }
        
        }
        
    }
    
    let usernameTextField : TapTextField = {
    
        let view = TapTextField(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Username"
        view.imageView.image = #imageLiteral(resourceName: "ic_perm_identity").withRenderingMode(.alwaysTemplate)
        view.returnKeyType = .next
        return view
        
    }()
    
    let passwordTextField : TapTextField = {
        
        let view = TapTextField(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Passsword"
        view.imageView.image = #imageLiteral(resourceName: "ic_visibility").withRenderingMode(.alwaysTemplate)
        view.isSecureTextEntry = true
        view.returnKeyType = .done
        return view
        
    }()

    let loginButton : OZRippleButton = {
        let view = OZRippleButton(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Login", for: .normal)
        view.setTitleColor(ORANGE_COLOR, for: .normal)
        view.titleLabel?.font = UIFont(name: HELVETICA_NEUE_BOLD , size: 18.0)
        return view
    }()
    
    let checkBox : OZCheckBox = {
        let view = OZCheckBox(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = ORANGE_COLOR
        view.isChecked = false
        view.addCorner(radius: 4.0, borderWidth: 0.0, color: UIColor.clear)
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
        self.addSubview(self.usernameTextField)
        self.usernameTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.usernameTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.usernameTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.usernameTextField.heightAnchor.constraint(equalTo: self.heightAnchor , multiplier : 1/3).isActive = true
        
        // 2
        self.addSubview(self.passwordTextField)
        self.passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor).isActive = true
        self.passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalTo: self.usernameTextField.heightAnchor).isActive = true
        
        //3
        self.addSubview(self.loginButton)
        self.loginButton.leftAnchor.constraint(equalTo: self.leftAnchor ).isActive = true
        self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor).isActive = true
        self.loginButton.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        //4 
        self.addSubview(self.checkBox)
        self.checkBox.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 14.0).isActive = true
        self.checkBox.centerYAnchor.constraint(equalTo: self.loginButton.centerYAnchor).isActive = true
        self.checkBox.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        self.checkBox.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        
    }
    
}





















