//
//  MGNavigationController.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit


class MGNavigationController: UINavigationController {
    
    //MARK: - Properties -

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    
    
    //MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar(largeTitleColor: .white,
                                    backgoundColor: Colors.backgroundColor,
                                    tintColor: .white,
                                    title: "Hello world",
                                    preferredLargeTitle: false)
    }
}


//can extend UIViewController as well
extension UINavigationController {
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor, .font: UIFont.boldSystemFont(ofSize: 18)]
            navBarAppearance.backgroundColor = backgoundColor
            
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.compactAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            self.navigationBar.prefersLargeTitles = preferredLargeTitle
            self.navigationBar.isTranslucent = false
            self.navigationBar.tintColor = tintColor
            navigationItem.title = title
        } else {
            // Fallback on earlier versions
            self.navigationBar.barTintColor = backgoundColor
            self.navigationBar.tintColor = tintColor
            self.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
}
