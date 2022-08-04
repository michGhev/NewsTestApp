//
//  HomeBuilder.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit


protocol HomeBuilderType: AnyObject {
    static func createHomeVC(with coordinator: HomeCoordinator) -> UIViewController
    //static func createFullScreenVC(with coordinator: FullScreenFlow, images: [String], selectedIndexPath: IndexPath) -> UIViewController
}


final class HomeBuilder: HomeBuilderType {
    
    static func createHomeVC(with coordinator: HomeCoordinator) -> UIViewController {
        let homeVC = UIStoryboard.home.instantiateViewController(withIdentifier: HomeControllers.home) as! ViewController
        homeVC.newsViewModel = NewsViewModel(repo: NewsRepo())
        homeVC.coordinator = coordinator
        return homeVC
    }
    
    static func createDetailedNewsPageVC(with pageUrl: String, with coordinator: HomeCoordinator) -> UIViewController {
        let detailedNewsPageVC = UIStoryboard.home.instantiateViewController(withIdentifier: HomeControllers.detailedNews) as! DetailedNewsPageViewController
      //  detailedNewsPageVC.newsViewModel = NewsViewModel(repo: NewsRepo())
        detailedNewsPageVC.pageUrl = pageUrl
        detailedNewsPageVC.coordinator = coordinator
        return detailedNewsPageVC
    }
    //DetailedNewsPageViewController
    
//    static func createFullScreenVC(with coordinator: FullScreenFlow, images: [String], selectedIndexPath: IndexPath) -> UIViewController {
//        let fullScreenVC = UIStoryboard.home.instantiateViewController(withIdentifier: HomeControllers.fullScreen) as! FullScreenController
//        fullScreenVC.coordinator = coordinator
//        fullScreenVC.photoGallery = ABPhotoGallery(photos: images, selectedPhotosIndexPath: selectedIndexPath)
//        return fullScreenVC
//    }
}

