
//
//  NewAdVC.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/9/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

fileprivate let AD_CATEGORY_CELL_IDENTIFIER = "categoryCell"
fileprivate let CHOOSE_IMAGE_CELL_IDENTIFER = "chooseImageCell"
fileprivate let AD_DETAIL_CELL_IDENTIFIER = "adDetailCell"
fileprivate let AD_USER_CELL_IDENTIFIER = "adUserCell"
fileprivate let ADD_AD_CELL_IDENTIFIER = "adCell"

class NewAdVC: UIViewController {

    lazy var collectionView : UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        let view = UICollectionView(frame: CGRect.zero , collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR
        view.delegate = self
        view.dataSource = self
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
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    fileprivate var counter = 0
    
    func keyboardWillShow(notification: NSNotification) {
        
        counter += 1
        
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.counter == 1 {
                
                self.collectionView.swipeToUp(height: 100.0)
                
            }
            
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        counter = 0
        
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if counter == 0 {
                
                self.collectionView.swipeToDown(height: 100.0)
                
            }
            
        }
        
    }


    private func setupViews () {
        
        self.setupNavBar()
        self.setupCollectionView()
        
    }
    
    private func setupNavBar () {
    
        // 1
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_arrow_back"), style: .plain, target: self , action: #selector (back))
        self.navigationItem.leftBarButtonItem = backButton
        
        let titleLabel = UILabel(frame: CGRect(x: 0.0 , y: 0.0 , width: FRAME.size.width / 2.0 , height: 40.0))
        titleLabel.text = "Yeni elan"
        titleLabel.textColor = UIColor.white
        titleLabel.contentMode = .scaleToFill
        titleLabel.font = UIFont(name: HELVETICA_NEUE_BOLD , size: 20)
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
    }
    
    
    private func setupCollectionView () {
    
        self.view.addSubview(self.collectionView)
        self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        self.collectionView.register(AdCategoryCell.self, forCellWithReuseIdentifier: AD_CATEGORY_CELL_IDENTIFIER)
        self.collectionView.register(ChooseImageCell.self , forCellWithReuseIdentifier: CHOOSE_IMAGE_CELL_IDENTIFER)
        self.collectionView.register(AdDetailCell.self , forCellWithReuseIdentifier: AD_DETAIL_CELL_IDENTIFIER)
        self.collectionView.register(AdUserCell.self , forCellWithReuseIdentifier: AD_USER_CELL_IDENTIFIER)
        self.collectionView.register(AddAdCell.self , forCellWithReuseIdentifier: ADD_AD_CELL_IDENTIFIER)
        
    }
    
    @objc fileprivate func back () {
        self.navigationController?.popViewController(animated: true )
    }
    
    @objc fileprivate func send (sender : OZRippleButton) {
    
        print("Gonderdim")
    
    }
    
}

extension NewAdVC : UICollectionViewDelegate , UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 5
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return 1
    }

    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section  {
       
        case  0:
            
            if let adCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: AD_CATEGORY_CELL_IDENTIFIER , for: indexPath) as? AdCategoryCell {
            
                adCategoryCell.delegate  = self
                adCategoryCell.titleLabel.text = "Kategoriya"
            
                return adCategoryCell
            }
            
            break
            
        case 1:
            
            if let chooseImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: CHOOSE_IMAGE_CELL_IDENTIFER, for: indexPath) as? ChooseImageCell {
                chooseImageCell.delegate  = self
            
                chooseImageCell.addPhotoImageViewTopAnchor?.constant += 40.0
                chooseImageCell.addPhotoImageView.swipeToDown(height: 40.0)
                

                return chooseImageCell
            }
            
            break
            
        case 2 :
            
            if let adDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: AD_DETAIL_CELL_IDENTIFIER, for: indexPath) as? AdDetailCell {
            
                 adDetailCell.delegate  = self
                
                return adDetailCell
            }
        
            break
            
        case 3 :
            
            if let adUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: AD_USER_CELL_IDENTIFIER , for: indexPath) as? AdUserCell {
            
                adUserCell.delegate  = self
    
                return adUserCell
            }
            
            break
            
        case 4:
            
            if let addAdCell = collectionView.dequeueReusableCell(withReuseIdentifier: ADD_AD_CELL_IDENTIFIER , for: indexPath) as? AddAdCell {
            
                addAdCell.delegate = self
                addAdCell.sendButton.addTarget(self , action: #selector(send) , for: .touchUpInside)
            
                return addAdCell
            }
        
            break
            
        default:
            
            break
        }
    
        return UICollectionViewCell()
    }

}


extension NewAdVC : UICollectionViewDelegateFlowLayout  {

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
    
        if indexPath.section == 0 {
        
            return CGSize(width: FRAME.size.width , height: 50.0)
      
        }else if indexPath.section == 1 {
        
             return CGSize(width: FRAME.size.width , height: FRAME.size.height / 4.0)
            
        }else if indexPath.section == 2 {
        
             return CGSize(width: FRAME.size.width , height: FRAME.size.height / 2.8)
        
        }else if indexPath.section == 3 {
        
            return CGSize(width: FRAME.size.width , height: FRAME.size.height / 3.0)
            
        }else if indexPath.section == 4 {
        
            return CGSize(width: FRAME.size.width , height: 100.0)
        }
        
        return CGSize.zero
    }

}



















