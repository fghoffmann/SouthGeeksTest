//
//  UsersService.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 14/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import Foundation

struct UsersService {
    
    // MARK: - Variables
    private var requester: NetworkService
    private let usersUrl: String = "\(StackExchangeAPI.host)\(StackExchangeAPI.usersPath)/users?site=stackoverflow"
    
    // MARK: - Lifecycle
    init(requester: NetworkService = NetworkService()) {
        self.requester = requester
    }
    
    // MARK: - Methods
    func fetchUsers(force: Bool = false, completion: @escaping (_ users: Users?, _ error: Error?) -> Void) {
        requester.fetchData(url: usersUrl, type: Users.self, force: force) { (response, error) in
            if let users = response {
                completion(users, error)
            }else{
                completion(nil, error)
            }
        }
    }
    
}
