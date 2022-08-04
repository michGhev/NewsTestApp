//
//  NewsViewController + DataSource.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG: --- FiltersCount: \(self.newsViewModel.getNewsCount()) ---")
        return self.newsViewModel.getNewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: NewsTableViewCell = tableView.dequeReusableCell()
            cell.setCell(with: self.newsViewModel.getNewsBy(indexPath))
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.pushDetailedNewsPageVC(pageUrl: self.newsViewModel.getNewsBy(indexPath).url!)
    }
}
