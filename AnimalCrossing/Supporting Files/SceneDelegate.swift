//
//  SceneDelegate.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 06.06.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let coreDataManager = CoreDataManager()
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
                    let window = UIWindow(windowScene: scene)
        let view = LoginAssebmly().build()
                    window.rootViewController = UINavigationController(rootViewController: view)
                    self.window = window
                    window.makeKeyAndVisible()
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
        self.coreDataManager.saveContext()
    }


}

