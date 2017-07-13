
//
//  HomeVC.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/2/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit
import CoreData

fileprivate let HOME_CELL_IDENTIFIER = "homeCell"
fileprivate let HOME_HEADER_VIEW = "headerView"

class HomeVC: UICollectionViewController {
    
    var ads : [Ad]?
    var filteredAds : [Ad]?
    var searchBarActive : Bool = false
    var searchBarYPosition : CGFloat?
    var searchBar : UISearchBar?
    var refreshControl : UIRefreshControl?
    
    let sideBar : CDRTranslucentSideBar = {
        let view = CDRTranslucentSideBar()
        view?.translucent = false
        view?.view.shadow = true 
        return view!
    }()
    
    let activityIndicator : OZActivityIndicator = {
        let view = OZActivityIndicator(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = UIColor.white
        view.strokeColor = UIColor.white
        view.lineWidth = 4.0
        view.animationDuration = 0.5
        view.hidesWhenStopped = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        
        if !self.checkIfUserLoggedIn() {
        
            let loginController = LoginVC()
            loginController.view.backgroundColor = ORANGE_COLOR
            self.present(loginController, animated: true , completion: nil)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("appear")
         STATUSBAR_VIEW.backgroundColor = ORANGE_COLOR
    }
    
    fileprivate func setupViews () {
        self.setupNavBar()
        self.setupSearchBar()
        self.setupSideBar()
        self.setupCollectionView()
        self.fetchData()
    }
    
    deinit {
        self.removeObservers()
    }
    
    fileprivate func checkIfUserLoggedIn () -> Bool {
        
        var loginUser : User?
        
        let fetchRequest : NSFetchRequest<User>  = User.fetchRequest()
        
        do {
            
            let users = try PersistenseManager.context.fetch(fetchRequest)
            
            for user in users {
                
                loginUser = user
                
            }
            
        }catch { }
        
        let guset = UserDefaults.standard.value(forKey: "guest") as? String
        
        if guset == "guest" || loginUser?.name != nil {
            return true
        }
        
        return false
    }
    
    private func setupNavBar () {
    
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.backgroundColor = ORANGE_COLOR
        
        let sideBarButton  = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_reorder"), style: .plain , target: self , action: #selector(handleSideBar))

        let accountBarButton  = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_account_circle"), style: .plain , target: self , action: #selector(handleAccount))
        let likeBarButton  = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_favorite_border") , style: .plain , target: self , action: #selector(handleAccount))
        let addBarButton  = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_add"), style: .plain , target: self , action: #selector(handleAdd))
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = sideBarButton
        self.navigationItem.rightBarButtonItems =  [ addBarButton , likeBarButton , accountBarButton ]
        
        let titleLabel = UILabel(frame: FRAME)
        titleLabel.text = "tap.az"
        titleLabel.textColor = UIColor.white
        titleLabel.contentMode = .scaleToFill
        titleLabel.font = UIFont(name: HELVETICA_NEUE_BOLD , size: 22)
        self.navigationItem.titleView = titleLabel
        
    }
    
    private func setupSideBar () {

        let sideBarView : SideBar = SideBar(frame: CGRect(x: 0.0 , y: 0.0 , width: FRAME.size.width / 2.0 , height: FRAME.size.height))
        self.sideBar.delegate = self
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self , action: #selector(handlePanGesture)))
        self.sideBar.setContentViewIn(sideBarView)
        
    }
    
    private func setupCollectionView () {
        
        // 1
        self.collectionView?.backgroundColor = ORANGE_COLOR
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 150.0 , left: 0.0 , bottom: 0.0 , right: 0.0)
        self.collectionView?.contentInset = UIEdgeInsets(top: 1.0 , left: 8.0 , bottom: 2.0 , right: 8.0)
        self.collectionView?.register(HomeCell.self , forCellWithReuseIdentifier: HOME_CELL_IDENTIFIER)
        self.collectionView?.register(HomeHeaderView.self  , forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HOME_HEADER_VIEW)
   
        
        // 2
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.white
        self.refreshControl?.addTarget(self , action: #selector(refresh), for: .valueChanged)
        self.collectionView?.refreshControl = self.refreshControl
        
        // 3
        self.collectionView!.addSubview(self.activityIndicator)
        self.activityIndicator.topAnchor.constraint(equalTo: self.collectionView!.topAnchor , constant : 200.0).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.collectionView!.centerXAnchor).isActive = true
        self.activityIndicator.widthAnchor.constraint(equalToConstant : 40.0 ).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant : 40.0).isActive = true
        self.activityIndicator.isHidden = true
        
        
    }
    
