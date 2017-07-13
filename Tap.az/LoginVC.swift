//
//  LoginVC.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/11/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    lazy var loginView :  LoginView = {
        let view = LoginView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.usernameTextField.delegate = self
        view.passwordTextField.delegate = self
        view.delegate = self 
        view.shadow = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 4.0
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let titleLabel : UILabel = {

        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "tap.az"
        view.font = UIFont(name: HELVETICA_NEUE_BOLD , size: 45.0)
        view.textColor = UIColor.white
        view.textAlignment = .center
        return view
    }()
    
    
    let indicatorView : IndicatorView = {
        let view = IndicatorView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }()
    
    
    let guestButton : UIButton = {
        let view = UIButton(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Qonaq kimi", for: .normal)
        view.titleLabel?.font = UIFont(name: HELVETICA_NEUE, size: 14)
        view.setTitleColor(UIColor.white, for: .normal)
        return view
    }()
    
    
    let registerButton : UIButton = {
        let view = UIButton(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Qeydiyyat", for: .normal)
        view.titleLabel?.font = UIFont(name: HELVETICA_NEUE, size: 14)
        view.setTitleColor(UIColor.white, for: .normal)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginView.fadeIn(duration: 1.0)
    }
    
    fileprivate func setupViews () {
    
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(dismissKeyboard)))
        
        // 1
        self.view.addSubview(self.loginView)
        self.loginView.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant : 20.0 ).isActive = true
        self.loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.loginView.widthAnchor.constraint(equalTo: self.view.widthAnchor ,constant : -40.0).isActive = true
        self.loginView.heightAnchor.constraint(equalToConstant : 150.0).isActive = true
        self.loginView.fadeOut(duration: 0.0)
    
        // 2
        self.view.addSubview(self.titleLabel)
        self.titleLabel.bottomAnchor.constraint(equalTo: self.loginView.topAnchor , constant : -20.0).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.loginView.centerXAnchor).isActive = true
        self.titleLabel.widthAnchor.constraint(equalTo: self.loginView.widthAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalTo: self.loginView.heightAnchor , multiplier : 1/2 ).isActive = true
        
        // 3
        self.view.addSubview(self.guestButton)
        self.guestButton.leftAnchor.constraint(equalTo: self.loginView.leftAnchor ).isActive = true
        self.guestButton.topAnchor.constraint(equalTo: self.loginView.bottomAnchor, constant: 25.0).isActive = true
        self.guestButton.widthAnchor.constraint(equalTo: self.loginView.widthAnchor).isActive = true
        self.guestButton.heightAnchor.constraint(equalToConstant: 25.0)
        self.guestButton.addTarget(self , action: #selector(handleGuest), for: .touchUpInside)
        
        
        // 4
        self.indicatorView.fadeOut(duration: 0.0)
        
        // 3
        self.view.addSubview(self.registerButton)
        self.registerButton.leftAnchor.constraint(equalTo: self.loginView.leftAnchor ).isActive = true
        self.registerButton.topAnchor.constraint(equalTo: self.guestButton.bottomAnchor, constant: 5.0).isActive = true
        self.registerButton.widthAnchor.constraint(equalTo: self.loginView.widthAnchor).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: 25.0)
        self.registerButton.addTarget(self , action: #selector(handleRegister), for: .touchUpInside)
        
    }
    
    @objc fileprivate func dismissKeyboard () {
        self.view.endEditing(true)
    }
    
    @objc fileprivate func handleGuest () {
    
        self.dismissKeyboard()
        
        UserDefaults.standard.setValue("guest", forKey: "guest")
        UserDefaults.standard.synchronize()
        
        self.dismiss(animated: true , completion: nil)
        
    }
    
    func handleLogin (sender : OZRippleButton) {
        
        self.dismissKeyboard()
    
        guard let username = self.loginView.usernameTextField.text else  { return }
        guard let password = self.loginView.passwordTextField.text else  { return }

        if username == "" || Validator.isInValidUsername(text: username) {
        
            self.loginView.usernameTextField.lineView.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        
            return
            
        }else {
            
            self.loginView.usernameTextField.lineView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        
        }
        
        if password == "" || Validator.isInValidPassword(text: password) {
            
            self.loginView.passwordTextField.lineView.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        
            return
            
        }else {
            
             self.loginView.passwordTextField.lineView.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        }
        
        self.setupIndicatorView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 , execute: {
        
            self.indicatorView.activityIndicator.stopAnimating()
            self.indicatorView.removeFromSuperview()
            self.dismiss(animated: true , completion: nil )
        
        })
        
    }
    
    
    func handleRegister (sender : UIButton) {
        
        STATUSBAR_VIEW.backgroundColor = UIColor.clear
        
        let popup =  PopupController.create(self).customize([
            PopupCustomOption.animation(PopupController.PopupAnimation.slideUp) ,
            PopupCustomOption.scrollable(false) ,
            PopupCustomOption.backgroundStyle(PopupController.PopupBackgroundStyle.blackFilter(alpha: 0.5))
            
            ]).didShowHandler { (popup) in
                
        }.didCloseHandler { (popup) in
        
        }
        
        let registerVC = RegisterVC()
        registerVC.delegate = self 
        registerVC.closeHandler =  { _ in  popup.dismiss()  }
        
        popup.show(registerVC)
    
    }
    
    
    func setupIndicatorView () {
    
        self.loginView.addSubview(self.indicatorView)
        self.indicatorView.leftAnchor.constraint(equalTo: self.loginView.leftAnchor).isActive = true
        self.indicatorView.topAnchor.constraint(equalTo: self.loginView.topAnchor).isActive = true
        self.indicatorView.widthAnchor.constraint(equalTo: self.loginView.widthAnchor).isActive = true
        self.indicatorView.heightAnchor.constraint(equalTo: self.loginView.heightAnchor).isActive = true
        
        self.indicatorView.fadeIn(duration: 0.2)
        self.indicatorView.activityIndicator.startAnimating()
    
    }
    
}

extension LoginVC : UITextFieldDelegate  {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}









