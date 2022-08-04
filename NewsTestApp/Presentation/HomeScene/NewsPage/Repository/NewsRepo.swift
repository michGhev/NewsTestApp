//
//  NewsRepo.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import Foundation
import Alamofire
import XMLMapper


protocol NewsRepoType: AnyObject {
    func getNews(completionHandler: @escaping (ResponseStatus, [NewsModel]?, String?) -> Void)
    func getBBcNews(completionHandler: @escaping (ResponseStatus, [NewsModel]?, String?) -> Void)
}

final class NewsRepo: NewsRepoType {
    func getNews(completionHandler: @escaping (ResponseStatus, [NewsModel]?, String?) -> Void) {
        let url = Configs.baseUrl + "sources=techcrunch"
        let headers: HTTPHeaders = Configs.getToken()
        AF.request(url, method: .get, encoding: JSONEncoding.default,headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let response = (response.value as? NSDictionary) {
                        var orderData = ResponseModel()
                        let jsonDecoder = JSONDecoder()
                        let ordersData = try? JSONSerialization.data(withJSONObject: response, options: [])
                        orderData = try! jsonDecoder.decode(ResponseModel.self, from: ordersData!)
                        completionHandler(.success, orderData.articles!, nil)
                    } else {
                        completionHandler(.failure, nil, "No news for show")
                    }
                case .failure:
                    completionHandler(.failure, nil ,"No news for show")
                }
            }
    }
    
    func getBBcNews(completionHandler: @escaping (ResponseStatus, [NewsModel]?, String?) -> Void) {
        let urlBBc = "http://feeds.bbci.co.uk/news/video_and_audio/technology/rss.xml"
        AF.request(urlBBc).responseXMLObject { (response: AFDataResponse<BBCNews>) in
            switch response.result {
            case .success:
                let bbcNews = response.value
                completionHandler(.success, bbcNews?.channel?.item, nil)
            case .failure(let error):
                completionHandler(.failure, nil, "No news for show")
                print(error)
            }
        }
    }
}