    @objc fileprivate func refresh () {
    
        self.ads = nil
        self.reloadCollectionView()
        self.activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: {
        // Backgrund queue
            
            DispatchQueue.main.async {
                // main queue
                self.fetchData()
                self.refreshControl?.endRefreshing()
                self.activityIndicator.stopAnimating()
                
            }
        })
    
    }
    
    
    private func setupSearchBar () {

        if self.searchBar == nil {
            
            self.searchBarYPosition = self.navigationController!.navigationBar.frame.size.height + 20.0
            
            self.searchBar = UISearchBar(frame: CGRect(x: 0.0 , y: self.searchBarYPosition! , width: FRAME.size.width , height: 44.0))
            self.searchBar!.delegate = self
            self.searchBar!.tintColor = UIColor.white
            self.searchBar!.layer.borderWidth = 1.0
            self.searchBar!.layer.borderColor = ORANGE_COLOR.cgColor
            self.searchBar!.searchBarStyle = .minimal
            let searchbarTextField = (self.searchBar!.value(forKey: "searchField") as! UITextField)
            searchbarTextField.textColor = UIColor.white
            searchbarTextField.attributedPlaceholder = NSMutableAttributedString(string: "Axtar",
                                                                                 attributes: [
                                                                                    NSFontAttributeName : UIFont(name: "Avenir", size: 30.0)! ,
                                                                                    NSForegroundColorAttributeName : UIColor.white ])
            searchbarTextField.font = UIFont(name: "Avenir", size: 14.0)
            self.searchBar!.barTintColor = UIColor.white
            self.searchBar!.backgroundColor = ORANGE_COLOR
            let glassIcon = searchbarTextField.leftView as! UIImageView
            glassIcon.image =  glassIcon.image?.withRenderingMode(.alwaysTemplate)
            glassIcon.tintColor = UIColor.white
            
            self.addObservers()
            
        }
        
        if !self.searchBar!.isDescendant(of: self.view) {
            self.view.addSubview(self.searchBar!)
        }

    }
    
    func addObservers () {
        
        let context = UnsafeMutablePointer<Int>(bitPattern : 1)
        self.collectionView?.addObserver( self , forKeyPath: "contentOffset", options: [.new , .old ], context: context)
   
    }
    
    func removeObservers () {
        self.collectionView?.removeObserver(self , forKeyPath: "contentOffset")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "contentOffset" {
            
            if let collectionView = object as? UICollectionView {
                
                self.searchBar?.frame = CGRect(x: self.searchBar!.frame.origin.x , y: self.searchBarYPosition! + ( (-1 * collectionView.contentOffset.y ) - self.searchBarYPosition!), width: self.searchBar!.frame.size.width , height: self.searchBar!.frame.size.height)
                
            }
            
        }
        
    }
    
    fileprivate func fetchData () {
    
        Parser.parseLocalFile(resourse: "home", type: "json") { ( json ) in
            
            self.ads = []
            
            if let dictionary = json as? NSDictionary {
            
                if let ads = dictionary["ads"] as? NSArray {

                    for i in 0..<ads.count {
                    
                        if let adDictionary = ads[i] as? NSDictionary {
                        
                            let country = adDictionary["country"] as? String
                            let date = adDictionary["date"] as! String?
                            let image = adDictionary["image"] as? String
                            let location = adDictionary["location"] as? String
                            let model = adDictionary["model"] as? String
                            let name = adDictionary["name"] as? String
                            let price = adDictionary["price"] as? String
                            let year = adDictionary["year"] as? String
                        
                            let ad = Ad(name: name , model: model , image: image , location: location , price: price , year: year , country : country , date : date)
                            self.ads?.append(ad)
                
                        }
                    
                    }

                }
            
            }
            
            self.reloadCollectionView()
        
        }
    
    }
    
    func reloadCollectionView (){
    
        DispatchQueue.main.async {
            print("collectionview reload...")
            self.collectionView?.reloadData()
        }
        
    }
    
    @objc fileprivate func handleSideBar () {
    
        self.sideBar.show()
    }
    
    @objc fileprivate func handleAccount () {
        
        
    }
    
    @objc fileprivate func handleAdd () {
        
        let newAdController = NewAdVC()
        newAdController.view.backgroundColor = UIColor.orange
        self.navigationController?.show(newAdController , sender: self)
        
    }

    
    @objc fileprivate func handlePanGesture (gesture : UIPanGestureRecognizer) {
    
        if gesture.state == UIGestureRecognizerState.began {
        
            let startPoint = gesture.location(in: self.view)
            
            if startPoint.x < self.view.bounds.size.width / 2.0  {
        
                self.sideBar.isCurrentPanGestureTarget = true
            
            }
        
        }
    
        self.sideBar.handlePanGesture(toShow: gesture , in: self.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    @available(iOS 6.0, *)
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.searchBarActive  {
        
            if let count = self.filteredAds?.count {
            
                return count
            }
        
        }
        
        if let count = self.ads?.count {
            return count
        }
        
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HOME_CELL_IDENTIFIER , for: indexPath) as? HomeCell {
            
            homeCell.controller = self
            homeCell.desigView.fadeIn(duration: 0.5)
            
            if self.searchBarActive  {
        
                homeCell.ad = self.filteredAds?[indexPath.row]
                
            }else {
            
                homeCell.ad = self.ads?[indexPath.row]
            }
            
            return homeCell
        }
        
        return UICollectionViewCell()
    }
    

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
        
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader , withReuseIdentifier: HOME_HEADER_VIEW , for: indexPath) as? HomeHeaderView  {
            
                headerView.delegate = self
                
                return headerView
            }
        
        }
    
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? HomeCell {
        
            let detailController = DetailVC()
            detailController.view.backgroundColor = UIColor.white
            detailController.ad = cell.ad
            detailController.controller = self
            self.navigationController?.show(detailController , sender: nil )
            
        }
        
    }
    
    // my custom zooming
    var startingFrame : CGRect?
    var blackBackgroudView : UIView?
    
    func zoomInImageView (startingImageView : UIImageView ) {
        
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
        
            })
            
        }
        
    }
    
}

