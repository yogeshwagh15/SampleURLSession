//
//  FactParser.swift
//  SampleURLSession
//
//  Created by Yogesh Wagh on 18/06/18.
//  Copyright © 2018 yogesh. All rights reserved.
//

import Foundation

class FactParser {
    
    //get facts data from remote server
    func getFactsData(complete : @escaping (FactsData)->(), error : @escaping (Error)->()) {
        let getfactAPI = APIServices()
        
        getfactAPI.getFacts { (isComplete, facts, errors) in
            if let err = errors
            {
                error(err)
            }
            if let fact = facts
            {
                complete(fact)
            }
        }
    }
}
