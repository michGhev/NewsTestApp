//
//  TableView + Extensions.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit


extension UITableView {
    func dequeReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.cellIdentifier) as? T else {
            fatalError("Error dequeuing cell for identifier \(T.cellIdentifier)")
        }
        
        return cell
    }
}
