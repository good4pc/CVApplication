//
//  Webservice.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation

class WebService: NSObject {
    static func fetchData(from url: String, completionHandler:@escaping (Data?,Error?) -> Void ) throws {
        
        guard let url = URL(string: url) else {
            throw WebserviceError.urlError
        }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            let response = urlResponse as! HTTPURLResponse
            //TODO: Need to add more status code
            if response.statusCode == 200 {
                completionHandler(data,nil)
            }
            else {
                completionHandler(nil,error)
            }
            
            }.resume()
    }
}
