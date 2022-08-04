//
//  NetworkConfig.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import Foundation
import Alamofire

struct Configs {
    
    static var baseUrl = "https://newsapi.org/v2/top-headlines?"

    static func requestHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            ]
        
        return headers
        
    }
    static func getToken() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "x-Api-Key": Settings.getToken(),
            ]
        return headers
        
    }
}

enum ResponseStatus {
    case success
    case failure
}
