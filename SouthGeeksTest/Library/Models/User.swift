//
//  User.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 14/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    let badges: Badges?
    let id: Int?
    let isEmployee: Bool?
    let location: String?
    let name: String?
    let profileImage: String?
    let reputation: Int?
    
    private enum CodingKeys: String, CodingKey {
        case badges = "badge_counts"
        case id
        case isEmployee = "is_employee"
        case location
        case name = "display_name"
        case profileImage = "profile_image"
        case reputation
    }
    
}

struct Users: Decodable {
    let items: [User]
}
