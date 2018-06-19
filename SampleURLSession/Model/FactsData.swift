//
//  FactsData.swift
//  SampleURLSession
//
//  Created by Yogesh Wagh on 18/06/18.
//  Copyright © 2018 yogesh. All rights reserved.
//

import Foundation

struct Fact
{
    var title : String
    var description : String
    var imageHref : String
    
    init(dict : Dictionary<String,AnyObject>) {
        self.title = dict["title"] as? String ?? ""
        self.imageHref = dict["imageHref"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
    }
}


struct FactsData {
    var title : String
    var rows : [Fact]
    
    init(dict : Dictionary<String,AnyObject>) {
        self.title = dict["title"] as? String ?? "";
        let arrayOfRows = dict["rows"] as? [[String:AnyObject]] ?? []
        self.rows = arrayOfRows.map(Fact.init)
        
    }
}
