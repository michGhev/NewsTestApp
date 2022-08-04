//
//  Coordinator.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit


protocol Coordinator: AnyObject {
    var childrens: [Coordinator] { get set }
    var navigationController: MGNavigationController { get set }
    
    func start()
}
