//
//  UIColor+Colors.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

extension UIColor {

    // Dynamic colors
    static var shadow: UIColor { return UIColor(named: "shadowColor") ?? .black }
    static var loadingBackground: UIColor { return UIColor(named: "loadingBackgroundColor") ?? .lightGray }
    static var title: UIColor { return UIColor(named: "titleColor") ?? .black }
    static var text: UIColor { return UIColor(named: "textColor") ?? .black }
    static var textDark: UIColor { return UIColor(named: "textDarkColor") ?? .black }
    static var textLight: UIColor { return UIColor(named: "textLightColor") ?? .black }
    static var background: UIColor { return UIColor(named: "backgroundColor") ?? .black }
    static var gradient1: UIColor { return UIColor(named: "gradien1Color") ?? .black }
    static var gradient2: UIColor { return UIColor(named: "gradien2Color") ?? .black }
    static var gradient3: UIColor { return UIColor(named: "gradien3Color") ?? .black }
    
}
