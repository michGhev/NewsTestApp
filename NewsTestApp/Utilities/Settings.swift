//
//  Settings.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import Foundation


class Settings {
    static let sharedInstance = Settings()
   
    
    static func getToken() -> String{
       let tokenString = "97ba815035ae4381b223377b2df975ab"
       return tokenString
    }
    
}
