
//
//  DetailVC.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/8/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

fileprivate let HEADER_CELL = "headerCell"
fileprivate let DETAIL_CELL = "detailCell"
fileprivate let HOME_CELL = "homeCell"


struct Detail {
    
    var key : String?
    var value : String?
    
}

class DetailVC: UIViewController {
    
    var ads : [Ad]?
    
    var ad : Ad?  {
    
        didSet {
            
        }
    
    }
    
    var controller : HomeVC? {
    
        didSet {
        
            self.ads = controller?.ads
            
        }
    
    }
    
    fileprivate let details : [Detail] = [
        
        Detail(key: "Şəhər", value: "Bakı"),
        Detail(key: "Marka", value: "Mercedes-Benz"),
        Detail(key: "Model", value: "c320"),
        Detail(key: "Mühərrik", value: "3200"),
        Detail(key: "Kuzov", value: "Sedan"),
        Detail(key: "Buraxılış ili", value: "2012"),
        Detail(key: "Yürüş, km", value: "220280"),
        Detail(key: "Yeni", value: "Xeyr"),
        
        ]
    

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
    
    private func setupViews () {
    
        self.setupNavBar()
        self.setupCollectionView()
    
    }
    
    private func setupNavBar () {
    
        // 1
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_arrow_back"), style: .plain, target: self , action: #selector (back))
        let homeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_home"), style: .plain, target: self , action: #selector (home))
        
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_share"), style: .plain, target: self , action: #selector (share))
        let likeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_favorite_border"), style: .plain, target: self , action: #selector(like))
    
        self.navigationItem.leftBarButtonItems = [ backButton , homeButton ]
        self.navigationItem.rightBarButtonItems = [ shareButton , likeButton ]
        
    }
    
    
    private func setupCollectionView () {
    
        // 2
        self.view.addSubview(self.collectionView)
        self.collectionView.contentInset = UIEdgeInsets(top: 1.0, left: 1.0 , bottom: 0.0 , right: 1.0)
        self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive  = true
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        self.collectionView.register(DetailCell.self , forCellWithReuseIdentifier: DETAIL_CELL)
        self.collectionView.register(HomeCell.self , forCellWithReuseIdentifier: HOME_CELL)
        self.collectionView.register(DetailHeaderView.self , forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HEADER_CELL)
        
    
    }
    
    @objc fileprivate func back () {
        
        self.navigationController?.popViewController(animated: true )
        
    }
    
    
    @objc fileprivate func home () {
        
        
    }
    
    
    @objc fileprivate func share () {
        
        
    }
    
    @objc fileprivate func like (sender : UIBarButtonItem ) {
       
        sender.image = #imageLiteral(resourceName: "ic_favorite")
        
    }
    
    var startingFrame : CGRect?
    var blackBackgroudView : UIView?
    
    @objc fileprivate func zoomInHeader (gesture : UITapGestureRecognizer ) {
        
        if let startingHeaderView = gesture.view as? DetailHeaderView {
            
            startingFrame = startingHeaderView.superview?.convert(startingHeaderView.frame , to: nil)
            
            let zoomingHeaderView = DetailHeaderView(frame: self.startingFrame!)
            zoomingHeaderView.backgroundColor = UIColor.clear
            zoomingHeaderView.isUserInteractionEnabled = true
            zoomingHeaderView.contentMode = .scaleAspectFill
            zoomingHeaderView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(zoomOutHeader)))
            zoomingHeaderView.priceLabel.fadeOut(duration: 0.0)
            zoomingHeaderView.titleLabel.fadeOut(duration: 0.0)
            zoomingHeaderView.imageCarusel.imageURLs = startingHeaderView.imageCarusel.imageURLs
            zoomingHeaderView.fadeOut(duration: 0.0)
            
