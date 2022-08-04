//
//  Helper.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit

class Helper: NSObject {

    static func addSubview(subView: UIView, toView view: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subView)
        view.addConstraint(NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0))
        //view.addConstraint(NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: subView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        
    }
    
    static func addSubviewByConstrints(subView: UIView, toView view: UIView, leading: CGFloat, trailing: CGFloat, multiplier: CGFloat?) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subView)
        
        view.addConstraint(NSLayoutConstraint(item: subView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -trailing))
        view.addConstraint(NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: leading))
        if let multiplierValue = multiplier {
            view.addConstraint(NSLayoutConstraint(item: subView, attribute: .width, relatedBy: .equal, toItem: subView, attribute: .height, multiplier: multiplierValue, constant: 0))
        }
        
        view.addConstraint(NSLayoutConstraint(item: subView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0))
        
    }
    
}
