//
//  Media.swift
//  NYTimesMostPopular
//
//  Created by faisal khalid on 7/14/19.
//  Copyright © 2019 faisalkhalid. All rights reserved.
//

import Foundation

struct Media {
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let approved_for_syndication:Int
    var mediaMetadata:[MediaMetaData] = []
    
    init(json:[String:Any]) {
        
        self.type = json["type"] as? String ?? ""
        self.subtype = json["subtype"] as? String ?? ""
        self.caption = json["caption"] as? String ?? ""
        self.copyright = json["copyright"] as? String ?? ""
        self.approved_for_syndication = json["approved_for_syndication"] as? Int ?? 0
        
        if let mediaMetaDataList = json["media-metadata"] as? [[String:Any]] {
            for mediaMetaData in mediaMetaDataList {
                mediaMetadata.append(MediaMetaData.init(json: mediaMetaData))
            }
        }
    }
    
}
