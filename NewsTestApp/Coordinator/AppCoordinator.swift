//
//  AppCoordinator.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit



final class AppCoordinator: Coordinator {
    private var window: UIWindow?
    var childrens: [Coordinator] = []
    var navigationController: MGNavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = OtherControllerBuilder.createABNav()
        self.navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        let child = HomeCoordinator(navigationController: self.navigationController)
        childrens.append(child)
        child.start()
        
        window?.rootViewController = child.navigationController
        window?.makeKeyAndVisible()
    }
}

