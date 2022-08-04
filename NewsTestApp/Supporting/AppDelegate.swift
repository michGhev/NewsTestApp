//
//  AppDelegate.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.prepareWindow(by: application)
      
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    private func prepareWindow(by application: UIApplication) {
        if #available(iOS 13.0, *) {
            
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.appCoordinator = AppCoordinator(window: window!)
            self.appCoordinator?.start()
        }
    }
}

