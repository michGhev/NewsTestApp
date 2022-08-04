//
//  HomeCoordinator.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit


final class HomeCoordinator: Coordinator {
    
    var childrens: [Coordinator] = []
    var navigationController: MGNavigationController
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: MGNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeBuilder.createHomeVC(with: self)
        self.navigationController.pushViewController(homeVC, animated: true)
    }
    
    
    
    func pushDetailedNewsPageVC(pageUrl: String) {
        let detailedNewsPageVC = HomeBuilder.createDetailedNewsPageVC(with: pageUrl, with: self)
        self.navigationController.pushViewController(detailedNewsPageVC, animated: true)
    }
    
    func popHomeController() {
        navigationController.popViewController(animated: true)
    }
}
