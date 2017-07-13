//
//  SideBar.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/7/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

fileprivate let SIDEBAR_CELL = "sideBarCell"
fileprivate let HEADER_FOOTER = "footerCell"

private struct Index  {

    var image : UIImage?
    var title : String?
    
}

class SideBar: UIView {
    
    fileprivate let menu : [Index] = [

        Index(image: #imageLiteral(resourceName: "ic_perm_identity") , title: "Menim elanlarim"),
        Index(image: #imageLiteral(resourceName: "ic_favorite_border") , title: "Secilmisler"),
        Index(image: #imageLiteral(resourceName: "ic_public") , title: "Dil"),
        Index(image: #imageLiteral(resourceName: "ic_facebook") , title: "Facebook"),
        Index(image: #imageLiteral(resourceName: "ic_instagram") , title: "Instagram"),
        Index(image: nil , title: nil),
        Index(image: nil , title: nil),
        Index(image: nil , title: nil),
        Index(image: #imageLiteral(resourceName: "ic_group") , title: "Dostlarini devet et"),
        Index(image: #imageLiteral(resourceName: "ic_email"), title: "Bizimle Elaqe")
        
    ]
    
    lazy var tableView : UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .plain)
        view.delegate = self
        view.isScrollEnabled = false
        view.dataSource = self
        view.separatorStyle = .none
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews () {
        
        self.addSubview(self.tableView)
        self.tableView.frame = CGRect(x: 0.0, y: 25.0, width: frame.size.width , height: frame.size.height)
        self.tableView.register(SideBarCell.self , forCellReuseIdentifier: SIDEBAR_CELL)
        self.tableView.register(UITableViewHeaderFooterView.self , forHeaderFooterViewReuseIdentifier: HEADER_FOOTER)
        
    }
    
}


extension SideBar : UITableViewDelegate , UITableViewDataSource  {

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {

        return self.menu.count
        
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: SIDEBAR_CELL, for: indexPath) as? SideBarCell {
        
            if indexPath.item == 3 || indexPath.item == 4 {
            
               cell.customImageView?.image = self.menu[indexPath.row].image
                
            }else {
            
                cell.customImageView?.image = self.menu[indexPath.row].image?.withRenderingMode(.alwaysTemplate)
                cell.customImageView?.tintColor = ORANGE_COLOR
            }
            
            cell.selectionStyle = .none
            cell.customTitleLabel?.text = self.menu[indexPath.row].title

            return cell
        }
    
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40.0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0.0 , y: 0.0 , width: frame.size.width , height: 150.0))
  
        let line = UIView(frame: CGRect(x: 2.0 , y: 0.0 , width: frame.size.width , height: 0.6))
        line.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        
        let supportImageView = UIImageView(frame: CGRect(x: 8.0, y: 10.0 , width: 20.0, height: 20.0))
        supportImageView.image = #imageLiteral(resourceName: "ic_info").withRenderingMode(.alwaysTemplate)
        supportImageView.tintColor = ORANGE_COLOR
        
        let textView = UITextView(frame: CGRect(x: supportImageView.frame.maxX + 8.0 , y: supportImageView.frame.minY , width: 160.0 , height: 100.0))
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(top: -5.0 , left: -2.0 , bottom: 0.0 , right: 0.0)
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: "Avenir", size: 11.0)
        textView.text = "Destek : \n\nxcode_man@icloud.com\n\n+994 556993322"
        
        
        footerView.addSubview(line)
        footerView.addSubview(supportImageView)
        footerView.addSubview(textView)
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 150.0
    }
    
}










