//
//  ProjectsHandled.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
struct ProjectsHandled: Decodable {
    var companyName: String
    var companyId: Int
    var projectTitle: String
    var description: String
    var programmingLanguage: String
    var rolesAndResponsibilities: [String]
}
