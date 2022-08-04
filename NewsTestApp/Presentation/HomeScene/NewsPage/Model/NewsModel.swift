//
//  NewsModel.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import Foundation
import XMLMapper

struct ResponseModel : Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [NewsModel]?
}

class NewsModel : Decodable, Encodable,XMLMappable {
    var nodeName: String!
    
    
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
    required init?(map: XMLMap) {}

        func mapping(map: XMLMap) {
            title <- (map["title"], XMLCDATATransform())
            description <- (map["description"], XMLCDATATransform())
            url <- map["link"]
            urlToImage <- map["guid"]
            publishedAt <- map["pubDate"]
        }
    
    func getPublishDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let date = dateFormatter.date(from: publishedAt!) else {
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+3")
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
            return dateFormatter.date(from: publishedAt!)!
        }
        return date
    }
}


class BBCNews: XMLMappable {
    var nodeName: String!
    var channel: Channel?
    
    
    required init?(map: XMLMap) {}

        func mapping(map: XMLMap) {
            channel <- map["channel"]
        }
}

class Channel: XMLMappable {
    var nodeName: String!
    
    var item: [NewsModel]?

    
    required init?(map: XMLMap) {}

        func mapping(map: XMLMap) {
            item <- map["item"]
        }
}

