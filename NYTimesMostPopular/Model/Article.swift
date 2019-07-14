//
//  Article.swift
//  NYTimesMostPopular
//
//  Created by faisal khalid on 7/14/19.
//  Copyright © 2019 faisalkhalid. All rights reserved.
//

import Foundation

struct Article {
    
    let url:String
    let adx_keywords:String
    let column:String
    let section:String
    let byline:String
    let type:String
    let title:String
    let abstract:String
    let published_date:String
    let source:String
    let views:Int
    var media: [Media] = []
    
    init(json:[String:Any]) {
        self.url = json["url"] as? String ?? ""
        self.adx_keywords = json["adx_keywords"] as? String ?? ""
        self.column = json["column"] as? String ?? ""
        self.byline = json["byline"] as? String ?? ""
        self.section = json["section"] as? String ?? ""
        self.abstract = json["abstract"] as? String ?? ""
        self.published_date = json["published_date"] as? String ?? ""
        self.source = json["source"] as? String ?? ""
        self.type = json["type"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        self.views = json["views"] as? Int ?? 0
        
        if let mediaList = json["media"] as? [[String:Any]] {
            for media in mediaList {
                self.media.append(Media.init(json: media))
            }
        }
    }
}
