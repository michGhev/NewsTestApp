//
//  BaseViewModel.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import Foundation


protocol BaseViewModel {
    var reachabilityService :ReachabilityService { get  }

}

extension BaseViewModel {
    var reachabilityService :ReachabilityService {
        return ReachabilityService.sharedInstance
    }
}
