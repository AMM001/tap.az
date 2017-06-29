//
//  UIViewController.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/12/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavBarVisible(visible:Bool, animated:Bool) {
        
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        // bail if the current state matches the desired state
        if (navBarIsVisible() == visible) { return }
        // get a frame calculation ready
        let frame = self.navigationController?.navigationBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? height : (-height!-10))
        
        // zero duration means no animation
        let duration:TimeInterval = (animated ? 0.6 : 0.6)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.navigationController?.navigationBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }
    
    func navBarIsVisible() ->Bool {
        return self.navigationController!.navigationBar.frame.origin.y < self.view.frame.maxY
    }
    
    func setTabBarVisible(visible:Bool, animated:Bool) {
        
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration:TimeInterval = (animated ? 0.6 : 0.6)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBarController!.tabBar.frame.origin.y < self.view.frame.maxY
    }
    


}
