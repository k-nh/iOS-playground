//
//  SceneDelegate.swift
//  InstagramClone
//
//  Created by 김나희 on 2021/12/08.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = TapbarController()
        window?.tintColor = .label
        window?.makeKeyAndVisible()
    }

}

