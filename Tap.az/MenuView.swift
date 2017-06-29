//
//  SlideOutMenu.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/11/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

fileprivate let MENU_CELL_IDENTIFIER = "MenuCell"

class MenuView : UIView {
    
    class Menu {
        
        var title : String?
        var image : UIImage?
        
        init(title : String? , image : UIImage?) {
            self.title = title
            self.image = image
        }
        
    }
    
    var user : User? { didSet { self.shareUserData() } }
    
    fileprivate let menu : [Menu] = [
        
        Menu(title: "Mənim Elanlarım", image: #imageLiteral(resourceName: "ic_perm_identity")) ,
        Menu(title: "Seçilmişlər", image: #imageLiteral(resourceName: "ic_favorite_border")),
        Menu(title: "Dil", image: #imageLiteral(resourceName: "ic_public")),
        Menu(title: "Facebook", image: #imageLiteral(resourceName: "ic_facebook")),
        Menu(title: "İnstagram", image: #imageLiteral(resourceName: "ic_instagram")),
        Menu(title: "", image: nil),
        Menu(title: "", image: nil),
        Menu(title: "", image: nil),
        Menu(title: "Dostlarını dəvət et", image: #imageLiteral(resourceName: "ic_group")),
        Menu(title: "Bizimlə əlaqə", image: #imageLiteral(resourceName: "ic_email")),
       
    ]
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
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
        self.addSubview(self.tableView)
        self.tableView.contentInset = UIEdgeInsets(top: 25.0, left: 0.0, bottom: 2.0, right: 0.0)
        self.tableView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.register(MenuCell.self ,  forCellReuseIdentifier: MENU_CELL_IDENTIFIER)
        self.tableView.separatorStyle = .none
        self.tableView.bounces = false
        
    }
    
    private func shareUserData () {
        
        
    }
    
}

// TABLEVIEWDELEGATE AND TABLEVIEWDATASOURCE FUNCTIONS
extension MenuView : UITableViewDelegate , UITableViewDataSource {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return self.menu.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MENU_CELL_IDENTIFIER, for: indexPath) as? MenuCell {
            
            cell.designTitleLabel.text = self.menu[indexPath.row].title
            
            if indexPath.row == 3 {
            
                cell.designImageView.image = self.menu[indexPath.row].image
                
            }else if indexPath.row == 4 {
            
                cell.designImageView.image = self.menu[indexPath.row].image
            
            }else {
        
                if self.menu[indexPath.row].image != nil {
                
                     cell.designImageView.image = self.menu[indexPath.row].image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                
                }else {
                
                    cell.selectionStyle = .none
                
                }
                
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 15.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath , animated: true )
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        let lineView = UIView(frame: CGRect(x: 1.0 , y: 5.0, width: self.tableView.frame.width - 2.0 , height: 0.5))
        lineView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.6)
        footerView.addSubview(lineView)
        
        let supportImageView = UIImageView(frame: CGRect(x: 10.0 , y: lineView.frame.maxY + 10.0 , width: self.tableView.frame.height / 30.0 , height: self.tableView.frame.height / 30.0))
        supportImageView.tintColor = ORANGE_COLOR
        supportImageView.image = #imageLiteral(resourceName: "ic_info").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        footerView.addSubview(supportImageView)
        
        let titleLabel = UILabel(frame: CGRect(x: supportImageView.frame.maxX + 10.0 , y: 0.0 , width: 140.0, height: supportImageView.frame.height))
        titleLabel.center.y = supportImageView.center.y
        titleLabel.textColor = ORANGE_COLOR
        titleLabel.font = UIFont(name: "Avenir", size: 14.0)
        titleLabel.text = "Dəstək :"
        footerView.addSubview(titleLabel)
        
        let emailLabel = UILabel(frame: CGRect(x: titleLabel.frame.minX , y: titleLabel.frame.maxY + 5.0 , width: 140.0, height: supportImageView.frame.height))
        emailLabel.font = UIFont(name: "Avenir", size: 12.0)
        emailLabel.text = "xcode_man@icloud.com"
        footerView.addSubview(emailLabel)
        
        let phoneLabel = UILabel(frame: CGRect(x: titleLabel.frame.minX , y: emailLabel.frame.maxY + 5.0 , width: 140.0, height: supportImageView.frame.height))
        phoneLabel.font = UIFont(name: "Avenir", size: 12.0)
        phoneLabel.text = "+994 556993322"
        footerView.addSubview(phoneLabel)
        
        return footerView
    }
    
}



