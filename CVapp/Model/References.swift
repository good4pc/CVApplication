//
//  References.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-09.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation

struct Reference: Decodable {
    var name: String
    var company: String
    var designation: String
    var profilePic: String
    var linkedinUrl: String
    var phone: String
    var profileImageDownloaded: Data?
    
    mutating func updateImage(with data: Data?) {
        guard let data = data else {
            return
        }
        profileImageDownloaded = data
    }
}