extension HomeVC : UICollectionViewDelegateFlowLayout  {

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: (FRAME.size.width - 17.0) / 2.0 , height: (FRAME.size.width - 17.0) / 2.0 )
    }
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
        return CGSize(width: FRAME.size.width , height: 140.0)
    }
    
}


extension HomeVC : UISearchBarDelegate {
    
    func filterContentForSearchText (searchText : String) {
        
        self.filteredAds = self.ads?.filter({ ( ad ) in
            return ad.name!.lowercased().contains(searchText.lowercased())
        })
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count > 0 {
            
            self.searchBarActive = true
            self.filterContentForSearchText(searchText: searchText)
            self.collectionView?.reloadData()
            
        } else {
            
            self.searchBarActive = false
            self.collectionView?.reloadData()
            
        }
        
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.cancelSearching()
        self.collectionView?.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBarActive = true
        self.view.endEditing(true)
    
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBarActive = false
        self.searchBar?.setShowsCancelButton(true , animated: true)
        
    }
    
    func cancelSearching(){
        self.searchBarActive = false
        self.searchBar?.setShowsCancelButton(false , animated: true)
        self.searchBar!.resignFirstResponder()
        self.searchBar!.text = ""
    }
    
}

// HEADERVIEW ACTIONS
extension HomeVC  {

    @objc func pushToCategoryController (sender : OZRippleButton) {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        let categoryController = CategoryVC(collectionViewLayout: layout)
        categoryController.collectionView?.backgroundColor = UIColor.orange
        self.navigationController?.show(categoryController , sender: self)
        
    }
    
}


extension HomeVC : CDRTranslucentSideBarDelegate {

    

}














