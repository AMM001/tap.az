//
//  LoginVC.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/10/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit
import RealmSwift

class LoginVC: UIViewController {
    
    lazy var loginView : LoginView = {
        let view = LoginView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.usernameTextField.delegate = self
        view.usernameTextField.tag = 0
        view.passwordTextField.delegate = self
        view.passwordTextField.tag = 1
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
        view.textColor = UIColor.white
        view.font = UIFont(name: "AvenirNext-Bold", size: 45.0)
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()

    let activityIndicatorView : ActivityIndicatorView = {
        let view = ActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(dismisKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self , selector: #selector(internetStatusManage), name: NSNotification.Name.flagsChanged, object: Network.reachability)
        self.updateUserInterface()
        // Do any additional setup after loading the view.
        self.setupViews()
        
    }
    
    @objc fileprivate func updateUserInterface() {
        guard let status = Network.reachability?.status else { return }
        switch status {
        case .unreachable:
            view.backgroundColor = .red
        case .wifi:
            view.backgroundColor = .green
        case .wwan:
            view.backgroundColor = .yellow
        }
        print("Reachability Summary")
        print("Status:", status)
        print("HostName:", Network.reachability?.hostname ?? "nil")
        print("Reachable:", Network.reachability?.isReachable ?? "nil")
        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
    }
    
    func internetStatusManage (notification : Notification) {
        self.updateUserInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginView.fadeIn(duration: 1.0)
        self.titleLabel.fadeIn(duration: 1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    fileprivate func setupViews () {
        
        // 1adding login view with their x , y ,w , h constraints
        self.view.addSubview(self.loginView)
  
        self.loginView.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant : 25.0).isActive = true
        self.loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor , constant : 0.0).isActive = true
        self.loginView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant : -50.0).isActive = true
        self.loginView.heightAnchor.constraint(equalToConstant: 135.0).isActive = true
        self.loginView.fadeOut(duration: 0.0)
        
        // 2
        self.view.addSubview(self.titleLabel)
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.loginView.topAnchor , constant : -10.0 ).isActive = true
        self.titleLabel.widthAnchor.constraint(equalTo: self.loginView.widthAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalTo: self.loginView.heightAnchor , multiplier : 1/2 ).isActive = true
        self.titleLabel.fadeOut(duration: 0.0)
        
        // 3 
        self.view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.leftAnchor.constraint(equalTo: self.loginView.leftAnchor).isActive = true
        self.activityIndicatorView.topAnchor.constraint(equalTo: self.loginView.topAnchor).isActive = true
        self.activityIndicatorView.widthAnchor.constraint(equalTo: self.loginView.widthAnchor).isActive = true
        self.activityIndicatorView.heightAnchor.constraint(equalTo: self.loginView.heightAnchor).isActive = true
        self.activityIndicatorView.addCorner(radius: 4.0, borderWidth: 1.0, color: UIColor.white.withAlphaComponent(0.8))
        self.activityIndicatorView.fadeOut(duration: 0.0)
        
        
        self.setupNavBar()
        
    }

    
    func setupNavBar () {
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        let registerButton : UIBarButtonItem = UIBarButtonItem(image: REGISTER_BUTTON_IMAGE, style: .plain, target: self  , action: #selector(swipeRegister))
        
        self.navigationItem.leftBarButtonItem = registerButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
    }
    
    @objc fileprivate func swipeRegister () {
        
        let registrControlller = RegistrVC()
        let navController = UINavigationController(rootViewController: registrControlller)
        navController.view.backgroundColor = ORANGE_COLOR
        self.navigationController?.show(navController, sender: nil)
    }

    
    @objc fileprivate func dismisKeyboard () {
        self.view.endEditing(true)
    }
    
    
    func loginButtonClick (button : OZRippleButton) {
        
        self.dismisKeyboard()
        
        var name : String?
        var password : String?
        
        if let userNameText = self.loginView.usernameTextField.text {
            
            if userNameText == "" || userNameText.characters.count < 6 {
                self.loginView.usernameLineView.backgroundColor = UIColor.red
                return
            }else {
                name = userNameText
                self.loginView.usernameLineView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.4)
            }
            
        }
        
        if let passwordText = self.loginView.passwordTextField.text {
            
            if !passwordText.isValidPassword {
                self.loginView.passwordLineView.backgroundColor = UIColor.red
                return
            }else {
                password = passwordText
                self.loginView.passwordLineView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.4)
            }
    
        }
        
        if let database = try? Realm() {
            
            let users = database.objects(User.self).filter("name = '\(name!)'")
            
            for i in 0..<users.count {
                
                if users[i].name == name  && users[i].password == password {
                    
                    if self.loginView.checkBox.isChecked {
                        
                        UserDefaults.standard.setValue(name, forKey: "name")
                        UserDefaults.standard.synchronize()
                    }
                    
                    self.activityIndicatorView.fadeIn(duration: 0.5)
                    self.activityIndicatorView.activityIndicator.startAnimating()
                    
                    let homeController = HomeVC()
                    homeController.view.backgroundColor = UIColor.white
                    let homeNavController = UINavigationController(rootViewController: homeController)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0 , execute: {
                        
                        self.activityIndicatorView.fadeOut(duration: 0.2)
                        self.activityIndicatorView.activityIndicator.stopAnimating()
                        self.present(homeNavController, animated: true , completion: nil)
                        
                    })
                    
                }
                
            }
            
        }
        
    }
    
    
    fileprivate var counter = 0
    
    func keyboardWillShow(notification: NSNotification) {
        
        counter += 1
        
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.counter == 1 {
                
                if self.loginView.alpha != 0 {
                    self.view.frame.origin.y -= 80.0
                }
                
            }
            
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        counter = 0
        
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if counter == 0 {
                
                if self.loginView.alpha != 0 {
                    self.view.frame.origin.y += 80.0
                }
                
            }
            
        }
        
    }

}


extension LoginVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
        
    }
    
}











