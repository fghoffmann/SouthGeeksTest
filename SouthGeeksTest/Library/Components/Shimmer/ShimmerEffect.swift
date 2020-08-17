//
//  ShimmerEffect.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

// MARK: - ShimmerAnimation Key Path
public enum ShimmerAnimationKeyPath: String {
    
    case shimmerViewLocations = "locations"
    
}

public protocol ShimmerEffect {
    
    // MARK: - Variables
    var animationDuration: TimeInterval { get set }
    var animationDelay: TimeInterval {get set }
    var shimmerGradientTint: UIColor { get set }
    var shimmerGradientHighlight: UIColor { get set }
    var gradientHighlightRatio: Double { get set }
    var gradientLayer: CAGradientLayer { get }
    
}

extension ShimmerEffect {
    
    // MARK: - Methods
    public func addShimmerAnimation() {
        
        let startLocations = [NSNumber(value: -gradientHighlightRatio), NSNumber(value: -gradientHighlightRatio/2), 0.0]
        let endLocations = [1, NSNumber(value: 1+(gradientHighlightRatio/2)), NSNumber(value: 1+gradientHighlightRatio)]
        let gradientColors = [shimmerGradientTint.cgColor, shimmerGradientHighlight.cgColor, shimmerGradientTint.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: -gradientHighlightRatio, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1+gradientHighlightRatio, y: 0.5)
        gradientLayer.locations = startLocations
        gradientLayer.colors = gradientColors
        
        let shimmerAnimation = CABasicAnimation(keyPath: ShimmerAnimationKeyPath.shimmerViewLocations.rawValue)
        shimmerAnimation.fromValue = startLocations
        shimmerAnimation.toValue = endLocations
        shimmerAnimation.duration = animationDuration
        shimmerAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + animationDelay
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [shimmerAnimation]
        
        gradientLayer.removeAnimation(forKey: ShimmerAnimationKeyPath.shimmerViewLocations.rawValue)
        gradientLayer.add(animationGroup, forKey: ShimmerAnimationKeyPath.shimmerViewLocations.rawValue)
        
    }
    
    public func removeShimmerAnimation() {
        
        gradientLayer.removeAnimation(forKey: ShimmerAnimationKeyPath.shimmerViewLocations.rawValue)
        
    }
    
}


