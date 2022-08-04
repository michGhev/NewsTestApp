//
//  BaseViewController.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    //MARK: - Properties -
    
    private var activityIndicatorView : NVActivityIndicatorView!
    private var animatedView : UIView!
    
    
    
    //MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoader()
    }
    
    
    
    //MARK: - Methods -

    private func setupLoader() {
        self.activityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .lineSpinFadeLoader, color: .gray, padding: nil)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func startAnimating(onView: UIView) {
        guard animatedView == nil else {
            return
        }
        animatedView = UIView()
        animatedView.backgroundColor = Colors.backgroundColor
        Helper.addSubview(subView: animatedView, toView: onView)
        animatedView.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            self.activityIndicatorView.widthAnchor.constraint(equalToConstant: 40),
            self.activityIndicatorView.heightAnchor.constraint(equalToConstant: 40),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        if let _ = self.animatedView {
            animatedView.removeFromSuperview()
            animatedView = nil
        }
        self.activityIndicatorView.stopAnimating()
    }
    
    func alert(with title: String?, message: String?, OKButton: @escaping (() -> Void), cancelButton: (() -> Void)? = nil) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertActionOK = UIAlertAction(title: "OK", style: .default) { _ in
            OKButton()
        }
        alertView.addAction(alertActionOK)
        
        if let _ = cancelButton {
            let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { _ in
                cancelButton!()
            }
            alertView.addAction(alertActionCancel)
        }
        present(alertView, animated:true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
}

