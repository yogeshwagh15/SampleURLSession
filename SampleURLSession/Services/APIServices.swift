//
//  APIServices.swift
//  SampleURLSession
//
//  Created by Yogesh Wagh on 18/06/18.
//  Copyright © 2018 yogesh. All rights reserved.
//

import Foundation

let QUERY_URL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

class APIServices {
    func getFacts(_ complete: @escaping (_ sucess:Bool, _ facts : FactsData?,_ error : Error?)->()) {
        let query = "\(QUERY_URL)"
        print(query)
        URLSession.shared.dataTask(with: URL(string:query)!, completionHandler: { (data, response, error) in
            if let d = data {
                if let value = String(data: d, encoding: String.Encoding.ascii) {
                    
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Dictionary<String, AnyObject>
                            let facts = FactsData.init(dict: dictionary!)
                            print(facts)
                            complete(true,facts,nil)
                            
                        } catch {
                            
                            NSLog("ERROR \(error.localizedDescription)")
                            complete(false,nil,error)
                        }
                    }
                }
                
            }
            
        }).resume()
        
    }
}
