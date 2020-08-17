//
//  UIView+Utilities.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

extension UIView {
    
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set (cornerRadius) {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    func takeSnapshot(_ frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: frame.origin.x * -1, y: frame.origin.y * -1)

        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return nil
        }

        layer.render(in: currentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
    
    func subviewsForEach(_ f: (UIView) -> Void) {
        forEachView(self, f: f)
    }

    fileprivate func forEachView(_ view: UIView, f: (UIView) -> Void) {
        view.subviews.forEach {
            f($0)

            if $0.subviews.count > 0 {
                forEachView($0, f: f)
            }
        }
    }
    
}
