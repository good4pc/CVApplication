//
//  PersonalInfoView.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-07.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
@IBDesignable
class PersonalInfoView: UIView {
    
    override func draw(_ rect: CGRect) {
        let bezier = UIBezierPath()
        bezier.move(to: CGPoint(x: 0, y: rect.size.height))
        bezier.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        underLineColorOFCustomView.setStroke()
        bezier.lineWidth = 0.4
        bezier.stroke()
    }
}
