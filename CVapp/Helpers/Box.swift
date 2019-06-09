//
//  Box.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-07.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
//Box serves as a listener and notify the changes
class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
