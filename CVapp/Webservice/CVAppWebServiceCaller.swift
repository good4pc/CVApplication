//
//  CVAppWebServiceCaller.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation

class CVAppWebServiceCaller {
    static func getCVDetails(completionHandler:@escaping (_ buildingData: CVDetails?, _ error: String?) -> Void) {
        
        InternetChecker.check { (internet) in
            if internet == true {
                do {
                    try WebService.fetchData(from: WebserviceUrl.cvDetails.url) {(data, error) in
                        if let data = data {
                            do {
                                let decodedData: CVDetails = try DataTranslator.decode(with: data, of: ContentType.cvDetails)
                                completionHandler(decodedData,nil)
                            }
                            catch {
                                completionHandler(nil,WebserviceError.decodingError.description)
                            }
                            
                        } else {
                            completionHandler(nil,WebserviceError.dataIsNil.description)
                        }
                    }
                }
                catch  let error as WebserviceError {
                    completionHandler(nil, error.description)
                }
                catch {
                    completionHandler(nil, WebserviceError.somethingGoneWrong.description)
                }
            } else {
                completionHandler(nil, WebserviceError.noInternet.description)
            }
        }
        
        
    }
}
