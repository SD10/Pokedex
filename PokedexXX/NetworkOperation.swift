//
//  Network Operation.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkOperation {
    
    private var queryURL: NSURL
    
    init(url: NSURL) {
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        Alamofire.request(.GET, queryURL).responseJSON { (response: Response<AnyObject, NSError>) in
            if let error = response.result.error {
                print(error.debugDescription)
            } else {
                if let results = response.result.value as? [String: AnyObject] {
                    completion(results)
                }
            }
        }
    }
}