//
//  CVModel.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-07.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation

struct CVDetails: Decodable {
    var basicDetails: BasicDetails
    var technicalSkills: [String]
    var professionalExperience: [ProfessionalExperience]
    var technicalExperiences: [String]
    var personalityTraits: [String]
    var projectsHandled: [ProjectsHandled]
    var academicQualification: AcademicQualification
    var references: [Reference]
}






