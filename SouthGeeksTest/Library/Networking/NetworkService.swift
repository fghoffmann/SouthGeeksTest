//
//  SouthGeeksTestTests.swift
//  SouthGeeksTestTests
//
//  Created by Fabio Gustavo Hoffmann on 14/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T : Decodable>(url:String, type:T.Type, force:Bool, completion: @escaping (_ response: T?,_ error: Error?) -> Void)
}

class NetworkService: Cache, NetworkServiceProtocol  {
    func fetchData<T : Decodable>(url urlString:String,
                                  type:T.Type,
                                  force:Bool = false,
                                  completion: @escaping (_ response: T?,_ error: Error?) -> Void){
        
        var haveCache = false
        let decoder = JSONDecoder()
        
        if !force, let data = dataFromCache(urlString) {
            haveCache = true
            
            if let json = try? decoder.decode(type, from: data) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    completion(json, nil)
                }
            }else{
                completion(nil, NSError(domain: "some error", code: -1, userInfo: nil))
            }
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                guard err == nil && data != nil else {
                    completion(nil, err)
                    return
                }
                
                if let data = data {
                    self.saveToCache(urlString, data: data)
                    if haveCache { return }
                    if let json = try? decoder.decode(type, from: data) {
                        completion(json, nil)
                    }else{
                        completion(nil, NSError(domain: "some error", code: -1, userInfo: nil))
                    }
                }
            }.resume()
        }else{
            completion(nil, NSError(domain: "URL malformed", code: -1, userInfo: nil))
        }
    }
}
