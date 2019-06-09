//
//  Extensions.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-07.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
import  UIKit

extension String {
    func takeDataFromUrl() -> Data? {
        do {
            let url = URL(fileURLWithPath: self)
            let data = try Data(contentsOf: url, options: .dataReadingMapped)
            return data
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func formatPhoneNumber() -> String {
        return self.components(separatedBy: CharacterSet(charactersIn: "0123456789+").inverted).joined(separator: "")
    }
}

extension UIImageView {
    //MARK: Download image from url and set
    
    func downloadImage(from url: String , completionHandler: @escaping (Data?) -> Void) {
        
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            guard let url = URL(string: url) else {
                DispatchQueue.main.async {
                    self.image = nil
                }
                completionHandler(nil)
                return
            }
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async(execute: {
                        self.image = image
                    })
                    completionHandler(data)
                } else {
                    DispatchQueue.main.async {
                        self.image = nil
                    }
                    completionHandler(nil)
                }
                }.resume()
        }
    }
}


extension UIView {
    func addActivityIndicator() {
        DispatchQueue.main.async {
            let activityIndicatore = UIActivityIndicatorView(style: .gray)
            activityIndicatore.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            activityIndicatore.center = self.center
            activityIndicatore.tag = 563
            self.addSubview(activityIndicatore)
            activityIndicatore.startAnimating()
        }
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.viewWithTag(563) {
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
