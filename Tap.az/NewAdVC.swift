//
//  NewAdVC.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/21/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

fileprivate let CATEGORY_CELL_IDENTIFIER = "categoryCell"
fileprivate let PHOTO_ADD_CELL_IDENTIFIER = "photoAddCell"
fileprivate let AD_CELL_IDENTIFIER = "AdCell"
fileprivate let USER_CELL_IDENTIFIER = "userCell"
fileprivate let ADD_CELL = "addCell"

class NewAdVC : UIViewController {
    
    var delegate : HomeVC?
    
    lazy var tableView : UITableView = {
        let view = UITableView(frame: CGRect.zero , style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = ORANGE_COLOR
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(dismisKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    fileprivate var counter = 0
    
    func keyboardWillShow(notification: NSNotification) {
        
        counter += 1
        
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.counter == 1 {
            
                self.tableView.swipeToUp(height: 100.0)
                
            }
            
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        counter = 0
        
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if counter == 0 {
                
                self.tableView.swipeToDown(height: 100.0)
                
            }
            
        }
        
    }
    
    private func setupViews () {
        self.setupNavBar()
        
        // 1
        self.view.addSubview(self.tableView)
        self.tableView.contentInset = UIEdgeInsets(top: 5.0 , left: 0.0 , bottom: 2.0, right: 0.0)
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        self.tableView.register(AdCategoryCell.self , forCellReuseIdentifier: CATEGORY_CELL_IDENTIFIER)
        self.tableView.register(PhotoAddCell.self , forCellReuseIdentifier: PHOTO_ADD_CELL_IDENTIFIER)
        self.tableView.register(AdCell.self , forCellReuseIdentifier: AD_CELL_IDENTIFIER)
        self.tableView.register(UserCell.self , forCellReuseIdentifier: USER_CELL_IDENTIFIER)
        self.tableView.register(AddButtonCell.self , forCellReuseIdentifier: ADD_CELL)
        
    }
    
    private func setupNavBar () {
    
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_arrow_back"), style: .plain , target: self , action: #selector(goBack))
        self.navigationItem.leftBarButtonItems = [backButton]
        
        let pageTitleLabel = UILabel(frame: CGRect(x: 0.0 , y: 0.0 , width: FRAME.size.width / 2.0 , height: 30.0))
        pageTitleLabel.textColor = UIColor.white
        pageTitleLabel.text = "Yeni elan"
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        self.navigationItem.titleView = pageTitleLabel
        
    }
    
    @objc fileprivate func goBack () {

        self.navigationController?.popToRootViewController(animated: true)
    
    }
    
    @objc fileprivate func dismisKeyboard () {
        self.view.endEditing(true)
    }
    
    
    @objc func sendButton (sender : UIButton) {
        
        sender.makeClickEffect()
    
        print("Send button click...")   
    
    }
    
    func pushToCategoryVC (gesture : UITapGestureRecognizer) {
    
        let catController = CategoryVC()
        catController.view.backgroundColor = ORANGE_COLOR
//        self.show(catController , sender: self )
//        self.navigationController?.pushViewController(catController , animated: true )
        self.navigationController?.show(catController , sender: self )
    }
    
    @objc func descriptionTextViewCilck (gesture: UITapGestureRecognizer) {
    
        print("textview cilck")
    
    }

    // my custom zooming
    var startingFrame : CGRect?
    var blackBackgroudView : UIView?
    
    func zoomInImageView (startingImageView : UIImageView ) {
        
        startingFrame = startingImageView.superview?.convert(startingImageView.frame , to: nil)
        
        let zoomingImageView = UIImageView(frame: self.startingFrame!)
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.contentMode = .scaleAspectFill
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(zoomOut(gesture:))))
        zoomingImageView.image = startingImageView.image
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            self.blackBackgroudView = UIView(frame: keyWindow.frame)
            self.blackBackgroudView?.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9)
            keyWindow.addSubview(self.blackBackgroudView!)
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.5 , delay: 0.0 , usingSpringWithDamping: 1.0, initialSpringVelocity:  1.0 , options: .curveEaseOut , animations: {
                
                self.blackBackgroudView?.alpha = 0.95
                // principle
                // h1 / w1 = h2 / w2
                let zoomingImageViewHeight = (self.startingFrame!.height / self.startingFrame!.width ) * keyWindow.frame.width
                zoomingImageView.frame = CGRect(x: 0.0 , y: 0.0, width: keyWindow.frame.width , height: zoomingImageViewHeight)
                zoomingImageView.center = keyWindow.center
                
            }, completion: { (complete : Bool) in
                // doing nothing
            })
            
        }
        
    }

    func zoomOut (gesture : UITapGestureRecognizer) {
        
        if let zoomOutImageView = gesture.view {
            
            zoomOutImageView.layer.cornerRadius = 10.0
            zoomOutImageView.layer.masksToBounds = true
            
            UIView.animate(withDuration: 0.5 , delay: 0.0 , usingSpringWithDamping: 1.0, initialSpringVelocity:  1.0 , options: .curveEaseOut , animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroudView?.fadeOut(duration: 0.0)
                
            }, completion: { (complete : Bool) in
                
                zoomOutImageView.removeFromSuperview()
                
            })
            
        }
        
    }
    
}

