//
//  Configuration.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

internal func Init<Type>(_ value: Type, block: (_ object: Type) -> Void) -> Type {
    block(value)
    return value
}
