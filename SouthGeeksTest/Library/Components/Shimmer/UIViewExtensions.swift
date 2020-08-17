//
//  UIView+Animation.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

public struct LoadingConstants {
    
    // MARK: - Variables
    public static var defaultAnimationJson: String?
    public static var defaultAnimationBundle: Bundle?
    public static var defaultAnimationSize: CGSize?
    
    public static var defaultShimmerDelay: Double = 0.2
    public static var defaultShimmerTint: UIColor = UIColor.init(red: 35/255.0, green: 39/255.0, blue: 47/255.0, alpha: 0.2)
    public static var defaultShimmerHighlight: UIColor = UIColor.init(red: 40/255.0, green: 45/255.0, blue: 53/255.0, alpha: 0.8)
    public static var defaultShimmerHighlightRatio: Double = 0.8
    public static var defaultShimmerWidthRatio: CGFloat = 1
    public static var defaultShimmerHeightRatio: CGFloat = 1
    public static var defaultShimmerAlignment: NSTextAlignment = .center
    
}


extension UIView {

    public func startShimmerAnimation(delay: Double = LoadingConstants.defaultShimmerDelay,
                                      tint: UIColor = LoadingConstants.defaultShimmerTint,
                                      highlight: UIColor = LoadingConstants.defaultShimmerHighlight,
                                      highlightRatio: Double = LoadingConstants.defaultShimmerHighlightRatio,
                                      widthRatio: CGFloat = LoadingConstants.defaultShimmerWidthRatio,
                                      heightRatio: CGFloat = LoadingConstants.defaultShimmerHeightRatio,
                                      alignment: NSTextAlignment = LoadingConstants.defaultShimmerAlignment) {
        stopShimmerAnimation()
        
        let shimmerView = ShimmerView()
        
        shimmerView.backgroundColor = .clear
        shimmerView.shimmerGradientTint = tint
        shimmerView.shimmerGradientHighlight = highlight
        shimmerView.animationDelay = delay
        shimmerView.gradientHighlightRatio = highlightRatio
        shimmerView.addShimmerAnimation()
        
        self.addSubview(shimmerView)
        
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        
        switch alignment {
        case .left:
            self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
            break
        case .right:
            self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
            break
        default:
            self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        }
        
        self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: widthRatio, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: heightRatio, constant: 0))
    }
    
    public func stopShimmerAnimation() {
        for subview in subviews {
            if let subview = subview as? ShimmerView {
                subview.removeShimmerAnimation()
                subview.removeFromSuperview()
            }
        }
    }
    
}