extension NewAdVC : UITableViewDelegate , UITableViewDataSource {

    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Default is 1 if not implemented
    @available(iOS 2.0, *)
    public func numberOfSections(in tableView: UITableView) -> Int  {
        
        return 5
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 0 {

            if let adCategoryCell = tableView.dequeueReusableCell(withIdentifier:CATEGORY_CELL_IDENTIFIER , for: indexPath) as? AdCategoryCell{
            
                adCategoryCell.titleLabel.text = "Kategoriya"
                adCategoryCell.delegate = self
            
                return adCategoryCell
            }
        
        }else if indexPath.section == 1 {
            
            if let photoAddCell = tableView.dequeueReusableCell(withIdentifier: PHOTO_ADD_CELL_IDENTIFIER, for: indexPath) as? PhotoAddCell {
            
                photoAddCell.delegate = self
                photoAddCell.addPhotoImageViewTopAnchor?.constant += 45.0
                photoAddCell.selectedBackgroundView = UIView()
                return photoAddCell
                
            }

        }else if indexPath.section == 2 {
        
            if let adCell = tableView.dequeueReusableCell(withIdentifier: AD_CELL_IDENTIFIER, for: indexPath) as? AdCell {

                adCell.delegate = self
                
                return adCell
            }
            
        }else if indexPath.section == 3 {
        
            if let userCell = tableView.dequeueReusableCell(withIdentifier: USER_CELL_IDENTIFIER, for: indexPath) as? UserCell {
            
                userCell.delegete = self
                
                return userCell
            }
            
        }else if indexPath.section == 4 {
        
            if let addButtonCell = tableView.dequeueReusableCell(withIdentifier: ADD_CELL , for: indexPath) as? AddButtonCell {
        
                addButtonCell.delegate = self
                
                return addButtonCell
            }
        
        }
        
        return UITableViewCell()
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
        
            return 50.0
        
        }else if indexPath.section == 1 {
            
            return FRAME.size.height / 4.0
            
        }else if indexPath.section == 2 {
            
            return FRAME.size.height / 3.0
        
        }else if indexPath.section == 3 {
        
            return FRAME.size.height / 3.2
            
        }else if indexPath.section == 4 {
        
            return 100.0
            
        }
        
        return  0.0
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        switch indexPath.section {
        case 0:
            
            print("0")
            
            break
            
        case 1 :
            
             print("1")

            break

        case 2 :
            
             print("2")
            
            break
            
        default:
            
            break
        }
        

        
    }

}



