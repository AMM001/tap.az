//
//  CategoryVC.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/10/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "catCell"

class CategoryVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(CatViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.setupViews()
        
    }

    fileprivate func setupViews () {
    
        self.setupNavBar()
        self.setupCollectionView()
        
    }
    
    fileprivate func setupNavBar () {
    
        // 1
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_arrow_back"), style: .plain, target: self , action: #selector (back))
        self.navigationItem.leftBarButtonItem = backButton
        
        let titleLabel = UILabel(frame: CGRect(x: 0.0 , y: 0.0 , width: FRAME.size.width / 2.0 , height: 40.0))
        titleLabel.text = "Kateqoriyalar"
        titleLabel.textColor = UIColor.white
        titleLabel.contentMode = .scaleToFill
        titleLabel.font = UIFont(name: HELVETICA_NEUE_BOLD , size: 20)
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
    
    }
    
    fileprivate func setupCollectionView () {

        self.collectionView?.bounces = false
        self.collectionView?.isScrollEnabled = false
        
    }
    
    @objc fileprivate func back () {
        self.navigationController?.popViewController(animated: true )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CatViewCell {
        
            return cell
        }

        return UICollectionViewCell()
    }
    
}


extension CategoryVC : UICollectionViewDelegateFlowLayout  {

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
    
        return CGSize(width: self.collectionView!.frame.width , height: self.collectionView!.frame.height)
    }

}










