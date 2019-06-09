//
//  TelephoneCallMaker.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-09.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
import UIKit
struct TelephoneCallMaker {
    static func makeCall(number: String?) {
        guard let phoneNumber = number else {
            return
        }
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
