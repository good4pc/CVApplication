//
//  CVViewController.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-06.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit


class CVViewController: BaseView {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var basicDetailsView: PersonalInfoView!
    
    fileprivate let bulletPointTableViewIDentifier = "bulletPointTableViewIDentifier"
    fileprivate let profecssionalExperienceHighLights = "profecssionalExperienceHighLights"
    fileprivate let projectHandledIdentifier = "projectHandledIdentifier"
    fileprivate let academicQualificationTableViewCell = "AcademicQualificationTableViewCell"
    fileprivate let referenceIdentifier = "ReferenceTableViewCell"
    weak var delegate: MenuButtonDelegate?
    let model = CVViewModel()
    var rowSelected = 0
    fileprivate var refreshController = UIRefreshControl()
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = model.viewCurrentlyShowing.title
        basicDetailsView.isHidden = true
        model.setUpModelData()
        listenToChangesInModel()
        setUpTableView()
        setupMenuBarButton()
        addRefreshController()
        addTapOnPhoneNumber()
        setUpProfileImageView()
        
    }
    
    func setUpProfileImageView() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width/2
    }
    
    fileprivate func addTapOnPhoneNumber() {
        let tapOnPhone = UITapGestureRecognizer(target: self, action: #selector(phoneNumberTapped))
        phoneNumber.isUserInteractionEnabled = true
        phoneNumber.addGestureRecognizer(tapOnPhone)
    }
    
    private func addRefreshController() {
        tableView.addSubview(refreshController)
        refreshController.addTarget(self, action: #selector(refreshContents), for: .valueChanged)
    }
    
    override func reloadFetchingData() {
        model.setUpModelData()
    }
    
    @objc func refreshContents() {
        model.setUpModelData()
        refreshController.endRefreshing()
    }
    @objc func phoneNumberTapped() {
        TelephoneCallMaker.makeCall(number: model.phoneNumber)
    }
    
    fileprivate func setUpTableView() {
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        tableView.register(TableViewCellWithBulletPoints.self, forCellReuseIdentifier: bulletPointTableViewIDentifier)
        tableView.register(ProfessionalExperienceHighlights.self, forCellReuseIdentifier: profecssionalExperienceHighLights)
        tableView.register(ProcjectsHandledTableViewCell.self, forCellReuseIdentifier: projectHandledIdentifier)
    }
    
    func reloadView(viewShowingType: ViewShowingTypes) {
        model.viewCurrentlyShowing = viewShowingType
        self.title = viewShowingType.title
        tableView.reloadData()
    }
    
    func setupMenuBarButton() {
        let barButton = UIBarButtonItem(image: UIImage(named: menuButtonImageName), style: .plain, target: self, action: #selector(menuButtonClicked))
        barButton.tintColor = UIColor.darkGray
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func updatePersonalDetails() {
        DispatchQueue.main.async {
            guard let basicDetails = self.model.basicDetails else {
                self.name.text = ""
                self.designation.text = ""
                self.phoneNumber.text = ""
                self.emailAddress.text = ""
                return
            }
            self.name.text = basicDetails.name
            self.designation.text = basicDetails.designation
            self.phoneNumber.text = basicDetails.phone
            self.emailAddress.text = basicDetails.emailAddress
            self.profileImageView.downloadImage(from: basicDetails.profileImage, completionHandler: { (data) in
                
            })
        }
        
    }
    
    @objc func menuButtonClicked() {
        delegate?.toggleMenuBar()
    }
}

//MARK: - Observers

extension CVViewController {
    func listenToChangesInModel() {
        model.updateUI.bind { [unowned self] (value) in
            guard let _ = value else {
                return
            }
            self.updatePersonalDetails()
            self.tableView.reloadData()
        }
        observeForShowingActivityIndicator()
        observeForAlert()
        observerForErrorOccurence()
        observeForViewRefreshing()
        observeForNoInternet()
    }
    
    private func observeForNoInternet() {
        model.showNoInternetMessage.bind { [unowned self] (value) in
            guard let value = value else {
                return
            }
            if value == true {
                DispatchQueue.main.async {
                    self.tableView.isHidden = true
                    self.basicDetailsView.isHidden = true
                    self.showNoInternetMessage()
                }
                
            }
        }
    }
    
    private func observeForShowingActivityIndicator() {
        model.showActivityIndicator.bind { [unowned self] (value) in
            guard let value = value else {
                return
            }
            DispatchQueue.main.async {
                switch value {
                case true:
                    self.view.addActivityIndicator()
                case false:
                    self.view.removeActivityIndicator()
                }
            }
            
        }
    }
    
    private func observeForAlert() {
        model.showAlert.bind { [unowned self] (alertMessage) in
            guard let alertMessage = alertMessage else {
                return
            }
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: alertOkButton, style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    private func observerForErrorOccurence() {
        model.errorOccured.bind { (bool) in
            guard let _ = bool else {
                return
            }
            DispatchQueue.main.async {
                self.basicDetailsView.isHidden = true
                self.tableView.isHidden = true
            }
        }
    }
    
    private func observeForViewRefreshing() {
        model.updateUI.bind { (bool) in
            guard let _ = bool else {
                return
            }
            DispatchQueue.main.async {
                self.removeNoInternetMesaage()
                self.updatePersonalDetails()
                self.basicDetailsView.isHidden = false
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - TablviewDelegates

extension CVViewController: UITableViewDelegate, UITableViewDataSource {
    private func createHeaderView(section: Int) -> UIView {
        let baseView = PersonalInfoView()
        baseView.tag = section + 232
        baseView.backgroundColor = .white
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        baseView.addSubview(label)
        
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": label]))
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[V0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": label]))
        
        
        
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = model.headerTitle[section]
        
        return baseView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return model.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model.viewCurrentlyShowing {
        case .PersonalDetails:
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: bulletPointTableViewIDentifier, for: indexPath) as! TableViewCellWithBulletPoints
                cell.bulletPointValues = model.technicalSkills[indexPath.row]
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: profecssionalExperienceHighLights, for: indexPath) as! ProfessionalExperienceHighlights
                cell.professionalWorkExperience = model.professionalExperience[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: bulletPointTableViewIDentifier, for: indexPath) as! TableViewCellWithBulletPoints
                if model.experienceInFollowingAreas.count > 0 {
                    cell.bulletPointValues = model.experienceInFollowingAreas[indexPath.row]
                }
                return cell
            }
        case .ProjectsHandled:
            let cell = tableView.dequeueReusableCell(withIdentifier: projectHandledIdentifier, for: indexPath) as! ProcjectsHandledTableViewCell
            cell.projectHandled = model.projectsHandledIn(indexPath: indexPath)[indexPath.row]
            return cell
        case .AcademicQualification:
            let cell = tableView.dequeueReusableCell(withIdentifier: academicQualificationTableViewCell, for: indexPath) as! AcademicQualificationTableViewCell
            if let academicDetails = model.academicDetails {
                cell.academicQualification = academicDetails
            }
            return cell
            
        case .References:
            let cell = tableView.dequeueReusableCell(withIdentifier: referenceIdentifier, for: indexPath) as! ReferenceTableViewCell
            cell.reference = model.references[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if model.viewCurrentlyShowing == .PersonalDetails && indexPath.section == 1 {
            rowSelected = indexPath.row
            self.performSegue(withIdentifier: "companyWebsite", sender: self)
            
        }
    }
}

extension CVViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CompanyWebsiteShowingViewController {
            let viewController = segue.destination as? CompanyWebsiteShowingViewController
            viewController?.webSiteUrl = model.professionalExperience[rowSelected].companyUrl
        }
    }
}
