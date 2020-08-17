//
//  Response.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 14/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import Foundation

struct Response<T : Decodable>: Decodable {
    let data : T?
}
