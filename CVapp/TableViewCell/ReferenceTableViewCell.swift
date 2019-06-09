//
//  ReferenceTableViewCell.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-09.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class ReferenceTableViewCell: UITableViewCell {

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var reference: Reference! {
        didSet {
            if let imageDownloaded = reference.profileImageDownloaded  {
                DispatchQueue.main.async {
                    self.profileImage.image = UIImage(data: imageDownloaded)
                }
            } else {
                profileImage.downloadImage(from: reference.profilePic) { (data) in
                    DispatchQueue.main.async {
                        self.reference.updateImage(with: data)
                    }
                }
            }
            name.text = reference.name
            companyName.text = reference.company
            designation.text = reference.designation
            phone.text = reference.phone
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
        name.font = UIFont.boldSystemFont(ofSize: 17)
        companyName.font = UIFont.systemFont(ofSize: 15)
        designation.font = UIFont.systemFont(ofSize: 15)
        phone.font = UIFont.systemFont(ofSize: 15)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startCall))
        phone.isUserInteractionEnabled = true
        phone.addGestureRecognizer(tapGesture)
    }
    
    @objc func startCall() {
        TelephoneCallMaker.makeCall(number: reference.phone.formatPhoneNumber())
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
