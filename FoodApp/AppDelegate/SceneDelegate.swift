//
//  SceneDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = createContainerVC()
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
    
    private func createContainerVC() -> ContainerViewController {
        let vc = ContainerViewController()
        let presenter = ContainerPresenter(view: vc, authManager: AuthManager())
        vc.inject(presenter)
        return vc
    }
    
}

