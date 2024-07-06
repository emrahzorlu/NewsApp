//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 4.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let viewModel = NewsViewModel()
        let rootViewController = NewsViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.topItem?.title = "News App"
        navigationController.navigationBar.prefersLargeTitles = true

        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
}
