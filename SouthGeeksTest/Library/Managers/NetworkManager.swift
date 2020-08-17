//
//  NetworkManager.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 14/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class NetworkManager {
    
    // MARK: - Variables
    static let shared: NetworkManager = NetworkManager()
    lazy var service: NetworkService = NetworkService()
    
    // MARK: - Lifecycle
    fileprivate init() { }
    
}
