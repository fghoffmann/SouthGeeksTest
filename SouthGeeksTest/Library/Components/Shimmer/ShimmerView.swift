//
//  ShimmerView.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class ShimmerView: UIView, ShimmerEffect {
    
    override public static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    open var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    open var animationDuration: TimeInterval = 3
    open var animationDelay: TimeInterval = 1.5
    open var gradientHighlightRatio: Double = 0.3
    
    @IBInspectable open var shimmerGradientTint: UIColor = .black
    @IBInspectable open var shimmerGradientHighlight: UIColor = .white
    
}
