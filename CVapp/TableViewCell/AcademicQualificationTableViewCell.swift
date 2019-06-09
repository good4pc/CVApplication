//
//  AcademicQualificationTableViewCell.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class AcademicQualificationTableViewCell: UITableViewCell {

    @IBOutlet weak var university: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    @IBOutlet weak var degreeType: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var year: UILabel!
    
    var academicQualification: AcademicQualification! {
        didSet {
            university.text = academicQualification.university
            degreeType.text = academicQualification.degreeType
            department.text = "Branch : " + academicQualification.department
            year.text = academicQualification.year
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        
    }

}
