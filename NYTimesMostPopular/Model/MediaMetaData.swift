//
//  MediaMetaData.swift
//  NYTimesMostPopular
//
//  Created by faisal khalid on 7/14/19.
//  Copyright © 2019 faisalkhalid. All rights reserved.
//

import Foundation

struct MediaMetaData {
    
    let url: String
    let format: String
    let height: Int
    let width: Int
    
    init(json:[String:Any]) {
        
        self.url = json["url"] as? String ?? ""
        self.format = json["format"] as? String ?? ""
        self.height = json["height"] as? Int ?? 0
        self.width = json["width"] as? Int ?? 0
        
    }
}
