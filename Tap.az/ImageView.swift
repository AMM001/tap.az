//
//  ImageView.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/2/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageView : UIImageView {
    
    var imageURLString : String?
    let activityIndicator = UIActivityIndicatorView()
    
    func loadImageWithUrl(_ urlString : String) {
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = ORANGE_COLOR
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        imageURLString = urlString
        
        if let url = URL(string: urlString) {
            
            image = nil
            activityIndicator.startAnimating()
            
            if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                self.image = imageFromCache
                activityIndicator.stopAnimating()
                return
            }
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil{
                    print(error as Any)
                    
                    DispatchQueue.main.async(execute: {
                        
                        self.activityIndicator.stopAnimating()
                 
                    })
                    
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    
                    if let imgaeToCache = UIImage(data: data!){
                        
                        if self.imageURLString == urlString {
                            self.image = imgaeToCache
                        }
                        
                        self.activityIndicator.stopAnimating()
                        imageCache.setObject(imgaeToCache, forKey: urlString as AnyObject)
                    }
                })
            }) .resume()
        }
    }
}
