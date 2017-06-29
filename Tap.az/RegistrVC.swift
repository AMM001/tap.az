//
//  RegistrVC.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/22/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit
import RealmSwift

class RegistrVC: UIViewController {
    
 
    lazy var registerView : RegisterView = {
        let view = RegisterView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.usernameTextField.delegate = self
        view.usernameTextField.tag = 0
        view.emailTextField.delegate = self
        view.emailTextField.tag = 1
        view.passwordTextField.delegate = self
        view.passwordTextField.tag = 2
        view.shadow = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 4.0
        view.backgroundColor = UIColor.white
        view.fadeOut(duration: 0.0)
        return view
    }()
    
    let activityIndicatorView : ActivityIndicatorView = {
        
        let view = ActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        self.setupViews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.registerView.fadeIn(duration: 0.0)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    

    @objc fileprivate func dismisKeyboard () {
        self.view.endEditing(true)
    }
    
    func setupViews () {
    
        self.view.backgroundColor = ORANGE_COLOR
    
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(dismisKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        // 1 adding login view with their x , y ,w , h constraints
        self.view.addSubview(self.registerView)
        self.registerView.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant : 25.0).isActive = true
        self.registerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.registerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant : -50.0).isActive = true
        self.registerView.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        self.registerView.fadeIn(duration: 1.0)
        
        
        // 2
        self.view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.leftAnchor.constraint(equalTo: self.registerView.leftAnchor).isActive = true
        self.activityIndicatorView.topAnchor.constraint(equalTo: self.registerView.topAnchor).isActive = true
        self.activityIndicatorView.widthAnchor.constraint(equalTo: self.registerView.widthAnchor).isActive = true
        self.activityIndicatorView.heightAnchor.constraint(equalTo: self.registerView.heightAnchor).isActive = true
        self.activityIndicatorView.addCorner(radius: 4.0, borderWidth: 1.0, color: UIColor.white.withAlphaComponent(0.9))
        self.activityIndicatorView.fadeOut(duration: 0.0)
        
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        let loginButton : UIBarButtonItem = UIBarButtonItem(image: LOGIN_BUTTON_IMAGE, style: .plain, target: self  , action: #selector(swipeLogin))

        self.navigationItem.leftBarButtonItem = loginButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
    }
   
    

    func swipeLogin () {
    
        self.registerView.fadeOut(duration: 0.0)
        self.dismiss(animated: true , completion: nil)
        
    }
  

    
    func registerButtonClick (button : UIButton) {
        
        self.dismisKeyboard()
        
        var name : String?
        var email : String?
        var password : String?
        var imageData : Data?
        
        if let userNameText = self.registerView.usernameTextField.text {
            
            if userNameText == "" || userNameText.characters.count < 6 {
                self.registerView.usernameLineView.backgroundColor = UIColor.red
                return
            }else {
                name = userNameText
                self.registerView.usernameLineView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.4)
            }
            
        }
        
        if let emailText = self.registerView.emailTextField.text {
            
            if !emailText.isEmail {
                self.registerView.emailLineView.backgroundColor = UIColor.red
                return
            }else {
                email = emailText
                self.registerView.emailLineView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.4)
            }
            
        }
        
        
        if let passwordText = self.registerView.passwordTextField.text {
            
            if !passwordText.isValidPassword {
                self.registerView.passwordLineView.backgroundColor = UIColor.red
                return
            }else {
                password = passwordText
                self.registerView.passwordLineView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.4)
            }
            
        }
        
        if let image = self.registerView.userPhotoImageView.image {
            imageData = UIImageJPEGRepresentation(image, 0.7)
        }
        
        let user = User()
        user.name = name
        user.email = email
        user.password = password
        user.imageData = imageData
        
        
        if let database = try? Realm() {
                        
            let users = database.objects(User.self).filter("name = '\(user.name!)'")
            
            for i in 0..<users.count {
                
                if users[i].name == user.name || users[i].email == user.email {
                    print("This user already have tap.az...")
                    return
                }
                
            }
            
            try! database.write {
                database.add(user)
                print("User added...")
                
            }
            
            if self.registerView.checkBox.isChecked {
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
//                 self.show(homeNavController, sender: nil)
                self.present(homeNavController, animated: true , completion: nil )
                
            })
      
        }
        
    }

    
    fileprivate var counter = 0
    
    func keyboardWillShow(notification: NSNotification) {
        
        counter += 1
        
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.counter == 1 {
                
                if self.registerView.alpha != 0 {
                    self.view.frame.origin.y -= 80.0
                }
 
            }
            
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        counter = 0
        
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if counter == 0 {
                
                if self.registerView.alpha != 0 {
                    self.view.frame.origin.y += 80.0
                }
            
            }
            
        }
        
    }

    
    lazy var imagePickerController : UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        return imagePickerController
    }()
    
    func chooseImage (gesture : UITapGestureRecognizer ) {
        
        if let imageView : UIImageView = gesture.view as? UIImageView  {  imageView.makeClickEffect() }
        
        let alertController = UIAlertController(title: "Choose Photo", message: nil , preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: { action in
            
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true , completion: nil)
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { action in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                self.imagePickerController.sourceType = .camera
                self.present(self.imagePickerController, animated: true , completion: nil)
                
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil ))
        self.present(alertController, animated: true , completion: nil)
    }

}


extension RegistrVC : UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromImagePicker : UIImage?
        
        if let editingImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromImagePicker = editingImage
            
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromImagePicker = originalImage
        }
        
        if let selectedImage = selectedImageFromImagePicker  {
            self.registerView.userPhotoImageView.image = selectedImage
            self.registerView.userPhotoImageView.addCorner(radius: 25.0 , borderWidth: 1.0 , color: ORANGE_COLOR)
        }
        self.dismiss(animated: true , completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true , completion: nil)
    }
    
}

extension RegistrVC : UITextFieldDelegate {

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
