//
//  SouthGeeksNavigationController.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 14/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class SouthGeeksNavigationController: UINavigationController {

    // MARK: - Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods
    func setupView() {
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        navigationBar.prefersLargeTitles = false
        
        navigationBar.largeTitleTextAttributes = ([NSAttributedString.Key.foregroundColor: UIColor.title,
                                                       NSAttributedString.Key.font: UIFont(name: "Galvji-Bold", size: 30)!])
        
        navigationBar.tintColor = .title
        navigationItem.leftBarButtonItem?.tintColor = .title
        navigationItem.rightBarButtonItem?.tintColor = .title
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.title]
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.title]
    }

}
