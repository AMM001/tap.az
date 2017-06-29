//
//  HomeVC.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/17/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

fileprivate let HOME_CELL_IDENTIFIER = "homeCell"
fileprivate let HEADER_CELL = "headerCell"

class HomeVC: UIViewController {
    
    lazy var leftSideBar : CDRTranslucentSideBar = {
        
        let bar = CDRTranslucentSideBar()
        bar?.delegate = self
        bar?.translucent = false
        bar?.view.shadow = true
        bar?.view.layer.masksToBounds = false
        bar?.sideBarWidth = FRAME.size.width / 2
        bar?.animationDuration = 0.4
        return bar!
        
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 0.0
        let view = UICollectionView(frame: CGRect.zero , collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    lazy var collectionHeaderSearchView : UIView = {
        let view = UIView(frame: CGRect(x: 2.0, y: 0.0, width: FRAME.size.width - 6.0 , height: 44.0))
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var searcBarBottomView : SearchBarBottomView = {
        let view = SearchBarBottomView(frame: CGRect(x: 8.0 , y: 48.0, width: FRAME.size.width - 16.0 , height: 96))
        view.backgroundColor = UIColor.white
        view.delegate = self 
        view.addShadow(shadowColor: UIColor.lightGray.cgColor , shadowOffset: CGSize(width: 1.0, height: 1.0), shadowOpacity: 0.6 , shadowRadius: 2.0)
        view.addCorner(radius: 4.0, borderWidth: 1.0, color: UIColor.white)
        return view
    }()
    
    let refreshControl : UIRefreshControl = {
        let view = UIRefreshControl()
        view.tintColor = UIColor.white
        return view
    }()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavBar()
        self.setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    fileprivate func setupNavBar() {
        
        let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_reorder"), style: .plain, target: self , action: #selector(handeSideMenu))
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.hidesBarsOnSwipe = true
        
        let pageTitleLabel = UILabel(frame: FRAME)
        pageTitleLabel.textColor = UIColor.white
        pageTitleLabel.text = "tap.az"
        pageTitleLabel.font = UIFont(name: "AvenirNext-Bold", size: 25.0)
        self.navigationItem.titleView = pageTitleLabel
        
        let panGestureReconizer = UIPanGestureRecognizer(target: self , action: #selector(panGesture))
        self.view.addGestureRecognizer(panGestureReconizer)
        
        let myAdButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_account_circle"), style: .plain, target: self , action: #selector(handleMyAd))
        let choosenAd = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_favorite_border"), style: .plain, target: self , action: #selector(handleChoosenAd))
        let addAdButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_add"), style: .plain, target: self, action: #selector(handleAdd))

        self.navigationItem.rightBarButtonItems = [addAdButton , choosenAd , myAdButton]
        
    }
    
    fileprivate func setupViews () {
        
        self.view.backgroundColor = ORANGE_COLOR
        self.collectionView.backgroundColor = ORANGE_COLOR
        
        // 1
        self.view.addSubview(self.collectionView)
        self.collectionView.contentInset = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 0.0, right: 1.0)
        self.collectionView.register(HomeCell.self , forCellWithReuseIdentifier: HOME_CELL_IDENTIFIER)
        self.collectionView.register(UICollectionReusableView.self , forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HEADER_CELL)
        self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
    
        // 2
        let menuView = MenuView(frame: CGRect(x: 0.0, y: 0.0, width: FRAME.size.width / 1.6, height: FRAME.size.height))
        self.leftSideBar.setContentViewIn(menuView)
        menuView.backgroundColor = UIColor.white
        
        
        // 3 customize searchbar
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.tintColor = UIColor.white
        self.searchController.searchBar.layer.borderWidth = 1.0
        self.searchController.searchBar.layer.borderColor = ORANGE_COLOR.cgColor
        self.searchController.searchBar.searchBarStyle = .minimal
        let searchbarTextField = (self.searchController.searchBar.value(forKey: "searchField") as! UITextField)
        searchbarTextField.textColor = UIColor.white
        searchbarTextField.attributedPlaceholder = NSMutableAttributedString(string: "Axtar",
                                                                             attributes: [
                                                                                NSFontAttributeName : UIFont(name: "Avenir", size: 30.0)! ,
                                                                                NSForegroundColorAttributeName : UIColor.white ])
        searchbarTextField.font = UIFont(name: "Avenir", size: 14.0)
        self.searchController.searchBar.barTintColor = UIColor.white
        self.searchController.searchBar.backgroundColor = ORANGE_COLOR
        let glassIcon = searchbarTextField.leftView as! UIImageView
        glassIcon.image =  glassIcon.image?.withRenderingMode(.alwaysTemplate)
        glassIcon.tintColor = UIColor.white
        self.collectionHeaderSearchView = self.searchController.searchBar
        
    
        // 4
        self.refreshControl.addTarget(self , action: #selector(refresh), for: .valueChanged)
        self.refreshControl.attributedTitle = NSMutableAttributedString(string: "Yüklənir", attributes:
            [ NSFontAttributeName : UIFont(name: "Helvetica", size: 10.0)! ,
            NSForegroundColorAttributeName : UIColor.white.withAlphaComponent(0.8) ] )
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.refreshControl = refreshControl
    
    }
    
    var count = 30
    
    func refresh () {
    
        self.count = 0
        self.collectionView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 , execute: {
        
            self.count = 30
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            
        })

    }

    func stopRefresh () {
    
        self.refreshControl.endRefreshing()
    }
    
    func handeSideMenu (button : UIBarButtonItem) {
    
        self.leftSideBar.show(animated: true)
        
    }
    
    func handleMyAd () {
    
        
    }
    
    func handleChoosenAd () {
    
        
    }
    
    func handleCategorys () {
        
        let catController = CategoryVC()
        catController.view.backgroundColor = ORANGE_COLOR
        self.navigationController?.show(catController , sender: self )
        
    }
    
    func handleAdd () {
        
        let newAdController = NewAdVC()
        newAdController.delegate = self 
        newAdController.view.backgroundColor = ORANGE_COLOR
        self.navigationController?.pushViewController( newAdController , animated: true )
    
    }
    

    func swipeUp () {
    
        let indexPath = IndexPath(row: 0 , section: 0)
        self.collectionView.scrollToItem(at: indexPath , at: .top , animated: true )
        
    }
    
    func swipeDown () {
        
        let indexPath = IndexPath(row: self.count - 1, section: 0)
        self.collectionView.scrollToItem(at: indexPath , at: .bottom , animated: true )
        
    }
    
    
    func panGesture (gesture : UIPanGestureRecognizer ) {
        
        if gesture.state == .began {
            
            let startPoint = gesture.location(in: self.view)
            
            if startPoint.x < self.view.bounds.size.width / 2.0  {
                self.leftSideBar.isCurrentPanGestureTarget = true
            }else {
                self.leftSideBar.isCurrentPanGestureTarget = false
            }
        }
        
        self.leftSideBar.handlePanGesture(toShow: gesture, in: self.view)
        
    }
    
    // my custom zooming
    var startingFrame : CGRect?
    var blackBackgroudView : UIView?
    var label : UILabel?
    
    func zoomInImageView (startingImageView : UIImageView , label : UILabel?) {
    
        self.label = label
        label?.fadeOut(duration: 0.2)
    
        startingFrame = startingImageView.superview?.convert(startingImageView.frame , to: nil)
        
        let zoomingImageView = UIImageView(frame: self.startingFrame!)
        zoomingImageView.backgroundColor = UIColor.white
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.contentMode = .scaleToFill
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
                self.label?.fadeIn(duration: 0.5)
                
            })
            
        }
        
    }
    
}

extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HOME_CELL_IDENTIFIER, for: indexPath) as? HomeCell {
            
            homeCell.designView.fadeIn(duration:  0.6)
            homeCell.controller = self
        
            return homeCell
        }
        
        return UICollectionViewCell()
        
    }
  
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView? = nil
        
        if indexPath.section == 0 {
        
            if kind == UICollectionElementKindSectionHeader {
                
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: HEADER_CELL, for: indexPath)
                headerView.frame = CGRect(x: 0.0 , y: 0.0 , width: FRAME.size.width , height: 150.0)
                headerView.backgroundColor = ORANGE_COLOR
                headerView.addSubview(self.collectionHeaderSearchView)
                headerView.addSubview(self.searcBarBottomView)
                
                reusableView = headerView
            }
        
        }
    
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true )
        
        let homeDetailVC = HomeDetailVC()
        homeDetailVC.homeController = self
        homeDetailVC.view.backgroundColor = UIColor.white
        self.navigationController?.pushViewController(homeDetailVC, animated: true)
        
    }
  
}

extension HomeVC : UICollectionViewDelegateFlowLayout {
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((FRAME.size.width - 3.0) / 2.0) , height: (FRAME.size.width - 2.0) / 2.0 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width , height: 150.0)
    }
    
}

extension HomeVC : CDRTranslucentSideBarDelegate {
    
    func sideBar(_ sideBar: CDRTranslucentSideBar!, willAppear animated: Bool) {
        
//        print("side bar appear...")
//        
//        if sideBar == self.leftSideBar {
//            self.collectionView.swipeToRight(distance: FRAME.size.width / 4.0)
//            self.navigationController?.navigationBar.swipeToRight(distance: FRAME.size.width / 4.0)
//        }
    
    }
    
    func sideBar(_ sideBar: CDRTranslucentSideBar!, willDisappear animated: Bool) {
        
//        if sideBar == self.leftSideBar {
//            self.collectionView.swipeToLeft(distance: FRAME.size.width / 4.0)
//            self.navigationController?.navigationBar.swipeToLeft(distance: FRAME.size.width / 4.0)
//        }
//    
    }
    
}

extension HomeVC : UISearchResultsUpdating {
    
    fileprivate func updateSearchResult (text : String) {
    
        
    }

    // Called when the search bar's text or scope has changed or when the search bar becomes first responder.
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {

        self.updateSearchResult(text: searchController.searchBar.text!)
        
    }

}



