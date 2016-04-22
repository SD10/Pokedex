//
//  Network Operation.swift
//  PokedexXX
//
//  Created by Steven on 4/21/16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation
import Alamofire

class NetworkOperation {
    
    private var _queryURL: NSURL
    
    var queryURL: NSURL {
        return _queryURL
    }
    
    init(url: NSURL) {
        self._queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        Alamofire.request(.GET, queryURL).responseJSON { (response: Response<AnyObject, NSError>) in
            if let error = response.result.error {
                print(error.debugDescription)
            } else {
                if let results = response.result.value as? [String: AnyObject] {
                    completion(results)
                    print(results)
                }
            }
        }
    }
}