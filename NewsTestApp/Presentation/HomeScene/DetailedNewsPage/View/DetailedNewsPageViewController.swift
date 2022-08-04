//
//  DetailedNewsPageViewController.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit
import WebKit


class DetailedNewsPageViewController: BaseViewController {
    
    //MARK: - Outlets -

    @IBOutlet weak var newsWebWiev: WKWebView!
    
    
    
    //MARK: - Dependencies -
    
    weak var coordinator: HomeCoordinator?
    
    
    
    //MARK: - Properties -

    var pageUrl = ""
    
    
    
    //MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        newsWebWiev.load(URLRequest(url: URL(string: pageUrl)!))
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.coordinator?.popHomeController()
    }
}
