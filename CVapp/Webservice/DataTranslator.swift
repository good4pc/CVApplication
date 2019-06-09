//
//  DataTranslator.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation

class DataTranslator {
    static func decode<T: Decodable>(with data: Data , of type: ContentType ) throws -> T {
        let decoder = JSONDecoder()
        do {
            switch type {
            case .cvDetails:
                return try decoder.decode(CVDetails.self, from: data) as! T
            }
        }
        catch let error {
            throw error
        }
    }
}
