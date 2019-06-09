//
//  InternetChecker.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
import Network

class InternetChecker {
    static func check(completionHandler:@escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
              completionHandler(true)
            }
            else {
                completionHandler(false)
            }
            monitor.cancel()
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
