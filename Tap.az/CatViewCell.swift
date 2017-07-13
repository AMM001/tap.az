//
//  CatViewCell.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/10/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

fileprivate let CATEGORY_CELL_IDENTIFIER = "categoryCell"


struct Category {

    var image : UIImage?
    var title : String?
    var count : String?
    
}

class CatViewCell: UICollectionViewCell {
    
    var categorys : [Category]? = [
    
        Category(image: #imageLiteral(resourceName: "shirt"), title: "Sexsi esyalar", count: "32011"),
        Category(image: #imageLiteral(resourceName: "garden"), title: "Ev bag ucun", count: "12345") ,
        Category(image: #imageLiteral(resourceName: "device"), title: "Elektronika", count: "1011"),
        Category(image: #imageLiteral(resourceName: "guitar"), title: "Hobbi ve asude", count: "345") ,
        Category(image: #imageLiteral(resourceName: "car"), title: "Neqliyyat", count: "31"),
        Category(image: #imageLiteral(resourceName: "garden"), title: "Ev bag ucun", count: "245") ,
        Category(image: #imageLiteral(resourceName: "home"), title: "Dasinmaz emlak", count: "3011"),
        Category(image: #imageLiteral(resourceName: "bag"), title: "Is biznes", count: "1345") ,
        Category(image: #imageLiteral(resourceName: "pet"), title: "Heyvanlar", count: "222")
    ]
    
    lazy var collectionView : UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.addCorner(radius: 4.0 , borderWidth: 1.0 , color: ORANGE_COLOR)
        view.shadow = true
        view.delegate = self
        view.dataSource = self
        
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
        self.addSubview(self.collectionView)
        self.collectionView.register(CategoryCell.self , forCellWithReuseIdentifier: CATEGORY_CELL_IDENTIFIER)
        self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 10.0).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor , constant : 10.0).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -20.0).isActive = true
        self.collectionView.heightAnchor.constraint(equalTo: self.heightAnchor , constant : -90.0).isActive = true
    
    }
    
}

extension CatViewCell : UICollectionViewDelegate , UICollectionViewDataSource {

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int  {
    
        if let count = self.categorys?.count {
            return count
        }
    
        return 5
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
    
        if let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CATEGORY_CELL_IDENTIFIER , for: indexPath) as? CategoryCell {
        
            if let category = self.categorys?[indexPath.row] {
            
                categoryCell.imageView.image = category.image
                categoryCell.titleLabel.text = category.title
                categoryCell.countLabel.text = category.count
            
            }
            
            return categoryCell
        }
    
        return UICollectionViewCell()
    }

}

extension CatViewCell : UICollectionViewDelegateFlowLayout {

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height / 9.0)
    }


}






















