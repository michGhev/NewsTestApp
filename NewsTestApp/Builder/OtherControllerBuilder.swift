//
//  OtherControllerBuilder.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit



protocol OtherControllerBuilderType {
    static func createABNav() -> MGNavigationController
}


final class OtherControllerBuilder: OtherControllerBuilderType {
    static func createABNav() -> MGNavigationController {
        let abNavController = UIStoryboard.home.instantiateViewController(withIdentifier: OtherControllers.navigation) as! MGNavigationController
        return abNavController
    }
}
