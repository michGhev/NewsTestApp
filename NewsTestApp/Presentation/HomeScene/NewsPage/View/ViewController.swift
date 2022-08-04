//
//  ViewController.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit

class ViewController: BaseViewController {
    //MARK: - Outlets -
    
    @IBOutlet weak var newsTableView: UITableView!
    
    
    
    //MARK: - Dependencies -
    
    var newsViewModel: NewsViewModelType!
    weak var coordinator: HomeCoordinator?
    
    
    
    //MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsViewModel = NewsViewModel(repo: NewsRepo())
        self.newsViewModel.getTotalNews()
        self.bindErrorMessage()
        self.bindMessage()
        self.bindOtherReloadUpdates()
        self.bindShowLoader()
    }
    
    
    
    //MARK: - Actions -
    
    @IBAction func saveDataAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Upload file", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Download as Json", style: .default , handler:{ (UIAlertAction)in
            self.newsViewModel.uploadJsone = true
            self.newsViewModel.createJSONEFile()
        }))
        alert.addAction(UIAlertAction(title: "Download as XML", style: .default , handler:{ (UIAlertAction)in
            self.newsViewModel.uploadJsone = false
            self.newsViewModel.createXMlFile()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default , handler:{ (UIAlertAction)in
            
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    
    //MARK: - Methods -
    
    private func bindOtherReloadUpdates() {
        self.newsViewModel.updateTableView.bind(observer: weaky({ strongSelf, reports in
            self.newsTableView.reloadData()
        }))
    }
    
    private func bindErrorMessage() {
        self.newsViewModel.errorMessage.bind(observer: weaky({ strongSelf, errorMessage in
            self.alert(with: "Info", message: errorMessage!) {
            }
        }))
    }
    
    private func bindMessage() {
        self.newsViewModel.message.bind(observer: weaky({ strongSelf, message in
            self.alert(with: "Info", message: message!) {
            }
        }))
    }
    
    private func bindShowLoader() {
        self.newsViewModel.showLoader.bind { [weak self] in
            guard $0 != nil else { return }
            $0 == true ? self?.startAnimating(onView: (self?.view)!) : self?.stopAnimating()
        }
    }
}

