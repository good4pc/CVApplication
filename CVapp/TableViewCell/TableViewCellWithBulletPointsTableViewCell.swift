//
//  TableViewCellWithBulletPointsTableViewCell.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-07.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class TableViewCellWithBulletPoints: UITableViewCell {
    let bulletPount: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 3.5
        view.layer.masksToBounds = true
        return view
    }()
    
    let bulletValues: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var bulletPointValues: String! {
        didSet {
            bulletValues.text = bulletPointValues
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubview(bulletPount)
        self.addSubview(bulletValues)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[bulletPoint(7)]-5-[bulletValues]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["bulletPoint":bulletPount,"bulletValues": bulletValues]))
        bulletPount.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        bulletPount.heightAnchor.constraint(equalToConstant: 7.5).isActive = true
        bulletValues.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        bulletValues.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
