//
//  ProcjectsHandledTableViewCell.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class ProcjectsHandledTableViewCell: UITableViewCell {
    let projectTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let projectDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let projectLanguage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = underLineColorOFCustomView
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var projectHandled: ProjectsHandled! {
        didSet {
            projectTitle.text = projectHandled.projectTitle
            projectDescription.text = projectHandled.description
            projectLanguage.text = programmingLanguagePrefix + projectHandled.programmingLanguage
            addRolesToTheView(roles: projectHandled.rolesAndResponsibilities)
        }
    }
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let rolesAndResponsibilitiesTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = rolesAndResponsibilitiesText
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    func addRolesToTheView(roles: [String]) {
        var rolesAndResponsibilities: String = ""
        for role in roles {
            rolesAndResponsibilities.append("-")
            rolesAndResponsibilities.append(role)
            rolesAndResponsibilities.append("\n")
        }
        roleLabel.text = rolesAndResponsibilities
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubview(projectTitle)
        self.addSubview(projectDescription)
        self.addSubview(projectLanguage)
        self.addSubview(roleLabel)
        self.addSubview(rolesAndResponsibilitiesTitle)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[projectTitle]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["projectTitle": projectTitle]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[projectDescription]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["projectDescription": projectDescription]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[projectLanguage]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["projectLanguage": projectLanguage]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[roleLabel]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["roleLabel": roleLabel]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[rolesAndResponsibilitiesTitle]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["rolesAndResponsibilitiesTitle": rolesAndResponsibilitiesTitle]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[projectTitle][projectDescription][projectLanguage][rolesAndResponsibilitiesTitle][roleLabel]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["projectTitle": projectTitle,"projectDescription": projectDescription,"projectLanguage": projectLanguage,"roleLabel":roleLabel,"rolesAndResponsibilitiesTitle":rolesAndResponsibilitiesTitle]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
