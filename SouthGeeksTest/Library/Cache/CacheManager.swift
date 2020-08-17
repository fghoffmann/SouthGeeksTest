//
//  CacheManager.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 16/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

public class CacheManager: NSObject {
    
    /*
     *   Sets the cache size for the application
     *   @param memorySize: Size of cache in memory
     *   @param diskSize: Size of cache in disk
     */
    static func configureCache(withMemorySize memorySize: Int = 30, diskSize: Int = 300){
        let cacheSizeMemory = memorySize*1024*1024
        let cacheSizeDisk = diskSize*1024*1024
        let cache = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: nil)
        URLCache.shared = cache
    }
    
    /*
     *   Clears cache
     */
    static func clearCache(){
        URLCache.shared.removeAllCachedResponses()
    }
    
    /*
     *   Get cached object for urlRequest
     *   @param urlRequest: Request for cached data
     */
    static func getCachedObject(_ urlRequest: URLRequest) -> Data?{
        if let cachedObject = URLCache.shared.cachedResponse(for: urlRequest) {
            return cachedObject.data
        }
        return nil
    }
    
    /*
     *   Set object to cache
     *   @param data: data to cache
     */
    static func cacheObject(_ urlRequest: URLRequest?, response: URLResponse?, data: Data?){
        guard let urlRequest = urlRequest else{
            return
        }
        
        guard let response = response else{
            return
        }
        
        guard let data = data else{
            return
        }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
    
    // MARK: - Instance methods
    
    public static func cache(_ data: Data, forKey key: String) {
        CoreCache(key: key, value: data).save()
    }
    
    public static func data(forKey key: String) -> Data? {
        return CoreCache.data(forKey: key)
    }
    
    public static func object(forKey key: String) -> CoreCache? {
        return CoreCache.object(forKey: key)
    }
    
}

// MARK: - Requester methods

extension CacheManager {
    
    public static func verifyForCache(urlRequest: URL, method: RequestMethod, body: String?) -> Data? {
        let url = buildURLCacheKey(urlRequest, method: method, bodyData: body)
        if let data = CacheManager.data(forKey: url) {
            return data
        }
        return nil
    }
    
    public static func saveCache(urlRequest: URL, method: RequestMethod, body: String?, data: Data?) {
        if let data = data {
            let url = buildURLCacheKey(urlRequest, method: method, bodyData: body)
            CacheManager.cache(data, forKey: url)
        }
    }
    
    public static func buildBody(_ jsonBody: [String: AnyObject]?) -> String {
        if let jsonBody = jsonBody {
            for (key, value) in jsonBody {
                if key == "query", let value = value as? String {
                    return value
                }
            }
        }
        return ""
    }
    
    // MARK: - Helpers
    
    private static func buildURLCacheKey(_ url: URL?,
                                         method: RequestMethod?,
                                         bodyData: String?) -> String {
        
        if let bodyData = bodyData, let urlString = url?.absoluteString, let method = method {
            let hashValue = bodyData + urlString + method.rawValue
            return urlString + "?keyHash=\(hashValue)"
        } else if let urlString = url?.absoluteString, let method = method {
            let hashValue = urlString + method.rawValue
            return urlString + "?keyHash=\(hashValue)"
        }
        return url?.absoluteString ?? ""
    }
    
}
