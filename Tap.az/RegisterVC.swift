
//
//  RegisterVC.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/12/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit
import CoreData


class RegisterVC: UIViewController {
    
    weak var delegate : LoginVC?
    
    lazy var registerView : RegisterView = {
        let view = RegisterView(frame: CGRect.zero)
        view.delegate = self
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.shadow = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 4.0
        view.usernameTextField.delegate = self
        view.passwordTextField.delegate = self
        view.emailTextField.delegate = self
        return view
    }()
    
    lazy var imagePickerController : UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        return imagePickerController
    }()
    
    let indicatorView : IndicatorView = {
        let view = IndicatorView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }()
    
    
    var closeHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func setupViews () {
        
        // 1
        self.view.addSubview(self.registerView)
        self.registerView.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant : 4.0).isActive = true
        self.registerView.topAnchor.constraint(equalTo: self.view.topAnchor , constant : 4.0).isActive = true
        self.registerView.widthAnchor.constraint(equalTo: self.view.widthAnchor , constant : -8.0).isActive = true
        self.registerView.heightAnchor.constraint(equalTo: self.view.heightAnchor , constant : -8.0).isActive = true
        
    }
    
    func chooseImage (gesture : UITapGestureRecognizer) {
    
        if let imageView = gesture.view as? UIImageView  {
            
            imageView.makeClickEffect()
            
            let alertController = UIAlertController(title: "Şəkil seç", message: nil , preferredStyle: UIAlertControllerStyle.actionSheet)
            
            alertController.addAction(UIAlertAction(title: "Fotolar", style: UIAlertActionStyle.default, handler: { action in
                
                self.imagePickerController.sourceType = .photoLibrary
                self.present(self.imagePickerController, animated: true , completion: nil)
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Kamera", style: UIAlertActionStyle.default, handler: { action in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    
                    self.imagePickerController.sourceType = .camera
                    self.present(self.imagePickerController, animated: true , completion: nil)
                    
                }
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil ))
            self.present(alertController, animated: true , completion: nil)
            
        }

    }
    
    func registerButtonClicked(sender: OZRippleButton ) {
        
        self.dismissKeyboard()
    
        guard let username = self.registerView.usernameTextField.text else  { return }
        guard let email = self.registerView.emailTextField.text else  { return }
        guard let password = self.registerView.passwordTextField.text else  { return }
        
        if username == "" || Validator.isInValidUsername(text: username) {
            
            self.registerView.usernameTextField.lineView.backgroundColor = UIColor.red.withAlphaComponent(0.4)
            
            return
            
        }else {
            
            self.registerView.usernameTextField.lineView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
            
        }
        
        if email == "" || !Validator.isInValidEmail(text: email) {
            
            self.registerView.emailTextField.lineView.backgroundColor = UIColor.red.withAlphaComponent(0.4)
            
            return
            
        }else {
            
            self.registerView.emailTextField.lineView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
            
        }
        
        if password == "" || Validator.isInValidPassword(text: password) {
            
            self.registerView.passwordTextField.lineView.backgroundColor = UIColor.red.withAlphaComponent(0.4)
            
            return
            
        }else {
            
            self.registerView.passwordTextField.lineView.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        }

        let user = User(context: PersistenseManager.context)
        user.name = username
        user.email = email
        user.password = password
        
        if let image = self.registerView.imageView.image {
            if let imageData = UIImageJPEGRepresentation(image, 0.7) {
                user.imageData = imageData as NSData
            }
        }
        
        PersistenseManager.saveContext()
    
        self.setupIndicatorView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 , execute: {
            
            self.indicatorView.activityIndicator.stopAnimating()
            self.indicatorView.removeFromSuperview()
            self.dismiss(animated: true , completion: nil )
            
            self.closeHandler?()
            self.delegate?.dismiss(animated: true , completion: nil)
            
        })
        
    }
    
    func dismissKeyboard () {
        self.view.endEditing(true)
    }
    
    func setupIndicatorView () {
        
        self.registerView.addSubview(self.indicatorView)
        self.indicatorView.leftAnchor.constraint(equalTo: self.registerView.leftAnchor).isActive = true
        self.indicatorView.topAnchor.constraint(equalTo: self.registerView.topAnchor).isActive = true
        self.indicatorView.widthAnchor.constraint(equalTo: self.registerView.widthAnchor).isActive = true
        self.indicatorView.heightAnchor.constraint(equalTo: self.registerView.heightAnchor).isActive = true
        self.indicatorView.fadeIn(duration: 0.2)
        self.indicatorView.activityIndicator.startAnimating()
        
    }
    
    
    
}

extension RegisterVC : UIImagePickerControllerDelegate {

    @available(iOS 2.0, *)
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        var selectedImageFromImagePicker : UIImage?
        
        if let editingImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromImagePicker = editingImage
            
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromImagePicker = originalImage
        }
        
        if let selectedImage = selectedImageFromImagePicker  {

            self.registerView.imageView.addCorner(radius: 30.0, borderWidth: 1.0, color: ORANGE_COLOR.withAlphaComponent(0.1))
            self.registerView.imageView.image = selectedImage
            
        }
        
        self.dismiss(animated: true , completion: nil)
    
    }
    
    @available(iOS 2.0, *)
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController)  {
         self.dismiss(animated: true , completion: nil)
    }

}

extension RegisterVC : UINavigationControllerDelegate {


}

extension RegisterVC : PopupContentViewController {
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
    
        return CGSize(width: FRAME.size.width - 20.0 , height: 300.0)
        
    }

}


extension RegisterVC : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}






