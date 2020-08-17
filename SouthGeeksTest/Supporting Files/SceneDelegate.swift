//
//  SceneDelegate.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 14/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .clear
        
        let mainViewController = MainCollectionViewController()
        let navigation = SouthGeeksNavigationController(rootViewController: mainViewController)

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

