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
    static var greenButtonText: UIColor { return UIColor(named: "greenButtonTextColor") ?? .black}
    static var redText: UIColor { return UIColor(named: "redTextColor") ?? .black}
    static var userProfileBorder: UIColor { return UIColor(named: "userProfileBorderColor") ?? .black}
    static var userCounterBorder: UIColor { return UIColor(named: "userCounterBorderColor") ?? .black}

    static var background: UIColor { return UIColor(named: "backgroundColor") ?? .black }
    static var backgroundLight: UIColor { return UIColor(named: "backgroundLightColor") ?? .black }
    static var backgroundVeryLight: UIColor { return UIColor(named: "backgroundVeryLightColor") ?? .black }
    static var backgroundMedium: UIColor { return UIColor(named: "backgroundMediumColor") ?? .black }
    static var planYellow: UIColor { return UIColor(named: "planYellowColor") ?? .black }

    static var gradient1: UIColor { return UIColor(named: "gradient1Color") ?? .black }
    static var gradient2: UIColor { return UIColor(named: "gradient2Color") ?? .black }
    static var gradient3: UIColor { return UIColor(named: "gradient3Color") ?? .black }
    static var gradient4: UIColor { return UIColor(named: "gradient4Color") ?? .black }
    static var gradient5: UIColor { return UIColor(named: "gradient5Color") ?? .black }

    static var buttonGradient1: UIColor { return UIColor(named: "buttonGradient1Color") ?? .black }
    static var buttonGradient2: UIColor { return UIColor(named: "buttonGradient2Color") ?? .black }
    static var buttonGradient3: UIColor { return UIColor(named: "buttonGradient3Color") ?? .black }
    
}
