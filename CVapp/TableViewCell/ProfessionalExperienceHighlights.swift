//
//  ProfessionalExperienceHighlights.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-07.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class ProfessionalExperienceHighlights: UITableViewCell {
    let companyLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let bulletValues: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let periodOfEmplyment: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    fileprivate func downloadImage() {
        if let imageDownloaded =  professionalWorkExperience.companyImageDownloaded {
            DispatchQueue.main.async {
                self.companyLogo.image = UIImage(data: imageDownloaded)
            }
        } else {
            companyLogo.downloadImage(from: professionalWorkExperience.companyLogoURl) { (dataDownloaded) in
                DispatchQueue.main.async {
                    self.professionalWorkExperience.updateImage(with: dataDownloaded)
                }
            }
        }
    }
    
    var professionalWorkExperience: ProfessionalExperience! {
        didSet {
            
            self.bulletValues.text = self.professionalWorkExperience.companyName
            self.periodOfEmplyment.text = "\(self.professionalWorkExperience.startDate) - \(self.professionalWorkExperience.endDate)"
            downloadImage()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubview(companyLogo)
        self.addSubview(bulletValues)
        self.addSubview(periodOfEmplyment)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[bulletPoint(30)]-5-[bulletValues]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["bulletPoint":companyLogo,"bulletValues": bulletValues]))
        companyLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        companyLogo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bulletValues.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        periodOfEmplyment.topAnchor.constraint(equalTo: bulletValues.bottomAnchor, constant: 5).isActive = true
        periodOfEmplyment.heightAnchor.constraint(equalToConstant: 17).isActive = true
        periodOfEmplyment.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -5).isActive = true
        periodOfEmplyment.leftAnchor.constraint(equalTo: bulletValues.leftAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
