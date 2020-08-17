//
//  CoreCache.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 16/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import RealmSwift
import Realm

public class CoreCache: Object {
    
    @objc dynamic public var key: String = ""
    @objc dynamic public var value: Data? = nil
    
    // MARK: - Realm
    override public static func primaryKey() -> String? {
        return "key"
    }
    
    public init(key: String, value: Data) {
        super.init()
        
        self.key = key
        self.value = value
    }
    
    public required init() {
        super.init()
    }
    
    public func save() {
        let realm = try? Realm()
        _ = try? realm?.write {
            realm?.create(CoreCache.self, value: self, update: .modified)
        }
    }
    
    public static func object(forKey key: String) -> CoreCache? {
        let realm = try? Realm()
        return realm?.object(ofType: CoreCache.self, forPrimaryKey: key)
    }
    
    public static func data(forKey key: String) -> Data? {
        return object(forKey: key)?.value
    }
}
