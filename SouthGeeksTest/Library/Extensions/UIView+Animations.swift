//
//  UIView+Animations.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

extension UIView {
    
    public func animateShowPopingUp(duration: Double = 0.4, scaleIn: CGFloat = 0.1, scaleOut: CGFloat = 1.05, alphaIn: CGFloat = 0, alphaOut: CGFloat = 1, _ completion:(() -> Void)? = nil){
        DispatchQueue.main.async {
            self.isHidden = false
            self.alpha = alphaIn
            self.transform = CGAffineTransform(scaleX: scaleIn, y: scaleIn)
            
            UIView.animate(withDuration: duration*0.7, animations: {
                self.transform = CGAffineTransform(scaleX: scaleOut, y: scaleOut)
                self.alpha = alphaOut
            }, completion: { (didComplete) in
                UIView.animate(withDuration: duration*0.3, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { (didComplete) in
                    completion?()
                })
            })
        }
    }
    
    public func animationCornerRadius(_ radius: CGFloat, duration: Double) {
        let animation = Init(CABasicAnimation(keyPath: "cornerRadius")) {
            $0.duration = duration
            $0.toValue = radius
            $0.fillMode = CAMediaTimingFillMode.forwards
            $0.isRemovedOnCompletion = false
        }

        layer.add(animation, forKey: nil)
    }
    
    public func animateFadeIn(duration: Double = 0.3, alphaIn: CGFloat = 0, alphaOut: CGFloat = 1, _ completion:(() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = false
            self?.alpha = alphaIn
            
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.alpha = alphaOut
            }, completion: { (didComplete) in
                completion?()
            })
        }
    }
    
}
