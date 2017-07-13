//
//  RegisterView.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/12/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    
    var delegate : UIViewController? {
    
        didSet {
            
            if let controller = self.delegate as? RegisterVC {
        
                self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(controller.chooseImage(gesture:))))
                self.registerButton.addTarget(controller , action: #selector(controller.registerButtonClicked(sender:)) , for: .touchUpInside)
            }
        
        }
    
    }

    let imageView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.isUserInteractionEnabled = true 
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "ic_add_a_photo").withRenderingMode(.alwaysTemplate)
        view.tintColor = ORANGE_COLOR
        return view
    }()
    
    
    let usernameTextField : TapTextField = {
        
        let view = TapTextField(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Username"
        view.imageView.image = #imageLiteral(resourceName: "ic_perm_identity").withRenderingMode(.alwaysTemplate)
        view.returnKeyType = .next
        return view
        
    }()
    
    
    let emailTextField : TapTextField = {
        
        let view = TapTextField(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "E-mail"
        view.imageView.image = #imageLiteral(resourceName: "ic_email").withRenderingMode(.alwaysTemplate)
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
    
    let registerButton : OZRippleButton = {
        let view = OZRippleButton(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Register", for: .normal)
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
    
    func setupViews () {
    
        // 1
        self.addSubview(self.imageView)
        self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor , constant : 8.0).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        // 2
        self.addSubview(self.usernameTextField)
        self.usernameTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.usernameTextField.topAnchor.constraint(equalTo: self.imageView.bottomAnchor , constant : 8.0).isActive = true
        self.usernameTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.usernameTextField.heightAnchor.constraint(equalToConstant : 50.0).isActive = true
        
        // 3
        self.addSubview(self.emailTextField)
        self.emailTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.emailTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor).isActive = true
        self.emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant : 50.0).isActive = true
        
        // 4
        self.addSubview(self.passwordTextField)
        self.passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor).isActive = true
        self.passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant : 50.0).isActive = true
    
        //5
        self.addSubview(self.registerButton)
        self.registerButton.leftAnchor.constraint(equalTo: self.leftAnchor ).isActive = true
        self.registerButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor).isActive = true
        self.registerButton.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.registerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
      
        //6
        self.addSubview(self.checkBox)
        self.checkBox.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 14.0).isActive = true
        self.checkBox.centerYAnchor.constraint(equalTo: self.registerButton.centerYAnchor).isActive = true
        self.checkBox.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        self.checkBox.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        
   
    }
    
    

}









