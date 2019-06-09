//
//  Constants.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-06.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
import UIKit

let alertTitle = "CVapp"
let alertOkButton = "Ok"
let menuButtonImageName = "menu"
let rolesAndResponsibilitiesText = "Roles And Responsibilities :- "
let programmingLanguagePrefix = "Programing Language - "
let noInternetText = "No Internet"
let unableToLoadWebsiteData = "Unable to load website"
let menuBarAnimationSpeed = 0.3
let heightForHeader: CGFloat = 35.0
let underLineColorOFCustomView = UIColor(red: 34/255, green: 150/255, blue: 60/255, alpha: 1.0)

enum WebserviceUrl: String {
    case cvDetails
    
    var url: String {
        switch self {
        case .cvDetails:
            return "https://gist.githubusercontent.com/good4pc/48a3e9a8cacb3376cf091f0011e71557/raw/60e46601ae96b6e17393a1a9248381473cc1b336/CVData"
        }
    }
}

enum ViewShowingTypes {
    case PersonalDetails
    case ProjectsHandled
    case AcademicQualification
    case References
    
    var title: String {
        switch self {
        case .PersonalDetails:
            return "Home"
        case .ProjectsHandled:
            return "Projects Handled"
        case .AcademicQualification:
            return "Academic Qualification"
        case .References:
            return "References"
        }
    }
}
enum ContentType {
    case cvDetails
    
    
    var fileName: String {
        switch self {
        case .cvDetails:
            return "cvDetails"
        }
        
    }
}

enum ContentTypeIS {
    case cvDetails
    var fileName: String {
        switch self {
        case .cvDetails:
            return "CVData"
        }
    }
    var fileType: String {
        return "json"
    }
}




enum JsonDecodingErrors: Error {
    case localJsonUrlIsse
    case unableToRetrieveDataFromPath
    case decodingIssue
}

//MARK: - Webservice Error

enum WebserviceError: Error {
    case urlError
    case decodingError
    case localJsonUrlIssue
    case unableToRetrieveDataFromPath
    case dataIsNil
    case somethingGoneWrong
    case noInternet
    
    var description: String {
        switch self {
        case .urlError:
            return "error in url passed to the method"
        case .dataIsNil:
            return "Data found nil"
        case .decodingError:
            return "Unable to decode data"
        case .localJsonUrlIssue:
            return "local Json URl Issue"
        case .unableToRetrieveDataFromPath:
            return "unable to retrieve data from local path"
        case .somethingGoneWrong:
            return "Something gone wrong"
        case .noInternet:
            return "No Internet"
        }
    }
}

