//
//  CategoryView.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/21/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

fileprivate let CATEGORY_CELL = "categoryCell"

struct Index  {
    
    var image : UIImage?
    var title : String?
    var count : Int?
    
}

class CategoryView: UIView {
    
    var delegate : UIViewController? {
    
        didSet {

        }
        
    }
    
    var menu : [Index]?
    
    lazy var tableView : UITableView = {
        var view = UITableView(frame: CGRect.zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        self.menu = [
            
            Index(image: #imageLiteral(resourceName: "shirt"), title: "Şəxsi əşyalar", count: 32011) ,
            Index(image: #imageLiteral(resourceName: "garden"), title: "Ev və bağ üçün", count: 15023) ,
            Index(image: #imageLiteral(resourceName: "device"), title: "Elektronika", count: 1002) ,
            Index(image: #imageLiteral(resourceName: "guitar"), title: "Hobbi və asudə", count: 812) ,
            Index(image: #imageLiteral(resourceName: "car"), title: "Nəqliyyat", count: 4100) ,
            Index(image: #imageLiteral(resourceName: "home"), title: "Daşınmaz əmlak", count: 61221) ,
            Index(image: #imageLiteral(resourceName: "bag"), title: "İş və biznes", count: 2102) ,
            Index(image: #imageLiteral(resourceName: "pet"), title: "Heyvanlar", count: 5903) ,
            
        ]
        
        
        self.setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView () {
        
        //1
        self.addSubview(self.tableView)
        self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor ).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor ).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.widthAnchor ).isActive = true
        self.tableView.heightAnchor.constraint(equalTo: self.heightAnchor ).isActive = true
        self.tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.tableView.addCorner(radius: 4.0, borderWidth: 1.0, color: UIColor.gray)
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.isScrollEnabled = false
        self.tableView.bounces = false
        self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.tableView.register(CategoryCell.self , forCellReuseIdentifier: CATEGORY_CELL)
        
    }

}


extension CategoryView : UITableViewDelegate , UITableViewDataSource {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
    
        if let count = self.menu?.count { return count }
        
        return 0
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CATEGORY_CELL, for: indexPath) as? CategoryCell {
        
            cell.index = self.menu?[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.tableView.frame.height / CGFloat(self.menu!.count + 2)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

}









