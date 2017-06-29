//
//  HomeDetailVC.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/23/17.
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

class HomeDetailVC: UIViewController {
    
    weak var homeController : HomeVC?
    
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
        
        // 1
        self.view.addSubview(self.collectionView)
        self.collectionView.register(DetailReusableV.self , forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: HEADER_CELL)
        self.collectionView.register(DetailCell.self , forCellWithReuseIdentifier: DETAIL_CELL)
        self.collectionView.register(HomeCell.self , forCellWithReuseIdentifier: HOME_CELL)
        self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        // 2 navbar buttons 
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_arrow_back"), style: .plain, target: self , action: #selector (back))
        let homeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_home"), style: .plain, target: self , action: #selector (home))
        
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_share"), style: .plain, target: self , action: #selector (share))
        let likeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_favorite_border"), style: .plain, target: self , action: #selector(like))
    
        self.navigationItem.leftBarButtonItems = [ backButton , homeButton ]
        self.navigationItem.rightBarButtonItems = [ shareButton , likeButton ]
        
    }
    
    
    @objc fileprivate func back () {
    
        self.navigationController?.popViewController(animated: true )
    
    }
    
    @objc fileprivate func home () {
    
        
    }
    
    @objc fileprivate func share () {
        
        let title = "Mercedes-Benz C320"
        let activityVC = UIActivityViewController(activityItems: [ title ], applicationActivities: nil)
        self.present(activityVC, animated: true , completion: nil)
    
    }
    
    @objc fileprivate func like (sender : UIBarButtonItem ) {
        sender.image = #imageLiteral(resourceName: "ic_favorite")
    }
    
    var startingFrame : CGRect?
    var blackBackgroudView : UIView?
    
    @objc fileprivate func zoomInHeader (gesture : UITapGestureRecognizer ) {
        
        if let startingHeaderView = gesture.view as? DetailReusableV {
        
            startingFrame = startingHeaderView.superview?.convert(startingHeaderView.frame , to: nil)
            
            let zoomingHeaderView = DetailReusableV(frame: self.startingFrame!)
            zoomingHeaderView.backgroundColor = UIColor.clear
            zoomingHeaderView.isUserInteractionEnabled = true
            zoomingHeaderView.contentMode = .scaleAspectFill
            zoomingHeaderView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(zoomOutHeader)))
            zoomingHeaderView.priceLabel.fadeOut(duration: 0.0)
            zoomingHeaderView.titleLabel.fadeOut(duration: 0.0)
            zoomingHeaderView.imageCarusel = startingHeaderView.imageCarusel
            zoomingHeaderView.fadeOut(duration: 0.0)
            
            if let keyWindow = UIApplication.shared.keyWindow {
                self.blackBackgroudView = UIView(frame: keyWindow.frame)
                self.blackBackgroudView?.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9)
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
        
        if let zoomOutHeaderView = gesture.view  as? DetailReusableV {
            
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



extension HomeDetailVC : UICollectionViewDelegate , UICollectionViewDataSource {

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return self.details.count
        
        }else if section == 1 {
            return 20
        }
        
        return 0
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if indexPath.section == 0 {
       
            if let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: DETAIL_CELL , for: indexPath) as? DetailCell {
                
                detailCell.designView.fadeIn(duration: 0.6)
                
                if indexPath.row % 2 == 0 {
                    detailCell.designView.backgroundColor = UIColor.white
                }else {
                    detailCell.designView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
                }
                
                detailCell.isUserInteractionEnabled = false
                detailCell.detail = self.details[indexPath.row]
            
                return detailCell
            }

        }else if indexPath.section == 1 {

            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HOME_CELL , for: indexPath) as? HomeCell {
            
                cell.designView.fadeIn(duration: 0.6)
                cell.controller = self.homeController
                
                return cell
            }
        
        }
        
        return UICollectionViewCell()
    }
    
    
    @available(iOS 6.0, *)
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView? = nil
        
        if indexPath.section == 0 {
        
            if kind == UICollectionElementKindSectionHeader {
                
                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: HEADER_CELL, for: indexPath) as? DetailReusableV {
                    
                    headerView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(zoomInHeader)))
                    reusableView = headerView
                    
                }
                
            }
        
        }else if indexPath.section == 1 {
        
        
        }
        
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {

            self.collectionView.deselectItem(at: indexPath, animated: true )
                    
        }else if indexPath.section == 1 {
        
            let homeDetailVC = HomeDetailVC()
            homeDetailVC.homeController = self.homeController
            homeDetailVC.view.backgroundColor = UIColor.white
            self.navigationController?.pushViewController(homeDetailVC, animated: true)
            
        }

    }
    
}


extension HomeDetailVC : UICollectionViewDelegateFlowLayout {

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
        
            return CGSize(width: self.collectionView.frame.width , height: self.collectionView.frame.height / 12.0)
        
        }else if indexPath.section == 1 {
        
            return CGSize(width: (FRAME.size.width / 2.0) , height: FRAME.size.width  / 2.0 )
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        if section == 0 {
            
            return CGSize(width: self.collectionView.frame.size.width , height: self.collectionView.frame.height / 2.5)
       
        }else if section == 1 {
        
        }
        
        return CGSize.zero
    }

}










