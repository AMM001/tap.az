//
//  Parser.swift
//  tap.az
//
//  Created by Ozal Suleyman on 7/2/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import Foundation

class OZJSONParser: NSObject {
    
    // You should know local file will available readonly feature .
    open class func parseLocalFile (resourse : String? , type : String? , completion : @escaping  ( _ json : Any )-> () ) {
        // Getting local file path , where localized your bundle .
        if let file = Bundle.main.path(forResource: resourse , ofType: type) {
            
            // Getting local data into your file
            if let data = try? NSData(contentsOfFile: file , options: .dataReadingMapped)  {
                
                // Parsing json components from your own data .
                if let json = try? JSONSerialization.jsonObject(with: data as Data , options: .mutableContainers) {
                    // Passing json data to the viewcontroller with async block
                    DispatchQueue.main.async { completion (json)  }
                }
                
            }
            
        }
        
    }
    
    // Sending GET request to url
    open class func GETRequest (urlString : String , completion : @escaping ( _ json : Any) -> () )  {
        
        // make url from urlstring
        guard let url = URL(string: urlString ) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // making session
        let session = URLSession.shared
        session.dataTask(with: request) { (data , responce , error ) in
            
            // handle error localized description
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            // handle data if nil
            guard let data = data else { return }
            
            do {
                // Getting json data from your url
                let json = try JSONSerialization.jsonObject(with: data , options: JSONSerialization.ReadingOptions.mutableContainers)
                // Passing json data to the viewcontroller with async block
                DispatchQueue.main.async { completion(json) }
                
            }catch { }
            
            }.resume()
        
    }
    
    // Sending POST request to url
    open class func POSTRequest (urlString : String , parameters : [String : String] , completion : @escaping ( _ json : Any) -> () )  {
        
        // make url from urlstring
        guard let url = URL(string: urlString ) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // HTTPS sertificate check
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            // handle data
            if let data = data {
                do {
                    // Getting json data from your url
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    // Passing json data to the viewcontroller with async block
                    DispatchQueue.main.async { completion(json) }
                } catch { print(error) }
            }
            
            }.resume()
        
    }
    
    // Sending POST request to url
    internal func POSTRequestWithMedia (urlString : String , parameters : [String : String] , media : [Media]? , clientID : String , completion : @escaping ( _ json : Any) -> () )  {
        
        // make url from urlstring
        guard let url = URL(string: urlString ) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // generate boundy
        let boundary = self.generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")
        
        // make data body
        let dataBody = createDataBody(withParameters: parameters, media: media , boundary: boundary)
        request.httpBody = dataBody
        
        // making session
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async { completion(json) }
                    
                } catch {
                    print(error)
                }
                
            }
            
            }.resume()
        
    }
    
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(withParameters params: [String : String]? , media: [Media]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
    
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

// this could be image , video and so on .
struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "ozalsuleyman.jpg"
        guard let data = UIImageJPEGRepresentation(image, 0.7) else { return nil }
        self.data = data
    }
    
}

