//
//  LeftVC.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/17/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class LeftVC: UIViewController {
    
    let menuView : MenuView = {
        let view = MenuView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
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

    func setupViews () {
    
        // x , y , w, h constraints
        self.view.addSubview(self.menuView)
        self.menuView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.menuView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.menuView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.menuView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true

    }
    
    
}
