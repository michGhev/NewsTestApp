//
//  SceneDelegate.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.appCoordinator = AppCoordinator(window: window!)
        self.configureFlow(options: connectionOptions)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
    }
    
    
    
    //MARK: - Helpers -
    
    private func configureFlow(options connectionOptions: UIScene.ConnectionOptions) {
        self.appCoordinator?.start()
    }

}

