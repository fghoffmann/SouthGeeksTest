//
//  UIImageView+Utilities.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    
    func setImage(_ urlString: String?,
                  placeholder: UIImage? = nil,
                  forHeight height: CGFloat?,
                  completion:((UIImage?) -> Void)? = nil) {
        
        self.layer.masksToBounds = true
        
        guard var urlString = urlString, urlString != "" else {
            self.image = placeholder
            completion?(nil)
            return
        }
        
        if let height = height {
            urlString = urlString.imageUrl(forHeight: height)
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        self.startShimmerAnimation()
        let options = ImageLoadingOptions(placeholder: placeholder,
                                          transition: nil,
                                          failureImage: nil,
                                          failureImageTransition: nil,
                                          contentModes: nil)
        Nuke.loadImage(with: url,options: options, into: self) { (result) in
            self.stopShimmerAnimation()
            switch result {
            case .success(let imageResponse):
                completion?(imageResponse.image)
            case .failure(_):
                completion?(nil)
            }
        }
    }
    
}

