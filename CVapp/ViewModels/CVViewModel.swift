//
//  CVViewModel.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-07.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
class CVViewModel {
    var cvDetails: CVDetails?
    var viewCurrentlyShowing = ViewShowingTypes.PersonalDetails
    var updateUI : Box<Bool?> = Box(nil)
    var showActivityIndicator: Box<Bool?> = Box(nil)
    var showAlert: Box<String?> = Box(nil)
    var errorOccured: Box<Bool?> = Box(nil)
    var showNoInternetMessage: Box<Bool?> = Box(nil)
    
    //MARK: - Menu Bar
    var menuBarItems: [String] {
        return [
            "Personal Info",
            "Professional Experience",
            "Projects Handled",
            "Academic Qualification"
        ]
    }
    
    func setUpModelData() {
        showActivityIndicator.value = true
        CVAppWebServiceCaller.getCVDetails(completionHandler: {[weak self] (cvDetails, errorMessage) in
            self?.showActivityIndicator.value = false
            if let _cvDetails = cvDetails {
                self?.cvDetails = _cvDetails
                self?.updateUI.value = true
            } else {
                self?.cvDetails = nil
                guard let error = errorMessage else {
                    return
                }
                if error == WebserviceError.noInternet.description {
                    self?.showNoInternetMessage.value = true
                } else {
                    self?.errorOccured.value = true
                    self?.showAlert.value = error
                }
               
            }
        })
    }
    
    //Loads json from local json file.
    func setUpModelFromLocalJson() {
        do {
            cvDetails = try takeLocalJsonData(of: ContentTypeIS.cvDetails)
            updateUI.value = true
            //TODO: make cvDetails in view model to private after unit testing
        } catch let error {
            print("error in decoding : \(error.localizedDescription)")
        }
    }
    
    //MARK: - Basic Details
    
    var phoneNumber: String? {
        guard let details = cvDetails else {
            return nil
        }
        let phone = details.basicDetails.phone
        return phone.formatPhoneNumber()
    }
    
    var basicDetails: BasicDetails? {
        guard let details = cvDetails else {
            return nil
        }
        return details.basicDetails
    }
    
    var technicalSkills: [String] {
        guard let details = cvDetails else {
            return []
        }
        return details.technicalSkills
    }
    
    var professionalExperience: [ProfessionalExperience] {
        guard let details = cvDetails else {
            return []
        }
        return details.professionalExperience
    }
    
    var projectsHandled: [ProjectsHandled] {
        guard let details = cvDetails else {
            return []
        }
        return details.projectsHandled
    }
    
    var companyNames: [String] {
        guard let details = cvDetails else {
            return []
        }
        return Array(Set(details.projectsHandled.map({$0.companyName}))).sorted()
    }
    

    func projectsUnder(company: String) -> [ProjectsHandled] {
        guard let details = cvDetails else {
            return []
        }
        return details.projectsHandled.filter({$0.companyName == company})
    }
    
    func projectsHandledIn(indexPath: IndexPath) -> [ProjectsHandled] {
        return projectsUnder(company: headerTitle[indexPath.section])
    }
    
    var experienceInFollowingAreas: [String] {
        guard let details = cvDetails else {
            return []
        }
        return details.technicalExperiences
    }
    
    var academicDetails: AcademicQualification? {
        guard let details = cvDetails else {
            return nil
        }
        return details.academicQualification
    }
    
    var references: [Reference] {
        guard let details = cvDetails else {
            return []
        }
        return details.references
    }
    
    //MARK: - TableView datasource
    var headerTitle: [String] {
        switch viewCurrentlyShowing {
        case .PersonalDetails:
            return [
                "Technical Skills",
                "Professional Experience",
                "Experience in following areas"]
        case .ProjectsHandled:
            return companyNames
        case .AcademicQualification:
            return ["Academic Qualification"]
        case .References:
            return ["Reference"]
        }
        
    }
    
    var numberOfSections: Int {
        return headerTitle.count
    }
    
    func numberOfRows(section: Int) -> Int {
        switch viewCurrentlyShowing {
        case .PersonalDetails:
            if section == 0 {
                return technicalSkills.count
            } else if section == 1 {
                return professionalExperience.count
            } else {
                return experienceInFollowingAreas.count
            }
        case .ProjectsHandled:
            return projectsUnder(company: headerTitle[section]).count
        case .AcademicQualification:
            return 1
        case .References:
            return references.count
        }
    }
    
    
}
//MARK: - Loading data from local json file
extension CVViewModel {
    func takeLocalJsonData<T: Decodable>(of type: ContentTypeIS ) throws -> T {
        let jsonPath = Bundle.main.path(forResource: type.fileName, ofType: type.fileType)
        guard let url = jsonPath else {
            throw JsonDecodingErrors.localJsonUrlIsse
        }
        guard let data = url.takeDataFromUrl() else {
            throw JsonDecodingErrors.unableToRetrieveDataFromPath
        }
        let decoder = JSONDecoder()
        do {
            switch type {
            case .cvDetails:
                return try decoder.decode(CVDetails.self, from: data) as! T
            }
        } catch let error {
            throw error
        }
    }
}
