//
//  CVViewModelTests.swift
//  CVappTests
//
//  Created by Prasanth pc on 2019-06-07.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import XCTest

class CVViewModelTests: XCTestCase {
    
    var model: CVViewModel!
    var cvDetails: CVDetails!
    
    override func setUp() {
        model = CVViewModel()
        setUpModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: - Decoding Data from local file
    func setUpModel() {
        do {
            cvDetails = try takeLocalJsonData(of: ContentTypeIS.cvDetails)
            //TODO: make cvDetails in view model to private after unit testing
            model.cvDetails = cvDetails
        } catch let error {
            print("error in decoding : \(error.localizedDescription)")
        }
    }
    
    //MARK: - DataSource
    
    func testBasicDetails() {
        guard let basicDetails = model.basicDetails else {
           XCTAssertNil(model.basicDetails, "not nil")
            return
        }
        XCTAssertEqual(basicDetails.name, "Prasanth Puthukkeri Chothi")
        
    }
    
    func testTechnicalSkills() {
        let technicalSkills = model.technicalSkills
        XCTAssertEqual(technicalSkills.count, 3)
    }
    
    func testProfessionalExperience() {
        let professionalExperience = model.professionalExperience
        XCTAssertEqual(professionalExperience.count, 4)
    }
    
    func testNumberOfSectionsForPersonalInfor() {
        let personalInfoHeaderTitle = model.headerTitle
        XCTAssertEqual(personalInfoHeaderTitle.count, 3)
    }
    
    func testProjectsHandled() {
        let projectsHandled = model.projectsHandled
        XCTAssertEqual(projectsHandled.count, 12)
    }
    
    func testCompanyName() {
        let compnayName = model.companyNames
        XCTAssertEqual(compnayName, ["Fingent Technology Solutions Pvt Ltd","Indigo Books And Musics","Infotura Technologies","Mfluid Mobile Apps"])
    }
    
    func testProjectsHandledIn() {
       
        let projectsHAndled = model.projectsUnder(company: "Mfluid Mobile Apps")
        XCTAssertEqual(projectsHAndled.count, 5)
    }
    
    func testProjectsHandledUnderTheCompany() {
        let index = IndexPath(row: 0, section: 1)
        print(model.projectsHandledIn(indexPath: index).count)
        XCTAssert(model.projectsHandledIn(indexPath: index).count == 0)
    }
    func testAcademicQualification() {
        XCTAssertNotNil(model.academicDetails)
       
    }
    
    func testExperienceInFollowingAread() {
          XCTAssertEqual(model.experienceInFollowingAreas.count, 15)
       
    }
    
    func testNumberOfRowsinTableView() {
        model.viewCurrentlyShowing = .PersonalDetails
        XCTAssertEqual(model.numberOfRows(section: 0), 3)
        
        model.viewCurrentlyShowing = .AcademicQualification
        XCTAssertEqual(model.numberOfRows(section: 2), 1)
    }
    
    func testCasesWhenCVDetailsAreNil() {
        model.cvDetails = nil
        XCTAssertEqual(model.experienceInFollowingAreas.count, 0)
         XCTAssertNil(model.academicDetails)
        XCTAssertEqual(model.projectsUnder(company: "Mfluid Mobile Apps").count, 0)
        XCTAssertEqual(model.companyNames.count, 0)
        XCTAssertEqual(model.projectsHandled.count, 0)
        XCTAssertEqual(model.professionalExperience.count, 0)
        XCTAssertEqual(model.technicalSkills.count, 0)
        XCTAssertEqual(model.references.count, 0)

        testBasicDetails()

    }
     func testMenuBarItems() {
        XCTAssertEqual(model.menuBarItems.count, 4)
    }
    
    func testReferences() {
        XCTAssertEqual(model.references.count, 1)
    }
    
}

extension CVViewModelTests {
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