            if let keyWindow = UIApplication.shared.keyWindow {
                self.blackBackgroudView = UIView(frame: keyWindow.frame)
                self.blackBackgroudView?.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                keyWindow.addSubview(self.blackBackgroudView!)
                keyWindow.addSubview(zoomingHeaderView)
                
                UIView.animate(withDuration: 0.7 , delay: 0.0 , usingSpringWithDamping: 1.0, initialSpringVelocity:  1.0 , options: .curveEaseOut , animations: {
                    
                    zoomingHeaderView.fadeIn(duration: 0.7)
                    self.blackBackgroudView?.alpha = 0.95
                    // principle
                    // h1 / w1 = h2 / w2
                    let zoomingHeaderViewHeight = (self.startingFrame!.height / self.startingFrame!.width ) * keyWindow.frame.width
                    zoomingHeaderView.frame = CGRect(x: 0.0 , y: 0.0, width: keyWindow.frame.width , height: zoomingHeaderViewHeight)
                    zoomingHeaderView.center = keyWindow.center
                    
                }, completion: { (complete : Bool) in
                    // doing nothing
                })
                
            }
            
        }
        
    }
    
    @objc fileprivate func zoomOutHeader (gesture : UITapGestureRecognizer) {
        
        if let zoomOutHeaderView = gesture.view  as? DetailHeaderView {
            
            zoomOutHeaderView.layer.cornerRadius = 10.0
            zoomOutHeaderView.layer.masksToBounds = true
            
            UIView.animate(withDuration: 0.8 , delay: 0.0 , usingSpringWithDamping: 1.0, initialSpringVelocity:  1.0 , options: .curveEaseOut , animations: {
                
                zoomOutHeaderView.frame = self.startingFrame!
                zoomOutHeaderView.fadeOut(duration:  0.8)
                self.blackBackgroudView?.fadeOut(duration: 0.0)
                
            }, completion: { (complete : Bool) in
                
                zoomOutHeaderView.removeFromSuperview()
                
            })
            
        }
        
    }

}


extension DetailVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int  {
    
        if section == 0 {
            
            return self.details.count
        
        }else if section == 1 {
  
            if let count = self.ads?.count {
            
                return count
            }
            
        }
        
        return 0
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
    
        if indexPath.section == 0 {
            
            if let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: DETAIL_CELL , for: indexPath) as? DetailCell {
                
                detailCell.detail = self.details[indexPath.row]
    
                if indexPath.row % 2 == 0 {
                    
                    detailCell.designView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
                
                }else {
                    detailCell.designView.backgroundColor = UIColor.white
                }
                
                return detailCell
            }
        
        }else if indexPath.section == 1 {
            
            if let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HOME_CELL , for: indexPath) as? HomeCell {
                homeCell.desigView.fadeIn(duration: 0.5)
                homeCell.ad = self.ads?[indexPath.row]
                homeCell.controller = self.controller
                return homeCell
            }
        
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if indexPath.section == 0 {
            
            if let detailHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HEADER_CELL , for: indexPath) as? DetailHeaderView  {
                
                if let imageURL = self.ad?.image  {
                
                    detailHeaderView.imageCarusel.imageURLs  = [ imageURL , imageURL , imageURL ]
                    detailHeaderView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(zoomInHeader(gesture:))))
                    
                }
                
                return detailHeaderView
            }
            
        }else if indexPath.section == 1 {
    
        }
        
        return UICollectionReusableView()
    }

}


extension DetailVC : UICollectionViewDelegateFlowLayout  {

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if indexPath.section == 0 {
    
            return CGSize(width: self.collectionView.frame.width , height: self.collectionView.frame.height / 12.0)
        
        }else if indexPath.section == 1 {
    
            return CGSize(width: (FRAME.size.width - 3.0) / 2.0 , height: (FRAME.size.width - 3.0) / 2.0 )
        }
    
        return CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
        if section == 0  {
        
            return CGSize(width: self.collectionView.frame.size.width , height: self.collectionView.frame.height / 2.5)
        }
    
        return CGSize.zero
    }
    
}











