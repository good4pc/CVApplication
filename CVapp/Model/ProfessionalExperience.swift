//
//  ProfessionalExperience.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
struct ProfessionalExperience: Decodable {
    var designation: String
    var companyName: String
    var currentCompany: Bool
    var startDate: String
    var endDate: String
    var companyUrl: String
    var companyLogoURl: String
    var companyId: Int
    
    var companyImageDownloaded: Data?
    
    mutating func updateImage(with data: Data?) {
        guard let data = data else {
            return
        }
        companyImageDownloaded = data
    }
}
