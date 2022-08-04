//
//  TableViewCell + Extension.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//


import UIKit


protocol CellIdentifiable {
    static var cellIdentifier: String { get }
}

extension CellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: CellIdentifiable {}




