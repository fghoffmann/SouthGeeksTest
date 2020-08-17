//
//  String+Utilities.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

extension String {
    
    public func imageUrl(forHeight height: CGFloat, imageDownloadQuality: Int = 50) -> String {
        return "\(self)?transform=h_\(Int(height*UIScreen.main.scale)),q=\(imageDownloadQuality)"
    }
    
    var utfData: Data {
        return Data(utf8)
    }

    var attributedHtmlString: NSAttributedString? {

        do {
            return try NSAttributedString(data: utfData,
            options: [
                      .documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue
                     ], documentAttributes: nil)
        } catch {
            print("Error:", error)
            return nil
        }
    }
    
}
