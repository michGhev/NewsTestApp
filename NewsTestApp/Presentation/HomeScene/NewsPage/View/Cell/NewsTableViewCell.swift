//
//  NewsTableViewCell.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import UIKit
import SDWebImage


class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(with model: NewsModel?) {
        guard let model = model else { return }
        self.title.text = model.title
        guard let image = model.urlToImage else {
            self.newsImage.image = UIImage(named: "news-icon-38")
            return
        }
        self.newsImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "news-icon-38.png"))
        self.newsDescription.text = model.description
    }
}
