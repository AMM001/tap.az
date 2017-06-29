//
//  PhotoAddCell.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/25/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

fileprivate let IMAGE_CELL = "imageCell"


class PhotoAddCell: UITableViewCell {

    var delegate : UIViewController?
    
    var images : [UIImage]?
    
    lazy var imagePickerController : UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        return imagePickerController
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 0.0
        let view = UICollectionView(frame: CGRect.zero , collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.clear
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var addPhotoImageViewTopAnchor : NSLayoutConstraint?
    
    let addPhotoImageView : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = true
        view.image =  #imageLiteral(resourceName: "ic_add_a_photo").withRenderingMode(.alwaysTemplate)
        view.tintColor = ORANGE_COLOR
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func setupViews () {

        self.images = []
        self.backgroundColor = ORANGE_COLOR
        
        // 1
        self.addSubview(self.designView)
        self.designView.backgroundColor = UIColor.white
        self.designView.addCorner(radius: 4.0 , borderWidth: 0.0 , color: .white)
        self.designView.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 5.0 ).isActive = true
        self.designView.topAnchor.constraint(equalTo: self.topAnchor , constant : 2.0 ).isActive = true
        self.designView.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -10.0 ).isActive = true
        self.designView.heightAnchor.constraint(equalTo: self.heightAnchor , constant : -4.0 ).isActive = true
        self.designView.shadow = true
        self.designView.addShadow(shadowColor: UIColor.gray.cgColor , shadowOffset: CGSize(width: 1.0 , height: 1.0 ), shadowOpacity: 1.0, shadowRadius: 1.0)
        self.designView.layer.masksToBounds = false

        // 2
        self.designView.addSubview(self.addPhotoImageView)
        self.addPhotoImageView.centerXAnchor.constraint(equalTo: self.designView.centerXAnchor).isActive = true
        self.addPhotoImageViewTopAnchor =  self.addPhotoImageView.topAnchor.constraint(equalTo: self.designView.topAnchor , constant : 8.0)
        self.addPhotoImageViewTopAnchor?.isActive = true
        self.addPhotoImageView.widthAnchor.constraint(equalToConstant : 40.0).isActive = true
        self.addPhotoImageView.heightAnchor.constraint(equalToConstant : 40.0).isActive = true
        self.addPhotoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(chooseImage)))
        
        // 3 
        self.designView.addSubview(self.collectionView)
        self.collectionView.leftAnchor.constraint(equalTo: self.designView.leftAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.addPhotoImageView.bottomAnchor).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.designView.widthAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.designView.bottomAnchor).isActive = true
        self.collectionView.register(ImageCell.self , forCellWithReuseIdentifier: IMAGE_CELL)
        self.collectionView.contentInset = UIEdgeInsets(top: 2.0 , left: 2.0 , bottom: 2.0 , right: 2.0)
    
    }
    
    
    func chooseImage (gesture : UITapGestureRecognizer ) {
        
        if let imageView : UIImageView = gesture.view as? UIImageView  {  imageView.makeClickEffect() }
        
        let alertController = UIAlertController(title: "Choose Photo", message: nil , preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: { action in
            
            self.imagePickerController.sourceType = .photoLibrary
            self.delegate?.present(self.imagePickerController, animated: true , completion: nil)
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { action in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                self.imagePickerController.sourceType = .camera
                self.delegate?.present(self.imagePickerController, animated: true , completion: nil)
                
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil ))
        self.delegate?.present(alertController, animated: true , completion: nil)
    }

    var counter : Int = 0
    
    fileprivate func updateData () {
    
        self.counter += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 , execute: {
       
            if self.counter == 1 {
                self.addPhotoImageViewTopAnchor?.constant -= 45.0
                self.addPhotoImageView.swipeToUp(height: 45.0)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                let indexPath = IndexPath(item: 0 , section: 0)
                self.collectionView.scrollToItem(at: indexPath , at: .centeredHorizontally, animated: true )
            }
            
        })
        
    }
    
}

extension PhotoAddCell : UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = self.images?.count {
            return count
        }
    
        return 0
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: IMAGE_CELL , for: indexPath) as? ImageCell {

            imageCell.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.2)
            imageCell.imageView.image = self.images?[indexPath.row]
            imageCell.deleteButton.tag = indexPath.row
            imageCell.deleteButton.addTarget(self , action: #selector(deleteClick), for: .touchUpInside)
            imageCell.imageView.addCorner(radius: 4.0 , borderWidth: 0.0 , color: UIColor.clear)
            imageCell.delegate = self.delegate
            imageCell.imageView.fadeIn(duration: 0.5)
            
            return imageCell
        }
        return UICollectionViewCell()
    }
    
    @objc fileprivate func deleteClick (button : UIButton) {
        
        self.images?.remove(at: button.tag)
        
        DispatchQueue.main.async {
            
            if self.images?.count == 0 {
                self.counter = 0
                self.addPhotoImageViewTopAnchor?.constant += 45.0
                self.addPhotoImageView.swipeToDown(height: 45.0)
            }
            
            self.collectionView.reloadData()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true )
    }
    
}

extension PhotoAddCell : UICollectionViewDelegateFlowLayout {
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.collectionView.bounds.width - 5.0 ) / 3.0   , height: (self.collectionView.bounds.width - 5.0 ) / 4.0 )
    }
    
}

extension PhotoAddCell : UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromImagePicker : UIImage?
        
        if let editingImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromImagePicker = editingImage
            
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromImagePicker = originalImage
        }
        
        if let selectedImage = selectedImageFromImagePicker  {

            if let images = self.images  {
            
                if images.count < 10 {

                    self.images?.insert(selectedImage, at: 0)
                    self.updateData()
        
                }
            
            }
        
        }
        
        self.delegate?.dismiss(animated: true , completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.delegate?.dismiss(animated: true , completion: nil)
    }
    
}

