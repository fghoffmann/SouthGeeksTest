//
//  Cache.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 16/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class Cache {
        
    func dataFromCache(_ url: String, method: RequestMethod = .GET, bodyDict: [String: AnyObject]? = nil) -> Data? {
        if let body = bodyDict, let data = CacheManager.verifyForCache(urlRequest: URL(string: url)!, method: method, body: CacheManager.buildBody(body)) {
            return data
        } else if let data = CacheManager.verifyForCache(urlRequest: URL(string: url)!, method: method, body: nil) {
            return data
        }
        return nil
    }
    
    func saveToCache(_ url: String, method: RequestMethod = .GET, bodyDict: [String: AnyObject]? = nil, data: Data?) {
        if let body = bodyDict {
            CacheManager.saveCache(urlRequest: URL(string: url)!, method: method, body: CacheManager.buildBody(body), data: data)
        } else {
            CacheManager.saveCache(urlRequest: URL(string: url)!, method: method, body: nil, data: data)
        }
    }
    
//    func process(data: Data?, error: ErrorData?, response: @escaping (ErrorData?) -> Void) {
//        if let jsonObject = data {
//            let questError = QuestErrorMP.parseQuestErrorFrom(jsonObject)
//            if questError.count > 0 {
//                response(ErrorData(.generic, "An error occurred during your request."))
//            } else {
//                response(nil)
//            }
//        } else {
//            if let error = error {
//                response(error)
//                return
//            }
//            response(ErrorData(.unknown, "response Data could not be parsed"))
//        }
//    }

}