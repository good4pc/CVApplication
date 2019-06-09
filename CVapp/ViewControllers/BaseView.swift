//
//  BaseView.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIViewController {
    lazy var noInternetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.tag = 888
        label.text = noInternetText
        return label
    }()
    
    
    lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tag = 777
        button.setImage(UIImage(named: "reload"), for: .normal)
        return button
    }()
    
    
    
    func showNoInternetMessage() {
        self.view.addSubview(noInternetLabel)
        self.view.addSubview(reloadButton)
        reloadButton.addTarget(self, action: #selector(reloadFetchingData), for: .touchUpInside)
        noInternetLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        noInternetLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        reloadButton.topAnchor.constraint(equalTo: noInternetLabel.bottomAnchor, constant: 5).isActive = true
        reloadButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        reloadButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func reloadFetchingData() {
        
    }
    
    func removeNoInternetMesaage() {
        if let label = self.view.viewWithTag(888) {
            label.removeFromSuperview()
        }
        if let button = self.view.viewWithTag(777) {
            button.removeFromSuperview()
        }
    }
}
