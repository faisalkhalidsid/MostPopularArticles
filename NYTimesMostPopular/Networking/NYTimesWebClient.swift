//
//  NYTimesWebClient.swift
//  NYTimesMostPopular
//
//  Created by faisal khalid on 7/14/19.
//  Copyright © 2019 faisalkhalid. All rights reserved.
//

import UIKit

class NYTimesWebClient: NSObject {
    
    
    private var baseURL:String = "http://api.nytimes.com/svc/mostpopular/v2"
    private var key:String = "x9iTFD7pmEiFY8L6Z8KEESir6LfIcIg2"
    var session = URLSession.shared
    
    func getMostPopularAPIURL(for section:String,noOfDays days:Int)->String {
        return "\(baseURL)/mostviewed/\(section)/\(days).json?api-key=\(key)"
    }
    
    func getMostPopularArticles(section:String,noOfDays:Int,completionHandler:@escaping (_ error:Error?,_ article:[Article]?)->Void){
        
        var request = NSMutableURLRequest(url: URL(string: getMostPopularAPIURL(for: section, noOfDays: noOfDays))!, cachePolicy:
            NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
                                          timeoutInterval: 30.0)
        
        
        
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            
            if let error = error {
                completionHandler(error,nil)
            }
            
            
            if let data = data {
                
                do {
                    //let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                    var json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    
                    
                    if let numberOfResults = json["num_results"] as? Int {
                        print(numberOfResults)
                    }
                    
                    if let results = json["results"] as? [[String:Any]] {
                        
                        
                        var articles:[Article] = []
                        
                        
                        for result in results {
                            
                            articles.append(Article.init(json: result))
                            
                        }
                        
                        
                        completionHandler(nil,articles)
                    }
                        
                    else {
                        completionHandler(error,nil)
                    }
                    
                }
                catch {
                    
                    
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: error.localizedDescription])
                    completionHandler(error,nil)
                    
                    
                    return
                }
                
            }
            
        })
        
        task.resume()
        
        
        
        
    }
    
    
  
    
   static func loadThumbnailFromURL(urlString: String)->UIImage? {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
                
            }
        }
        return nil
    }
    
}

enum MostPopularSectionType:String {
    case allSections = "all-sections"
    
}



