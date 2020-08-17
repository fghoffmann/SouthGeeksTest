//
//  UILabel+Animations.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

extension UILabel {
    
    func startLabelShimmerAnimation(withText text: String, cornerRadius: CGFloat? = nil) {
        if let cr = cornerRadius {
            self.cornerRadius = cr
        } else {
            self.cornerRadius = self.frame.height / 2
        }
        self.backgroundColor = .loadingBackground
        self.text = text
        self.startShimmerAnimation()
    }
    
    func stopLabelShimmerAnimation() {
        self.cornerRadius = 0
        self.backgroundColor = .clear
        self.stopShimmerAnimation()
    }
    
}
